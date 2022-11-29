import cv2

cap = cv2.VideoCapture("test.mp4")

while True:
    _, image = cap.read()
    

    copy = image.copy()
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    Gaussian = cv2.GaussianBlur(image, (3,3), 0) 

    adp_thresholded = cv2.adaptiveThreshold(gray, 255, cv2.ADAPTIVE_THRESH_MEAN_C, cv2.THRESH_BINARY, 33, 10)
    ret, thresholded = cv2.threshold(gray, 120, 255, cv2.THRESH_BINARY)
    canny = cv2.Canny(adp_thresholded, 120, 200)
    contours, hierarchy = cv2.findContours(adp_thresholded, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
    # epsilon = (control_values['epsilon']/2550)* cv2.arcLength(c, True)
    # poly = 
    
    cv2.drawContours(copy, contours, -1, (100,255,0), 2)
    # cv2.imshow("image", image)
    # cv2.imshow("gaussian",image)
    # cv2.imshow("thresh_adaptive", adp_thresholded)
    cv2.imshow("thresh", thresholded)
    # cv2.imshow("contours", copy)
    cv2.waitKey(30)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break