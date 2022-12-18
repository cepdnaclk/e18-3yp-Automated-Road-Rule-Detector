const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const db = admin.firestore();

exports.getData = functions.https.onRequest((req, res) => {
  const docRef = db.collection("user").doc("8Y11BIahGrS2NDwcUlAa");
  const getDoc = docRef.get()
    .then(doc => {
      if (!doc.exists) {
        console.log('No such document!');
        return res.send('Not Found')
      } 
        console.log(doc.data());
        return res.send(doc.data());
    })
    .catch(err => {
      console.log('Error getting document', err);
    });
 });
