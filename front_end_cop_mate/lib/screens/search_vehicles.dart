import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front_end_cop_mate/models/Breaking.dart';
import 'package:front_end_cop_mate/screens/vehicle_analyze.dart';
import 'package:front_end_cop_mate/models/Vehicle.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class search_vehciles extends StatefulWidget {
  static const String id = 'search_vehicles';

  @override
  State<search_vehciles> createState() => _search_vehcilesState();
}

class _search_vehcilesState extends State<search_vehciles> {
  bool showSpinner = false;

  List<Vehicle> vehicles = [
    // const Vehicle(
    //   vehiclenumber: "CBL-8999",
    //   name: "Amaratunge",
    //   email: "thamish123@gmail.com",
    //   telephone: "0771515145",
    //   breakings: [
    //     Breaking(
    //         vehiclenumber: "cd",
    //         breakingnumber: "",
    //         pvalue: "",
    //         type: "",
    //         location: "",
    //         distance: "",
    //         dateandtime: "")
    //   ],
    // ),
  ];

  List<Vehicle> vehiclesDup = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    String urlvehices =
        "https://us-central1-cop-mate.cloudfunctions.net/getVehicleList";
    final response = await http.get(Uri.parse(urlvehices));

    String data = response.body;
    var decodeData = jsonDecode(data);

    if (response.statusCode == 200) {
      List<dynamic> vehiclesdata = jsonDecode(response.body);

      vehiclesdata.forEach((item) {
        if (item['licenseplatenumber'] != null) {
          Vehicle tempvehicle = Vehicle(
              vehiclenumber: item['licenseplatenumber'],
              name: item['owner'],
              telephone: item['telephone'],
              email: item['email'],
              breakings: []);
          vehicles.add(tempvehicle);
        }
      });
      filterSearchResults("");
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Vehicle does not exist!');
      setState(() {
        showSpinner = false;
      });
    }
  }

  void filterSearchResults(String query) {
    List<Vehicle> dummySearchList = [];
    dummySearchList.addAll(vehicles);

    if (query != "") {
      List<Vehicle> dummyListData = [];

      dummySearchList.forEach((item) {
        if (item.vehiclenumber.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        vehiclesDup.clear();
        vehiclesDup.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        vehiclesDup.clear();
        vehiclesDup.addAll(vehicles);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF234E70),
                  Colors.white,
                ],
              ),
            ),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                ),
                SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  height: 600,
                  child: ListView.builder(
                    key: Key("list1"),
                    shrinkWrap: true,
                    itemCount: vehiclesDup.length,
                    itemBuilder: (context, index) {
                      final vehicle = vehiclesDup[index];
                      return Card(
                        child: ListTile(
                          title: Text(vehicle.vehiclenumber),
                          subtitle: Text(vehicle.name),
                          trailing: const Icon(Icons.arrow_forward),
                          onTap: () async {
                            String urlvehicle =
                                "https://us-central1-cop-mate.cloudfunctions.net/getVehicle?licenseplatenumber=" +
                                    vehicle.vehiclenumber;
                            final response =
                                await http.get(Uri.parse(urlvehicle));

                            if (response.statusCode == 200) {
                              // If the server did return a 201 CREATED response,
                              // then parse the JSON.
                              String data = response.body;
                              var decodeData = jsonDecode(data);

                              String urlbreakings =
                                  "https://us-central1-cop-mate.cloudfunctions.net/getBreakingList?lic=" +
                                      vehicle.vehiclenumber;

                              final response2 =
                                  await http.get(Uri.parse(urlbreakings));

                              if (response2.statusCode == 200) {
                                List<dynamic> breakinsdata =
                                    jsonDecode(response2.body);
                                List<Breaking> breakings = [];
                                breakinsdata.forEach((item) {
                                  Map itemMap = item;
                                  var date =
                                      new DateTime.fromMillisecondsSinceEpoch(
                                          itemMap.values.first["datetime"]
                                                  ["_seconds"] *
                                              1000);
                                  String dateanddtime = date.toString();

                                  Breaking tempBreak = Breaking(
                                    vehiclenumber: itemMap
                                        .values.first["licenseplatenumber"],
                                    breakingnumber: itemMap.keys.first,
                                    pvalue: itemMap.values.first["pvalue"]
                                        .toString(),
                                    type: itemMap.values.first["typeofline"],
                                    location: itemMap.values.first["location"],
                                    distance: itemMap.values.first["distance"],
                                    dateandtime: dateanddtime,
                                  );
                                  breakings.add(tempBreak);
                                });

                                Vehicle vehicleobj = Vehicle(
                                    vehiclenumber:
                                        decodeData['licenseplatenumber'],
                                    name: decodeData['owner'],
                                    telephone: decodeData['telephone'],
                                    email: decodeData['email'],
                                    breakings: breakings);

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        vehicle_analyze(vehicle: vehicleobj)));
                              }
                            } else {
                              // If the server did not return a 201 CREATED response,
                              // then throw an exception.
                              throw Exception('Vehicle does not exist!');
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
