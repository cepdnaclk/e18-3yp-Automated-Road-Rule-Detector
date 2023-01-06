import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({required this.string});

  String string;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white54,
      ),
      height: 60,
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
