import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const kTextFieldInputDeco = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  labelText: 'Enter Email',
  icon: Icon(
    FontAwesomeIcons.envelope,
    color: Colors.black,
  ),
  hintText: 'Enter Email',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
  ),
);
