import 'package:flutter/material.dart';
import 'package:front_end_cop_mate/screens/vehicle_analyze.dart';
import 'package:front_end_cop_mate/models/Vehicle.dart';

class search_vehciles extends StatefulWidget {
  static const String id = 'search_vehicles';

  @override
  State<search_vehciles> createState() => _search_vehcilesState();
}

class _search_vehcilesState extends State<search_vehciles> {
  List<Vehicle> vehicles = [
    const Vehicle(
        vehiclenumber: "CBL 8999",
        name: "Amaratunge",
        email: "thamish123@gmail.com",
        telephone: "0771515145"),
    const Vehicle(
        vehiclenumber: "DBF 8999",
        name: "Amaratunge",
        email: "thamish123@gmail.com",
        telephone: "0771515145"),
    const Vehicle(
        vehiclenumber: "FDG 8999",
        name: "Amaratunge",
        email: "thamish123@gmail.com",
        telephone: "0771515145"),
    const Vehicle(
        vehiclenumber: "DFG 8999",
        name: "Amaratunge",
        email: "thamish123@gmail.com",
        telephone: "0771515145"),
    const Vehicle(
        vehiclenumber: "DFS 8999",
        name: "Amaratunge",
        email: "thamish123@gmail.com",
        telephone: "0771515145"),
  ];

  List<Vehicle> vehiclesDup = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filterSearchResults("");
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.indigo.shade200,
                Colors.deepOrange.shade200,
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
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                onChanged: (value) {
                  filterSearchResults(value);
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: vehiclesDup.length,
                itemBuilder: (context, index) {
                  final vehicle = vehiclesDup[index];
                  return Card(
                    child: ListTile(
                      title: Text(vehicle.vehiclenumber),
                      subtitle: Text(vehicle.name),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                vehicle_analyze(vehicle: vehicle)));
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
