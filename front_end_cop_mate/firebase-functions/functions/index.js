// The Cloud Functions for Firebase SDK to create Cloud Functions and set up triggers.
const functions = require('firebase-functions');

// The Firebase Admin SDK to access Firestore.
const admin = require('firebase-admin');
const serviceAccount = require("./serviceAccountKey.json");
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

exports.addUser = functions.https.onRequest(async (req, res) => {
  const usersDb = db.collection('user');
  const liam = usersDb.doc('Try once more');  
  await liam.set({
    name: "Saadia Jameel at this place"
  });
  res.send('OK');
});

exports.addVehicle = functions.https.onRequest(async (req, res) => {
  try{
    const id = req.body.licenseplatenumber;
    const vehicleJson = {
      email: req.body.email,
      licenseplatenumber: req.body.licenseplatenumber,
      nic: req.body.nic,
      owner: req.body.owner,
      telephone: req.body.telephone
    }
    const usersDb = db.collection('vehicle');
    const response = await usersDb.doc(id).set(vehicleJson);
    res.send(response);
  } catch(error){
    res.send(error);
  }
  
});

exports.getVehicle = functions.https.onRequest(async (req, res) => {
  try{
    const plateNumber = req.url.split("/")[1].split("=")[1];
    const vehicle = await db.collection('vehicle').doc(plateNumber).get();
    const response = vehicle.data();
    
    return res.status(200).send(
      response
    );
  } catch(error){
    res.send(error);
  }
});

exports.getBreakingList = functions.https.onRequest(async (req, res) => {
  try{
    const plateNumber = req.url.split("/")[1].split("=")[1];
    const breakings = await db.collection('breaking').where('licenseplatenumber','==', plateNumber).get();
    const response = breakings.docs.map(doc => doc.data());
    return res.status(200).send(response);
  } catch(error){
    res.send(error);
  }
});

exports.getVehicleList = functions.https.onRequest(async (req, res) => {
  try{
    const breakings = await db.collection('vehicle').get();
    const response = breakings.docs.map(doc => doc.data());
    return res.status(200).send(response);
  } catch(error){
    res.send(error);
  }
});

exports.getBreaking = functions.https.onRequest(async (req, res) => {
  try{
    const licenseplatenumber = req.url.split("/")[1].split("=")[2];
    const datetime = req.url.split("/")[1].split("=")[1].split("&")[0];
    const breakings = await db.collection('breaking').where('licenseplatenumber','==', licenseplatenumber).where('datetime','==', datetime).get();
    const response = breakings.docs.map(doc => doc.data())[0];

    return res.status(200).send(
      response
    );
  } catch(error){
    res.send(error);
  }
});
