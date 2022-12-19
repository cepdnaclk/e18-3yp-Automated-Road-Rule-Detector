import cv2
import numpy as np
import time
from controls import Controls

cap = cv2.VideoCapture("test.mp4")

scan_line_pos = []

NUM_LINES = 20

PI = False
DEBUG = True

if PI == True:
    import RPi.GPIO as GPIO
            

controls = Controls()
controls.newControl("thresh", 0, 255, 17)


def text(image, x,y, text):
    font = cv2.FONT_HERSHEY_SIMPLEX
    cv2.rectangle(image, (x, y), (x+50, y-20), (0,0,0),-1)
    cv2.putText(image, str(text), (x, y), font, 0.5, (0, 255, 0), 1, cv2.LINE_AA,)    


x = np.arange(-2, 2, 0.1)

# Get a normally distributed function for a set of values
# Return the standard normal values for each element in x
def bell_curve(x):
    mean = np.mean(x)
    std = np.std(x)
    y_out = 1/(std * np.sqrt(2 * np.pi)) * np.exp( - (x - mean)**2 / (2 * std**2))
    # Returns an array of normalized values
    return y_out

# Generate points to draw the vertical lines
def gen_line_pos(img_shape):
    step = (img_shape)/(NUM_LINES+1)
    # Update the array with points to draw the line
    for i in range(0,NUM_LINES):
        scan_line_pos.append(int(i*step + step))

# A function to draw lines
# img: The frames of the video
# lines: The normalized values 
# points: The points where the lane is detected
def draw_lines(img, lines, points):

    print("START FRAME")
    # Variables used to detect the type of line
    dashedLine = 0
    singleLine = 0
    doubleLine = 0
    
    # For all vertical lines scanned
    for i in range(NUM_LINES):
        count = 0
        
        value = int((points[i][1]/2100)*255)
        color = (0,0,255)
        if value>200:
            count = count + 1
            color = (0,255,0)

        
        line = lines[i]
        # print(count)
        if(count == 0):
            dashedLine = 1
        elif(count == 1):
            singleLine = 1
        elif(count == 2):
            doubleLine = 1
        
        cv2.line(img, (line, 0), (line, img.shape[1]), (100, 12, 255), 2)
        cv2.circle(img, (line, int(points[i][0]-20)), 5, color,-1)
    
    print(dashedLine)
    print(singleLine)
    print(doubleLine)

    # At the end of the 10 lines in that frame, determine the type of line
    if(dashedLine == 1 and singleLine == 1 and doubleLine == 0):
        print("dashed line")
    elif(dashedLine == 0 and singleLine == 1 and doubleLine == 0):
        print("single line")
    elif(dashedLine == 0 and singleLine == 0 and doubleLine == 1):
        print("double line")
    elif(dashedLine == 0 and singleLine == 1 and doubleLine == 1):
        print("dashed single line")

    print("END FRAME")

# Detect a line on the road
def detect_line(scan_line):

    conv = np.convolve(bell, scan_line)

    max_value = np.max(conv)
    max_point = np.argmax(conv)

    # Return the point where a line was detected
    return [max_point, max_value]


bell = bell_curve(x)
ret, img = cap.read()

print(img.shape)

gen_line_pos(img.shape[1])


while True:
    t1 = time.time()
    ret, img = cap.read()

    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    
    points = []
    for i in range(NUM_LINES):
        scan_line = gray[:, scan_line_pos[i]]
        point = detect_line(scan_line)
        points.append(point)
        
    # print(scan_line.shape, conv.shape)
    
    draw_lines(img, scan_line_pos, points)
    if DEBUG:
        # cv2.imshow("conv", conv)
        cv2.imshow("img", img)
        # cv2.imshow("red", red_erosion)img
        # cv2.imshow("input", img)

    key = cv2.waitKey(10)
    t2 = time.time()

    elapsed_frametime = (t2 - t1)
 


