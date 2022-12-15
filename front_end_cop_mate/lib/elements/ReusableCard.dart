import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({required this.string});

  String string;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan,
      height: 80,
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Text(string, style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
