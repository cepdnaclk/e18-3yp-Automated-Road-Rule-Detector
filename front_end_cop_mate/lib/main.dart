import 'package:flutter/material.dart';
import 'package:front_end_cop_mate/bottomnavgationbar.dart';
import 'package:front_end_cop_mate/screens/one_breaking.dart';
import 'package:front_end_cop_mate/screens/welcome_screen.dart';

void main() {
  runApp((CopMate()));
}

class CopMate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Lato',
      ),
      home: one_breaking(),
    );
  }
}
