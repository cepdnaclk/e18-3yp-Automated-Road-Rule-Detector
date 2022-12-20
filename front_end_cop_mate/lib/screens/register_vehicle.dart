import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_end_cop_mate/bottomnavgationbar.dart';
import 'package:front_end_cop_mate/models/Vehicle.dart';
import 'package:front_end_cop_mate/screens/settings.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:front_end_cop_mate/elements/heading.dart';
import 'package:http/http.dart' as http;

class register_vehicle extends StatefulWidget {
  const register_vehicle({Key? key}) : super(key: key);
  static const String id = 'register_vehicle';

  @override
  State<register_vehicle> createState() => _register_vehicleState();
}

class _register_vehicleState extends State<register_vehicle> {
  @override
  String email = "";
  String vehiclenumber = "";
  String name = "";
  String telephone = "";
  bool showSpinner = false;

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

  Widget _buildvehiclenumber() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Vehicle Number';
        }

        return null;
      },
      onSaved: (value) {
        if (value != null && value.isNotEmpty) {
          vehiclenumber = value;
        }
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: "Id",
        icon: Icon(
          FontAwesomeIcons.car,
          color: Colors.black,
        ),
        hintText: "Vehiclee Number",
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _buildname() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Name';
        }
        return null;
      },
      onSaved: (value) {
        if (value != null && value.isNotEmpty) {
          name = value;
        }
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: "Name",
        icon: Icon(
          FontAwesomeIcons.user,
          color: Colors.black,
        ),
        hintText: "Name",
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _buildtelephonenumber() {
    return TextFormField(
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Telephone';
        }

        return null;
      },
      onSaved: (value) {
        if (value != null && value.isNotEmpty) {
          telephone = value;
        }
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: "Telephone Number",
        icon: Icon(
          FontAwesomeIcons.key,
          color: Colors.black,
        ),
        hintText: "Telephone Number",
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Cop Mate'),
        backgroundColor: Color(0xFF518BB8),
      ),
      body: SingleChildScrollView(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SafeArea(
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
                  SizedBox(
                    height: 10,
                  ),
                  heading(
                      string: "Register",
                      icon: FontAwesomeIcons.user,
                      space: 40),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(30),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          _buildvehiclenumber(),
                          SizedBox(height: 20),
                          _buildname(),
                          SizedBox(height: 20),
                          _buildemailField(),
                          SizedBox(height: 20),
                          _buildtelephonenumber(),
                          SizedBox(height: 20),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              if (!_formkey.currentState!.validate()) {
                                return;
                              }
                              _formkey.currentState!.save();
                              print("vehcle" + vehiclenumber);
                              final response = await http.post(
                                Uri.parse(
                                    'https://us-central1-cop-mate.cloudfunctions.net/addVehicle'),
                                body: {
                                  "email": email,
                                  "licenseplatenumber": vehiclenumber,
                                  "nic": "9928",
                                  "owner": name,
                                  "telephone": telephone
                                },
                              );

                              if (response.statusCode == 200) {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Successful!'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: const <Widget>[
                                            Text(
                                                'Vehicle Registered Successfully!'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Okay'),
                                          onPressed: () {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        bottomnavigationbar()),
                                                (r) => false);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Unsuccessful'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: const <Widget>[
                                            Text('Please try again!'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Okay'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Text("Register",
                                style: TextStyle(color: Colors.black)),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color(0xFFFBF8BE)),
                                minimumSize: MaterialStatePropertyAll<Size>(
                                    Size(100, 40))),
                          ),
                          SizedBox(
                            height: 300,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
