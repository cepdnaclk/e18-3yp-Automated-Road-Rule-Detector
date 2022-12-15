
import cv2
import numpy as np

class Controls:
    def __init__(self) -> None:

        cv2.namedWindow('Controls', cv2.WINDOW_NORMAL)  #--- window to have all the controls
        
        self.controls = []

    def newControl(self, name, min, max, default):
        cv2.createTrackbar(name, "Controls", min, max, self.nothing)
        cv2.setTrackbarPos(name, "Controls", default)
        self.controls.append(name)

    def getValues(self):
        dict = {}
        for c in self.controls:
            dict[c] = cv2.getTrackbarPos(c, "Controls") 
        return dict

    def nothing(self, x):
        pass
    
   
