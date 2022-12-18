import 'package:flutter/material.dart';
import 'package:front_end_cop_mate/bottomnavgationbar.dart';
import 'package:front_end_cop_mate/screens/one_breaking.dart';
import 'package:front_end_cop_mate/screens/search_vehicles.dart';
import 'package:front_end_cop_mate/screens/welcome_screen.dart';
import 'package:front_end_cop_mate/screens/day_summary_map.dart';
import 'package:front_end_cop_mate/screens/day_summary_graph.dart';
import 'package:front_end_cop_mate/screens/login_screen.dart';
import 'package:front_end_cop_mate/screens/one_breaking.dart';
import 'package:front_end_cop_mate/screens/register_user.dart';
import 'package:front_end_cop_mate/screens/register_vehicle.dart';
import 'package:front_end_cop_mate/screens/settings.dart';
import 'package:front_end_cop_mate/screens/vehicle_analyze.dart';
import 'package:front_end_cop_mate/screens/welcome_screen.dart';
import 'package:front_end_cop_mate/bottomnavgationbar.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp((CopMate()));
}

class CopMate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Lato',
      ),
      initialRoute: bottomnavigationbar.id,
      routes: {
        welcome_screen.id: (context) => welcome_screen(),
        day_summary_graph.id: (context) => day_summary_graph(),
        day_summary_map.id: (context) => welcome_screen(),
        login_screen.id: (context) => login_screen(),
        one_breaking.id: (context) => one_breaking(),
        register_user.id: (context) => register_user(),
        register_vehicle.id: (context) => register_vehicle(),
        settings.id: (context) => settings(),
        //vehicle_analyze.id: (context) => vehicle_analyze(),
        bottomnavigationbar.id: (context) => bottomnavigationbar(),
        search_vehciles.id: (context) => search_vehciles(),
      },
    );
  }
}
