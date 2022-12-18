import 'package:flutter/material.dart';
import 'package:front_end_cop_mate/elements/normalbutton.dart';
import 'package:front_end_cop_mate/screens/login_screen.dart';
import 'package:front_end_cop_mate/screens/register_user.dart';

class welcome_screen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  State<welcome_screen> createState() => _welcome_screenState();
}

class _welcome_screenState extends State<welcome_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Center(
        child: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.indigo.shade400,
                  Colors.deepOrange.shade200,
                ],
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                CircleAvatar(
                  radius: 150,
                  backgroundColor: Colors.indigo.shade100,
                  backgroundImage: AssetImage('images/FNkW-Z8XMAA59Kt.png'),
                ),
                SizedBox(
                  height: 50,
                ),
                Text("Cop Mate",
                    style: TextStyle(
                        fontFamily: "Lobster",
                        fontSize: 100,
                        color: Colors.indigo)),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, login_screen.id);
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 30),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        Colors.deepOrange.shade400),
                    minimumSize: MaterialStatePropertyAll<Size>(Size(150, 50)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, register_user.id);
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 30),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                      Colors.deepOrange.shade400,
                    ),
                    minimumSize: MaterialStatePropertyAll<Size>(Size(150, 50)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
