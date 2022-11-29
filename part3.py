import matplotlib.pylab as plt
import cv2
import numpy as np

# A function to mask everything other than our region of interest
def region_of_interest(img, vertices):
    mask = np.zeros_like(img)
    # channel_count = img.shape[2]
    # Create a match color
    match_mask_color = 255
    # Fill the polygon to mask
    cv2.fillPoly(mask, vertices, match_mask_color)
    # Return the image only where the masked pixel matches
    masked_image = cv2.bitwise_and(img, mask)

    return masked_image

# A function to draw lines
def draw_the_lines(img, line_vectors):
    # Make a copy of the image passed
    img = np.copy(img)
    # Create a blank image that matches the original image size
    blank_image = np.zeros((img.shape[0], img.shape[1], 3), dtype=np.uint8)

    # Loop around the line vectors and draw the lines
    for line in line_vectors:
        for x1, y1, x2, y2 in line:
            cv2.line(blank_image, (x1,y1), (x2,y2), (0, 255, 0), thickness=3)

    # Merge the image with lines into the original image
    img = cv2.addWeighted(img, 0.8, blank_image, 1, 0.0)
    return img


# load an image
# image = cv2.imread('road.jpg')

# Convert image to RGB format as we are going to load the
# image using matplotlib
# image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

# A function to process a video
def process(image):

    # Get the width and height of the image
    print(image.shape)
    height = image.shape[0]
    width = image.shape[1]

    # Define the region of interest
    region_of_interest_vertices = [
        (0, height),
        (width/2, height/1.2),
        (width,height)
    ]

    # First get a gray scale image to find out edges in the image
    gray_image = cv2.cvtColor(image, cv2.COLOR_RGB2GRAY)
    ret, thresholded = cv2.threshold(gray_image, 120, 255, cv2.THRESH_BINARY)

    # Find out edges
    canny_image = cv2.Canny(thresholded, 100, 200)

    # Use the method defined above to crop the image 
    cropped_image = region_of_interest(canny_image, 
                    np.array([region_of_interest_vertices], np.int32))

    # Probabilistic half line transform
    # It will return the line vector of the lines in our image
    lines = cv2.HoughLinesP(cropped_image,
                    rho=6,
                    theta=np.pi/60,
                    threshold=160,
                    lines=np.array([]),
                    minLineLength=40,
                    maxLineGap=25)

    image_with_lines = draw_the_lines(image, lines)
    return image_with_lines



# Load our image using plt.imshow method
# plt.imshow(image_with_lines)
# plt.show()

cap = cv2.VideoCapture('test.mp4')

while(cap.isOpened()):
    # Read every frame
    ret, frame = cap.read()



    frame = process(frame)
    cv2.imshow('frame', frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break


cap.release()
cv2.destroyAllWindows()