import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_end_cop_mate/elements/heading.dart';
import 'package:front_end_cop_mate/elements/settingsbuttons.dart';

class settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                heading(
                    string: 'Settings', icon: FontAwesomeIcons.gear, space: 20),
                SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    settingsbuttons(string: "Edit Profile", space: 120),
                    SizedBox(height: 10),
                    settingsbuttons(string: "Register Driver", space: 90),
                    SizedBox(height: 10),
                    settingsbuttons(string: "Log Out", space: 160)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
