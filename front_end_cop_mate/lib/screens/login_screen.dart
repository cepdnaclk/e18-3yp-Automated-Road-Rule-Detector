import 'package:flutter/material.dart';
import 'package:front_end_cop_mate/elements/heading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class login_screen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                heading(
                    string: "Login", icon: FontAwesomeIcons.user, space: 40),
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        icon: Icon(FontAwesomeIcons.user)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
