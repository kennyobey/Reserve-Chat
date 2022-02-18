import 'package:flutter/material.dart';

class Amenity {
  final String title;
  final IconData iconData;

  Amenity({
    required this.iconData,
    required this.title,
  });
}

List<Amenity> ListOfAmenities = [
  Amenity(
    iconData: Icons.air,
    title: 'Air Conditional',
  ),
  Amenity(
    iconData: Icons.outdoor_grill,
    title: 'Barbeque',
  ),
  Amenity(
    iconData: Icons.hvac,
    title: 'Crentral Heating',
  ),
  Amenity(
    iconData: Icons.dry,
    title: 'Dryer',
  ),
  Amenity(
    iconData: Icons.fitness_center,
    title: 'Gym',
  ),
  Amenity(
    iconData: Icons.dry_cleaning,
    title: 'Laundry',
  ),
  Amenity(
    iconData: Icons.wifi,
    title: 'Wifi',
  ),
  Amenity(
    iconData: Icons.tv,
    title: 'Tv Cable',
  ),
];

class TestLogin {
  TestLogin(this.roles, this.message, this.firstName, this.lastName, this.email);
  final List<Map<String, dynamic>> roles;
  final String message;
  final String firstName;
  final String lastName;
  final String email;

  void printRoles() {
    roles.first.keys.first;
  }
}
