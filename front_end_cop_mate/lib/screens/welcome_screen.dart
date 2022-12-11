import 'package:flutter/material.dart';

class welcome_screen extends StatefulWidget {
  @override
  State<welcome_screen> createState() => _welcome_screenState();
}

class _welcome_screenState extends State<welcome_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to Cop Mate"),
      ),
      body: Center(
        child: Text('Login'),
      ),
    );
  }
}
