# import cv2
# import numpy as np
# import time
# from controls import Controls
# import requests

# cap = cv2.VideoCapture("test.mp4")

# # cap = cv2.VideoCapture(0)

# # cap.set(3, 256) #horizontal
# # cap.set(4, 144)

# scan_line_pos = []

# NUM_LINES = 10

# PI = False
# DEBUG = True

# if PI == True:
#     import RPi.GPIO as GPIO
            

# controls = Controls()
# controls.newControl("thresh", 0, 255, 17)


# def text(image, x,y, text):
#     font = cv2.FONT_HERSHEY_SIMPLEX
#     cv2.rectangle(image, (x, y), (x+50, y-20), (0,0,0),-1)
#     cv2.putText(image, str(text), (x, y), font, 0.5, (0, 255, 0), 1, cv2.LINE_AA,)    


# x = np.arange(-2, 2, 0.1)

# def bell_curve(x):
#     mean = np.mean(x)
#     std = np.std(x)
#     y_out = 1/(std * np.sqrt(2 * np.pi)) * np.exp( - (x - mean)**2 / (2 * std**2))
#     return y_out

# def gen_line_pos(img_shape):
    
#     step = (img_shape)/(NUM_LINES+1)
#     for i in range(0,NUM_LINES):
#         scan_line_pos.append(int(i*step + step))

# def draw_lines(img, lines, points):

#     print("START FRAME")

#     typeofline = ""
#     distance = 0
#     pvalue = 0


#     # Variables used to detect the type of line
#     dashedLine = 0
#     singleLine = 0
#     doubleLine = 0

#     crossedAmount = 0
#     lineNumber = 0
#     flag = 0
#     sendRequestFlag = 0
    
#     for i in range(NUM_LINES):

#         count = 0
#         value = int((points[i][1]/2100)*255)
#         color = (0,0,255)
#         if value>200:
#             count = count + 1
#             color = (0,255,0)

#         # print(value)
#         line = lines[i]

#         # print(count)
#         if(count == 0):
#             dashedLine = 1
#         elif(count == 1):
#             singleLine = 1
#         elif(count == 2):
#             doubleLine = 1

#         cv2.line(img, (line, 0), (line, img.shape[1]), (100, 12, 255), 2)
#         cv2.circle(img, (line, int(points[i][0]-20)), 5, color,-1)
#         crossedAmount = int(points[i][0]-20)

#         if(crossedAmount > 65):
#             sendRequestFlag = 1

#         if (lineNumber == 3 and crossedAmount < 65):
#             flag = 1
        

#     print(dashedLine)
#     print(singleLine)
#     print(doubleLine)

#     # At the end of the 10 lines in that frame, determine the type of line
#     if((dashedLine == 1 and singleLine == 1 and doubleLine == 0) ):
#         typeofline = "dash"
#         print("dashed line")
#     elif(dashedLine == 0 and singleLine == 1 and doubleLine == 0):
#         typeofline = "single"
#         print("single line")
#     elif(dashedLine == 0 and singleLine == 0 and doubleLine == 1):
#         typeofline = "double"
#         print("double line")
#     elif(dashedLine == 0 and singleLine == 1 and doubleLine == 1):
#         typeofline = "dashsingle"
#         print("dashed single line")

#     if(flag == 1 and sendRequestFlag == 1):
#         # Send hardware details to the database
#         url = "https://us-central1-cop-mate.cloudfunctions.net/addBreaking?licenseplatenumber=KJ-1111&typeofline=%s&distance=%s&pvalue=%s"%(typeofline, crossedAmount, pvalue)
#         response = requests.get(url)
#         print(response)
#         sendRequestFlag = 0

    

#     print("END FRAME")
    
# def detect_line(scan_line):

#     conv = np.convolve(bell, scan_line)
#     max_value = np.max(conv)
#     max_point = np.argmax(conv)
#     return [max_point, max_value]

# bell = bell_curve(x)
# ret, img = cap.read()

# print(img.shape)

# gen_line_pos(img.shape[1])


# while True:
#     t1 = time.time()
#     ret, img = cap.read()

#     gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    
#     points = []
#     for i in range(NUM_LINES):
#         scan_line = gray[:, scan_line_pos[i]]
#         point = detect_line(scan_line)
#         points.append(point)
        
    
#     # print(scan_line.shape, conv.shape)
    
#     draw_lines(img, scan_line_pos, points)
#     if DEBUG:
#         # cv2.imshow("conv", conv)
#         cv2.imshow("img", img)
#         # cv2.imshow("red", red_erosion)img
#         # cv2.imshow("input", img)

#     key = cv2.waitKey(10)
#     t2 = time.time()

#     elpsed_frametime = (t2 - t1)
 
import cv2
import numpy as np
import time
from controls import Controls
import requests

# cap = cv2.VideoCapture("test.mp4")

cap = cv2.VideoCapture(0)

# cap.set(3, 256) #horizontal
# cap.set(4, 144)

scan_line_pos = []

NUM_LINES = 10

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

def bell_curve(x):
    mean = np.mean(x)
    std = np.std(x)
    y_out = 1/(std * np.sqrt(2 * np.pi)) * np.exp( - (x - mean)**2 / (2 * std**2))
    return y_out

def gen_line_pos(img_shape):
    
    step = (img_shape)/(NUM_LINES+1)
    for i in range(0,NUM_LINES):
        scan_line_pos.append(int(i*step + step))


def draw_lines(img, lines, points, sendFlag, queue):

    # print(sendRequestFlag)

    print("START FRAME")

    # Variable for get request 
    typeofline =  ""
    pvalue = 0
    crossedAmount = 0
    lineNumber = 0
    flag = 0
    lineInFrame = 0


    # Variables used to detect the type of line
    dashedLine = 0
    singleLine = 0
    doubleLine = 0
    
    for i in range(NUM_LINES):

        lineNumber = lineNumber + 1
        lineInFrame = 0

        count = 0
        value = int((points[i][1]/2100)*255)
        # print(int(points[i][1]))
        # print(value)
        valueDouble = int((points[i][1] + 200)/2100*255)
        # print(int(points[i][1] + 100))
        # print(valueDouble)

        color = (0,0,255)
        colorDouble  = (0,0,255)
        # print(color)
        # print(colorDouble)
        if value>150:
            # print(value)
            # if valueDouble > 150:
                # count = 2
                # colorDouble = (0,255,0)
            # else:
                # count = count + 1
            # print(valueDouble)
            lineInFrame = 1
            # print(lineInFrame)
            count = count + 1
            color = (0,255,0)

        # print("normal")
        # print(value)
        # print(color)
        # print("double")
        # print(valueDouble)
        # print(colorDouble)
        # print(value)
        line = lines[i]

        # print(count)
        if(count == 0):
            dashedLine = 1
        elif(count == 1):
            singleLine = 1
        elif(count == 2):
            doubleLine = 1

        # print(colorDouble)
        cv2.line(img, (line, 0), (line, img.shape[1]), (100, 12, 255), 2)
        # cv2.circle(img, (line, int(points[i][0] + 80)), 5, colorDouble,-1)
        cv2.circle(img, (line, int(points[i][0]-20)), 5, color,-1)
        crossedAmount = int(points[i][0]-20)
        # print(crossedAmount)

        if(lineNumber >= 3 and lineInFrame == 1 and crossedAmount > 65):
            sendFlag = 1
            # print(sendFlag)

        if (lineNumber >= 3 and lineInFrame == 1 and crossedAmount < 65):
            flag = 1
            # print(flag)
        

    # print(dashedLine)
    # print(singleLine)
    # print(doubleLine)
    # typeofline = "Hi"
    # At the end of the 10 lines in that frame, determine the type of line
    if((dashedLine == 1 and singleLine == 1 and doubleLine == 0) ):
        typeofline = "dash"
#         print("dashed line")
    elif(dashedLine == 0 and singleLine == 1 and doubleLine == 0):
        typeofline = "single"
#         print("single line")
    elif(dashedLine == 0 and singleLine == 0 and doubleLine == 1):
        typeofline = "double"
#         print("double line")
    elif(dashedLine == 0 and singleLine == 1 and doubleLine == 1):
        typeofline = "dashsingle"
#         print("dashed single line")
    else:
        typeofline = "noline"

    if(flag == 1 and sendFlag == 1):
        # Send hardware details to the database
        # url = "https://us-central1-cop-mate.cloudfunctions.net/addBreaking?licenseplatenumber=KJ-1111&typeofline=%s&distance=%s&pvalue=%s"%(typeofline, crossedAmount, pvalue)
        # response = requests.get(url)
        # print(response)
        # print("crossed")
        sendFlag = 0
    print(typeofline)
    if(len(queue) == 10):
        queue.pop(0)
        queue.append(typeofline)
    else:
        queue.append(typeofline)

    print(queue)
    print(queue[len(queue)-1])
    print("END FRAME")
    return sendFlag
    
def detect_line(scan_line):

    conv = np.convolve(bell, scan_line)
    max_value = np.max(conv)
    max_point = np.argmax(conv)
    return [max_point, max_value]

bell = bell_curve(x)
ret, img = cap.read()

print(img.shape)

gen_line_pos(img.shape[1])

sendRequestFlag = 0

queue = []
# print(sendRequestFlag)

while True:

    # print("START")
    t1 = time.time()
    ret, img = cap.read()

    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    
    points = []
    for i in range(NUM_LINES):
        scan_line = gray[:, scan_line_pos[i]]
        point = detect_line(scan_line)
        points.append(point)
        
    
    # print(scan_line.shape, conv.shape)
    # print(sendRequestFlag)
    sendRequestFlag = draw_lines(img, scan_line_pos, points, sendRequestFlag, queue)
    # print(sendRequestFlag)
    if DEBUG:
        # cv2.imshow("conv", conv)
        cv2.imshow("img", img)
        # cv2.imshow("red", red_erosion)img
        # cv2.imshow("input", img)

    key = cv2.waitKey(10)
    t2 = time.time()

    elpsed_frametime = (t2 - t1)

    # print("END")
 


# ##### working pi code

# import cv2
# import numpy as np
# import time
# from controls import Controls
# import requests

# # cap = cv2.VideoCapture("test.mp4")

# cap = cv2.VideoCapture(0)

# cap.set(3, 256) #horizontal
# cap.set(4, 144)

# scan_line_pos = []

# NUM_LINES = 10

# PI = False
# DEBUG = True

# if PI == True:
#     import RPi.GPIO as GPIO
            

# controls = Controls()
# controls.newControl("thresh", 0, 255, 17)


# def text(image, x,y, text):
#     font = cv2.FONT_HERSHEY_SIMPLEX
#     cv2.rectangle(image, (x, y), (x+50, y-20), (0,0,0),-1)
#     cv2.putText(image, str(text), (x, y), font, 0.5, (0, 255, 0), 1, cv2.LINE_AA,)    


# x = np.arange(-2, 2, 0.1)

# def bell_curve(x):
#     mean = np.mean(x)
#     std = np.std(x)
#     y_out = 1/(std * np.sqrt(2 * np.pi)) * np.exp( - (x - mean)**2 / (2 * std**2))
#     return y_out

# def gen_line_pos(img_shape):
    
#     step = (img_shape)/(NUM_LINES+1)
#     for i in range(0,NUM_LINES):
#         scan_line_pos.append(int(i*step + step))

# def draw_lines(img, lines, points):

#     print("START FRAME")

#     typeofline = ""
#     distance = 0
#     pvalue = 0


#     # Variables used to detect the type of line
#     dashedLine = 0
#     singleLine = 0
#     doubleLine = 0

#     crossedAmount = 0
#     lineNumber = 0
#     flag = 0
#     sendRequestFlag = 0
    
#     for i in range(NUM_LINES):

#         count = 0
#         value = int((points[i][1]/2100)*255)
#         color = (0,0,255)
#         if value>150:
#             count = count + 1
#             color = (0,255,0)

#         # print(value)
#         line = lines[i]

#         # print(count)
#         if(count == 0):
#             dashedLine = 1
#         elif(count == 1):
#             singleLine = 1
#         elif(count == 2):
#             doubleLine = 1

#         cv2.line(img, (line, 0), (line, img.shape[1]), (100, 12, 255), 2)
#         cv2.circle(img, (line, int(points[i][0]-20)), 5, color,-1)
#         crossedAmount = int(points[i][0]-20)
#         print(crossedAmount)

#         if(crossedAmount > 65):
#             sendRequestFlag = 1

#         if (lineNumber == 3 and crossedAmount < 65):
#             flag = 1
        

# #     print(dashedLine)
# #     print(singleLine)
# #     print(doubleLine)

#     # At the end of the 10 lines in that frame, determine the type of line
#     if((dashedLine == 1 and singleLine == 1 and doubleLine == 0) ):
#         typeofline = "dash"
# #         print("dashed line")
#     elif(dashedLine == 0 and singleLine == 1 and doubleLine == 0):
#         typeofline = "single"
# #         print("single line")
#     elif(dashedLine == 0 and singleLine == 0 and doubleLine == 1):
#         typeofline = "double"
# #         print("double line")
#     elif(dashedLine == 0 and singleLine == 1 and doubleLine == 1):
#         typeofline = "dashsingle"
# #         print("dashed single line")

#     if(flag == 1 and sendRequestFlag == 1):
#         # Send hardware details to the database
#         url = "https://us-central1-cop-mate.cloudfunctions.net/addBreaking?licenseplatenumber=KJ-1111&typeofline=%s&distance=%s&pvalue=%s"%(typeofline, crossedAmount, pvalue)
#         response = requests.get(url)
#         print(response)
#         sendRequestFlag = 0

    

#     print("END FRAME")
    
# def detect_line(scan_line):

#     conv = np.convolve(bell, scan_line)
#     max_value = np.max(conv)
#     max_point = np.argmax(conv)
#     return [max_point, max_value]

# bell = bell_curve(x)
# ret, img = cap.read()

# print(img.shape)

# gen_line_pos(img.shape[1])


# while True:
#     t1 = time.time()
#     ret, img = cap.read()

#     gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    
#     points = []
#     for i in range(NUM_LINES):
#         scan_line = gray[:, scan_line_pos[i]]
#         point = detect_line(scan_line)
#         points.append(point)
        
    
#     # print(scan_line.shape, conv.shape)
    
#     draw_lines(img, scan_line_pos, points)
#     if DEBUG:
#         # cv2.imshow("conv", conv)
#         cv2.imshow("img", img)
#         # cv2.imshow("red", red_erosion)img
#         # cv2.imshow("input", img)

#     key = cv2.waitKey(10)
#     t2 = time.time()

#     elpsed_frametime = (t2 - t1)
 






