import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_end_cop_mate/elements/heading.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(_ChartApp());
}

class _ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: day_summary_map(),
    );
  }
}

class day_summary_map extends StatefulWidget {
  const day_summary_map({Key? key}) : super(key: key);
  static const String id = 'day_summary_map';

  @override
  _day_summary_mapState createState() => _day_summary_mapState();
}

class _day_summary_mapState extends State<day_summary_map> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: Color(0xFF1B3C56),
                height: 70,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      FontAwesomeIcons.mapLocation,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "View Road Rule Map",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
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
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                      width: 500,
                      height: 700,
                      child: FlutterMap(
                        options: MapOptions(
                          center: LatLng(7.466, 80.62),
                          zoom: 8,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName:
                                'dev.fleaflet.flutter_map.example',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                  point: LatLng(7.29, 80.64),
                                  builder: (context) => Container(
                                        child: IconButton(
                                          icon: Icon(Icons.location_on),
                                          color: Colors.red,
                                          iconSize: 35.0,
                                          onPressed: () {},
                                        ),
                                      )),
                              Marker(
                                  point: LatLng(7.248, 80.34),
                                  builder: (context) => Container(
                                        child: IconButton(
                                          icon: Icon(Icons.location_on),
                                          color: Colors.red,
                                          iconSize: 35.0,
                                          onPressed: () {},
                                        ),
                                      ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
