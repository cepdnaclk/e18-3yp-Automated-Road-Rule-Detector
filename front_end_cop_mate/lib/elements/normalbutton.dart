import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class normalbutton extends StatelessWidget {
  normalbutton({required this.string});

  String string;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(string),
      style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll<Color>(Colors.deepOrangeAccent),
          minimumSize: MaterialStatePropertyAll<Size>(Size(100, 40))),
    );
  }
}
