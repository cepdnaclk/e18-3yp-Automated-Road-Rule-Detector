# import requests


# typeofline = "dash"
# distance = 10
# pvalue = 2

# url = "https://us-central1-cop-mate.cloudfunctions.net/addBreaking?licenseplatenumber=KJ-1111&typeofline=%s&distance=%s&pvalue=%s"%(typeofline, distance, pvalue)
# response = requests.get(url)
# print(response)

# # import json
# # import urllib.request
# # conditionsSetURL = "https://us-central1-cop-mate.cloudfunctions.net/addBreaking"
# # newConditions = {"con1":40, "con2":20, "con3":99, "con4":40, "password":"1234"} 
# # params = json.dumps(newConditions)
# # req = urllib.request.Request(conditionsSetURL, data=json.dumps(newConditions))
# # response = urllib.request.urlopen(req)
# # print(response.read().decode('utf8'))



import RPi.GPIO as GPIO
import time
GPIO.setmode(GPIO.BCM)

TRIG = 23
ECHO = 24

print("Distance Measurement In Progress")

GPIO.setup(TRIG,GPIO.OUT)
GPIO.setup(ECHO,GPIO.IN)
try:
    while True:
        
        GPIO.output(TRIG, False)
        print("Waiting For Sensor To Settle")
        time.sleep(2)
        
        GPIO.output(TRIG, True)
        time.sleep(0.00001)
        GPIO.output(TRIG, False)
        
        while GPIO.input(ECHO)==0:
            pulse_start = time.time()
        
        while GPIO.input(ECHO)==1:
            pulse_end = time.time()
        
        pulse_duration = pulse_end - pulse_start
        
        distance = pulse_duration * 17150
        
        distance = round(distance, 2)
        
        print("Distance: ",distance,"cm")
        
except KeyboardInterrupt: # If there is a KeyboardInterrupt (when you press ctrl+c), exit the program
    print("Cleaning up!")
    gpio.cleanup()
