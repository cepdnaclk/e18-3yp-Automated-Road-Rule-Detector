import 'package:front_end_cop_mate/models/Breaking.dart';

class Vehicle {
  final String vehiclenumber;
  final String name;
  final String telephone;
  final String email;
  final List<Breaking> breakings;

  const Vehicle(
      {required this.vehiclenumber,
      required this.name,
      required this.telephone,
      required this.email,
      required this.breakings});
}
