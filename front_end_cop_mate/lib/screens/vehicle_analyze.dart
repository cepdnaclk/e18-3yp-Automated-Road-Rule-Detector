import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class vehicle_analyze extends StatefulWidget {
  static const String id = 'vehcile_analyze';

  @override
  State<vehicle_analyze> createState() => _vehicle_analyzeState();
}

class _vehicle_analyzeState extends State<vehicle_analyze> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
      ),
    );
  }
}
