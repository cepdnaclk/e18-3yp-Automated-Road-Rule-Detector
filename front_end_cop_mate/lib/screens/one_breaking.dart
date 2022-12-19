import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_end_cop_mate/elements/ReusableCard.dart';
import 'package:front_end_cop_mate/elements/heading.dart';
import 'package:front_end_cop_mate/models/Breaking.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:front_end_cop_mate/bottomnavgationbar.dart';

class one_breaking extends StatefulWidget {
  static const String id = 'one_breaking';
  final Breaking breaking;

  const one_breaking({
    required this.breaking,
  });

  @override
  State<one_breaking> createState() => _one_breakingState();
}

class _one_breakingState extends State<one_breaking> {
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
        backgroundColor: Color(0xFF518BB8),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
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
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Color(0xFF9FB9F1),
                  height: 80,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Icon(FontAwesomeIcons.trafficLight),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Breaking No" + widget.breaking.breakingnumber,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                ReusableCard(
                    string: "Vehicle No." + widget.breaking.vehiclenumber),
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
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                        child: SfLinearGauge(
                            minimum: 0.0,
                            maximum: 100.0,
                            markerPointers: [
                              LinearShapePointer(
                                  value: double.parse(widget.breaking.pvalue))
                            ],
                            barPointers: [
                              LinearBarPointer(
                                  value: double.parse(widget.breaking.pvalue))
                            ],
                            orientation: LinearGaugeOrientation.horizontal,
                            majorTickStyle: LinearTickStyle(length: 20),
                            axisLabelStyle:
                                TextStyle(fontSize: 12.0, color: Colors.black),
                            axisTrackStyle: LinearAxisTrackStyle(
                              color: Colors.grey,
                              edgeStyle: LinearEdgeStyle.bothFlat,
                              thickness: 15.0,
                              borderColor: Colors.grey,
                            )),
                        margin: EdgeInsets.all(10),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                ReusableCard(string: "Type: " + widget.breaking.type),
                SizedBox(height: 5),
                ReusableCard(string: "Location: " + widget.breaking.location),
                SizedBox(height: 5),
                ReusableCard(string: "Distance: " + widget.breaking.distance),
                SizedBox(height: 5),
                ReusableCard(
                    string: "Date and Time: " + widget.breaking.dateandtime),
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
