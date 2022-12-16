import 'package:flutter/material.dart';

class day_summary_graph extends StatefulWidget {
  static const String id = 'day_summary_graph';

  @override
  State<day_summary_graph> createState() => _day_summary_graphState();
}

class _day_summary_graphState extends State<day_summary_graph> {
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
