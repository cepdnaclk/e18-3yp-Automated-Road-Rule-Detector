import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import os
import re 



# initializations 
file_path = os.path.join(os.path.dirname(os.path.abspath(__file__)),"serviceAccKey.json")
cred = credentials.Certificate(file_path)
firebase_admin.initialize_app(cred)
db = firestore.client()


#adding first data
# test_str = 'HH-6666-2'

# res = re.sub(r'[0-9]+$',
#              lambda x: f"{str(int(x.group())+1).zfill(len(x.group()))}",
#              test_str)

doc_ref = db.collection('breaking')

# test_str = res 

doc_ref.add({

    'distance':'60',
    'licenseplatenumber':'HH-5555',
    'location':'7.55, 55.5',
    'pvalue' : '24',
    'typeofline' : 'single line'


})

