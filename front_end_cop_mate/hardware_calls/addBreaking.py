import requests


typeofline = "dash"
distance = 10
pvalue = 2

url = "https://us-central1-cop-mate.cloudfunctions.net/addBreaking?licenseplatenumber=KJ-1111&typeofline=%s&distance=%s&pvalue=%s"%(typeofline, distance, pvalue)
response = requests.get(url)
print(response)

# import json
# import urllib.request
# conditionsSetURL = "https://us-central1-cop-mate.cloudfunctions.net/addBreaking"
# newConditions = {"con1":40, "con2":20, "con3":99, "con4":40, "password":"1234"} 
# params = json.dumps(newConditions)
# req = urllib.request.Request(conditionsSetURL, data=json.dumps(newConditions))
# response = urllib.request.urlopen(req)
# print(response.read().decode('utf8'))