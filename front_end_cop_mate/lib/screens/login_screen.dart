import 'package:flutter/material.dart';
import 'package:front_end_cop_mate/elements/constants.dart';
import 'package:front_end_cop_mate/elements/heading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_end_cop_mate/elements/constants.dart';
import 'package:front_end_cop_mate/elements/normalbutton.dart';
import 'package:front_end_cop_mate/elements/textfield.dart';
import 'package:front_end_cop_mate/elements/textfield.dart';

class login_screen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  String email = "";
  String password = "";

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
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    onChanged: (value) {
                      email = value;
                      print(email + "  ");
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Email",
                      icon: Icon(
                        FontAwesomeIcons.envelope,
                        color: Colors.black,
                      ),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    onChanged: (value) {
                      password = value;
                      print(password + "  ");
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Password",
                      icon: Icon(
                        FontAwesomeIcons.key,
                        color: Colors.black,
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Login"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          Colors.deepOrangeAccent),
                      minimumSize:
                          MaterialStatePropertyAll<Size>(Size(100, 40))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
