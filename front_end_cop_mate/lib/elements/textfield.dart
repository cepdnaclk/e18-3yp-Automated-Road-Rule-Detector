import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class textfield extends StatelessWidget {
  textfield({required this.string, required this.icon});

  String string;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: string,
          icon: Icon(
            icon,
            color: Colors.black,
          ),
          hintText: string,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
