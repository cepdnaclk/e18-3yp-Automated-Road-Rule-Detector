import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:front_end_cop_mate/bottomnavgationbar.dart';
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
  final _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget _buildemailField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Email';
        }

        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return "Enter valid email";
        }
        return null;
      },
      onSaved: (value) {
        if (value != null && value.isNotEmpty) {
          email = value;
        }
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
    );
  }

  Widget _buildpasswordField() {
    return TextFormField(
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Password';
        }
        return null;
      },
      onSaved: (value) {
        if (value != null && value.isNotEmpty) {
          password = value;
        }
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cop Mate'),
        backgroundColor: Colors.indigo,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.indigo.shade200,
                  Colors.deepOrange.shade200,
                ],
              ),
            ),
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                heading(
                    string: "Login", icon: FontAwesomeIcons.user, space: 40),
                SizedBox(
                  height: 50,
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      _buildemailField(),
                      SizedBox(height: 20),
                      _buildpasswordField(),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (!_formkey.currentState!.validate()) {
                            return;
                          }
                          _formkey.currentState!.save();
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);

                            if (user != null) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          bottomnavigationbar()),
                                  (r) => false);
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text("Login"),
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Colors.deepOrangeAccent),
                            minimumSize:
                                MaterialStatePropertyAll<Size>(Size(100, 40))),
                      ),
                      SizedBox(
                        height: 300,
                      ),
                    ],
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
