import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_end_cop_mate/elements/heading.dart';
import 'package:front_end_cop_mate/elements/settingsbuttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:front_end_cop_mate/screens/login_screen.dart';
import 'package:front_end_cop_mate/screens/register_user.dart';
import 'package:front_end_cop_mate/screens/register_vehicle.dart';
import 'package:front_end_cop_mate/screens/welcome_screen.dart';

class settings extends StatefulWidget {
  static const String id = 'settings';

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    User? user = await auth.currentUser;
    print("Logged in!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF234E70),
                Colors.white,
              ],
            ),
          ),
          child: Column(
            children: [
              heading(
                  string: 'Settings', icon: FontAwesomeIcons.gear, space: 20),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Container(
                    width: 380,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.white)),
                      onPressed: () {
                        Navigator.pushNamed(context, register_vehicle.id);
                      },
                      child: Row(
                        children: [
                          Text(
                            "Register Vehicle",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          SizedBox(
                            width: 90,
                          ),
                          Icon(
                            FontAwesomeIcons.chevronRight,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 380,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.white)),
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Log Out?'),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Text('Do you want to log out?'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Confirm'),
                                  onPressed: () async {
                                    auth.signOut();
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                welcome_screen()),
                                        (r) => false);
                                  },
                                ),
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            "Log Out",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          SizedBox(
                            width: 160,
                          ),
                          Icon(
                            FontAwesomeIcons.chevronRight,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
