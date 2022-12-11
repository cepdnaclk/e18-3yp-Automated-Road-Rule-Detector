import 'package:flutter/material.dart';
import 'package:front_end_cop_mate/screens/welcome_screen.dart';

void main() {
  runApp((CopMate()));
}

class CopMate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: welcome_screen());
  }
}
