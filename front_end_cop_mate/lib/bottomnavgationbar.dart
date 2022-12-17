import 'package:flutter/material.dart';
import 'package:front_end_cop_mate/screens/day_summary_graph.dart';
import 'package:front_end_cop_mate/screens/day_summary_graph.dart';
import 'package:front_end_cop_mate/screens/day_summary_map.dart';
import 'package:front_end_cop_mate/screens/settings.dart';
import 'package:front_end_cop_mate/screens/vehicle_analyze.dart';
import 'package:front_end_cop_mate/screens/settings.dart';
import 'package:front_end_cop_mate/screens/search_vehicles.dart';

class bottomnavigationbar extends StatefulWidget {
  static const String id = 'bottom_navigation_bar';

  @override
  State<bottomnavigationbar> createState() => _bottomnavigationbarState();
}

class _bottomnavigationbarState extends State<bottomnavigationbar> {
  int currentIndex = 0;
  final screens = [
    day_summary_graph(),
    day_summary_map(),
    search_vehciles(),
    settings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cop Mate'),
        backgroundColor: Colors.indigo,
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.indigo,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        iconSize: 40,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_repair),
            label: 'Vehicles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
