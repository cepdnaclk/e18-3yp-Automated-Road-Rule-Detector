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


# load an image
image = cv2.imread('road.jpg')

# Convert image to RGB format as we are going to load the
# image using matplotlib
image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

# Get the width and height of the image
print(image.shape)
height = image.shape[0]
width = image.shape[1]

# Define the region of interest
region_of_interest_vertices = [
    (100, height),
    (width, 0),
    (width,height)
]

cropped_image = region_of_interest(image, 
                np.array([region_of_interest_vertices], np.int32))



# Load our image using plt.imshow method
plt.imshow(cropped_image)
plt.show()
