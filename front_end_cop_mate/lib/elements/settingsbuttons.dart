import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class settingsbuttons extends StatelessWidget {
  settingsbuttons({required this.string, required this.space});

  String string;
  double space;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white)),
        onPressed: () {},
        child: Row(
          children: [
            Text(
              string,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(
              width: space,
            ),
            Icon(
              FontAwesomeIcons.chevronRight,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
