import 'package:flutter/material.dart';
import 'package:front_end_cop_mate/elements/normalbutton.dart';

class welcome_screen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  State<welcome_screen> createState() => _welcome_screenState();
}

class _welcome_screenState extends State<welcome_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            normalbutton(string: "Login"),
            normalbutton(string: "Register"),
          ],
        ),
      ),
    );
  }
}
