import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class heading extends StatelessWidget {
  heading({required this.string, required this.icon, required this.space});

  String string;
  IconData icon;
  double space;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.deepOrangeAccent,
      height: 80,
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Icon(icon),
          SizedBox(
            width: space,
          ),
          Text(
            string,
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
