import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class normalbutton extends StatelessWidget {
  normalbutton(
      {required this.string,
      required this.color,
      required this.onPressed,
      required this.y,
      required this.x});

  String string;
  Color color;
  Function onPressed;
  double y;
  double x;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed(),
      child: Text(string),
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(color),
          minimumSize: MaterialStatePropertyAll<Size>(Size(y, x))),
    );
  }
}
