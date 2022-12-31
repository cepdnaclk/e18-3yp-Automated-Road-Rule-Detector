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
    
    // Get the breaking list with the ID
    const documents = [];
    breakings.forEach(doc => {
      const document = { [doc.id]: doc.data() };
      documents.push(document);
    });

    return res.status(200).send(documents);

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

exports.updateVehicle = functions.https.onRequest(async (req, res) => {
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

exports.deleteVehicle = functions.https.onRequest(async (req, res) => {
  try{
    const plateNumber = req.url.split("/")[1].split("=")[1];
    const vehicle = await db.collection('vehicle').doc(plateNumber).delete();
    const response = vehicle.data();
    
    return res.status(200).send(
      response
    );
  } catch(error){
    res.send(error);
  }
});

exports.getFrequency = functions.https.onRequest(async (req, res) => {
  try{
    // Get the time stamp of the date sent
    const dateParameter = req.url.split("/")[1].split("=")[1];
    const date = new Date(dateParameter);
    const dateTimeStamp = admin.firestore.Timestamp.fromDate(date);

    // Time stamp of the next day
    const dateNext = new Date(dateParameter);
    dateNext.setDate(dateNext.getDate() + 1);
    const dateTimeStampNext = dateNext.getTime();
    const nextdateTimeStamp = admin.firestore.Timestamp.fromDate(dateNext);

    // Get all breakings of that day
    const breakings = await db.collection('breaking').where('datetime','>=',dateTimeStamp).where('datetime', '<=', nextdateTimeStamp).get();
    const response = breakings.docs.map(doc => doc.data());
    
    var timePeriods = [{
                          dash: 0,
                          single: 0,
                          double: 0
                        },{
                          dash: 0,
                          single: 0,
                          double: 0
                        },{
                          dash: 0,
                          single: 0,
                          double: 0
                        },{
                          dash: 0,
                          single: 0,
                          double: 0
                        },{
                          dash: 0,
                          single: 0,
                          double: 0
                        },{
                          dash: 0,
                          single: 0,
                          double: 0
                        }];
    

    for(let i = 0; i < response.length; i++){
      
      // Get the time of day of the breaking
      var hours = response[i].datetime.toDate().getHours();
      if(response[i].datetime.toDate().getMinutes() + 30 >= 60){
        hours = hours + 6;
      }else{
        hours = hours + 5;
      }

      // Update the line break frequency
      if(response[i].typeofline == "dash"){
        timePeriods[hours/4 >> 0].dash = timePeriods[hours/4 >> 0].dash + 1;
      }else if(response[i].typeofline == "single"){
        timePeriods[hours/4 >> 0].single = timePeriods[hours/4 >> 0].single + 1;
      }else if(response[i].typeofline == "double"){
        timePeriods[hours/4 >> 0].double = timePeriods[hours/4 >> 0].double + 1;
      }
    }

    return res.send(
      timePeriods
    );
  } catch(error){
    res.send(error);
  }
});

exports.dayBreakings = functions.https.onRequest(async (req, res) => {
  try{
    // Get the time stamp of the date sent
    const dateParameter = req.url.split("/")[1].split("=")[1];
    const date = new Date(dateParameter);
    const dateTimeStamp = admin.firestore.Timestamp.fromDate(date);

    // Time stamp of the next day
    const dateNext = new Date(dateParameter);
    dateNext.setDate(dateNext.getDate() + 1);
    const dateTimeStampNext = dateNext.getTime();
    const nextdateTimeStamp = admin.firestore.Timestamp.fromDate(dateNext);

    // Get all breakings of that day
    const breakings = await db.collection('breaking').where('datetime','>=',dateTimeStamp).where('datetime', '<=', nextdateTimeStamp).get();
    const response = breakings.docs.map(doc => doc.data());

    return res.send(
      response
    );
  } catch(error){
    res.send(error);
  }
});

exports.addBreaking = functions.https.onRequest(async (req, res) => {
  try{
    
    const vehicleJson = {
      datetime: admin.firestore.FieldValue.serverTimestamp(),
      licenseplatenumber: req.body.licenseplatenumber,
      typeofline: req.body.typeofline,
      distance: req.body.distance,
      pvalue: req.body.pvalue
    }

    const usersDb = db.collection('breaking');
    const response = await usersDb.doc().set(vehicleJson);
    // response.update({id: increment});
    res.send(response);
  } catch(error){
    res.send(error);
  }
  
});