import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
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
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(7.466, 80.62),
          zoom: 8,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
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
    );
  }
}
