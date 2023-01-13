import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_end_cop_mate/elements/ReusableCard.dart';
import 'package:front_end_cop_mate/elements/heading.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:front_end_cop_mate/bottomnavgationbar.dart';

class one_breaking extends StatelessWidget {
  static const String id = 'one_breaking';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cop Mate'),
        leading: null,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => bottomnavigationbar()),
                    (r) => false);
              },
              icon: Icon(Icons.home))
        ],
        backgroundColor: Colors.indigo,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.indigo.shade400,
                  Colors.deepOrange.shade200,
                ],
              ),
            ),
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                heading(
                    string: "Breaking No" + "  5555",
                    icon: FontAwesomeIcons.trafficLight,
                    space: 50),
                SizedBox(height: 30),
                ReusableCard(string: "Vehicle No." + " CBL-5555"),
                SizedBox(height: 5),
                Container(
                  color: Colors.grey,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text("P Value", style: TextStyle(fontSize: 20)),
                      SizedBox(
                        height: 30,
                      ),
                      _getLinearGauge(),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                ReusableCard(string: "Type: " + "     Double"),
                SizedBox(height: 5),
                ReusableCard(string: "Location: " + "     coordinates"),
                SizedBox(height: 5),
                ReusableCard(string: "Distance: " + "     100m"),
                SizedBox(height: 5),
                ReusableCard(string: "Date and Time: " + "     10:30pm"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _getLinearGauge() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.grey,
    ),
    child: SfLinearGauge(
        minimum: 0.0,
        maximum: 100.0,
        markerPointers: [LinearShapePointer(value: 80)],
        barPointers: [LinearBarPointer(value: 80)],
        orientation: LinearGaugeOrientation.horizontal,
        majorTickStyle: LinearTickStyle(length: 20),
        axisLabelStyle: TextStyle(fontSize: 12.0, color: Colors.black),
        axisTrackStyle: LinearAxisTrackStyle(
          color: Colors.grey,
          edgeStyle: LinearEdgeStyle.bothFlat,
          thickness: 15.0,
          borderColor: Colors.grey,
        )),
    margin: EdgeInsets.all(10),
  );
}
