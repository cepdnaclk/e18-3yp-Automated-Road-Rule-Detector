import 'package:flutter/material.dart';

class search_vehciles extends StatefulWidget {
  static const String id = 'search_vehicles';

  @override
  State<search_vehciles> createState() => _search_vehcilesState();
}

class _search_vehcilesState extends State<search_vehciles> {
  List<Vehicle> vehicles = [
    const Vehicle(vehiclenumber: "CBL 8999", breakings: "8888"),
    const Vehicle(vehiclenumber: "CBL 8999", breakings: "8888"),
    const Vehicle(vehiclenumber: "CBL 8999", breakings: "8888"),
    const Vehicle(vehiclenumber: "CBL 8999", breakings: "8888"),
    const Vehicle(vehiclenumber: "CBL 8999", breakings: "8888"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
              SizedBox(height: 100),
              ListView.builder(
                shrinkWrap: true,
                itemCount: vehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = vehicles[index];
                  return Card(
                    child: ListTile(
                      title: Text(vehicle.vehiclenumber),
                      subtitle: Text(vehicle.breakings),
                      trailing: const Icon(Icons.arrow_forward),
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

class Vehicle {
  const Vehicle({
    required this.vehiclenumber,
    required this.breakings,
  });

  final String vehiclenumber;
  final String breakings;
}
