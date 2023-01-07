import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import os



# initializations 
file_path = os.path.join(os.path.dirname(os.path.abspath(__file__)),"serviceAccKey.json")
cred = credentials.Certificate(file_path)
firebase_admin.initialize_app(cred)
db = firestore.client()


#adding first data
doc_ref = db.collection('breaking').document('ID0002')

doc_ref.set({

    'distance':'60',
    'licenseplatenumber':'HH-6666',
    'location':'7.55, 55.5',
    'pvalue' : '24',
    'typeofline' : 'single line'


})

