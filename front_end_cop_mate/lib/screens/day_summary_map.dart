import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_end_cop_mate/elements/heading.dart';
import 'package:front_end_cop_mate/models/Breaking.dart';
import 'package:front_end_cop_mate/screens/one_breaking.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:front_end_cop_mate/models/Breaking.dart';

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
  static const String id = 'day_summary_map';

  @override
  _day_summary_mapState createState() => _day_summary_mapState();
}

final Breaking breaking = Breaking(
    vehiclenumber: "CB-7777",
    breakingnumber: "",
    pvalue: "77",
    type: "Single",
    location: "7.267, 80.601",
    distance: "20",
    dateandtime: "2022-12-20 13:10:14");

class _day_summary_mapState extends State<day_summary_map> {
  late List<Marker> markerdata = [];

  @override
  void initState() {
    super.initState();
    getMarkers();
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
                padding: EdgeInsets.all(20),
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
                      height: 580,
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
                            markers: markerdata,
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

  void getMarkers() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    String urlbreakings =
        "https://us-central1-cop-mate.cloudfunctions.net/dayBreakings?date=2023-01-02";
    final List<Marker> markerData = [];
    final response = await http.get(Uri.parse(urlbreakings));
    if (response.statusCode == 200) {
      var decodeData = jsonDecode(response.body);
      List<dynamic> breakinsdata = decodeData;

      breakinsdata.forEach((item) {
        double lat = double.parse(item['location'].split(', ')[0]);
        double lng = double.parse(item['location'].split(', ')[1]);

        Breaking tempBreak = Breaking(
          vehiclenumber: item["licenseplatenumber"],
          breakingnumber: "",
          pvalue: item["pvalue"],
          type: item["typeofline"],
          location: item["location"],
          distance: item["distance"],
          dateandtime: item['datetime'].toString(),
        );

        Marker tempMark = Marker(
            point: LatLng(lat, lng),
            builder: (context) => Container(
                  child: IconButton(
                    icon: Icon(Icons.location_on),
                    color: Colors.red,
                    iconSize: 35.0,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              one_breaking(breaking: tempBreak)));
                    },
                  ),
                ));
        markerData.add(tempMark);
      });

      markerdata = markerData;
      setState(() {
        print("set 2");
      });
    }
  }
}
