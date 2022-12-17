import 'package:flutter/material.dart';

class day_summary_map extends StatefulWidget {
  static const String id = 'day_summary_map';

  @override
  State<day_summary_map> createState() => _day_summary_mapState();
}

class _day_summary_mapState extends State<day_summary_map> {
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
