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
    iconData: Icons.ac_unit_outlined,
    title: 'Air Conditional',
  ),
  Amenity(
    iconData: Icons.outdoor_grill,
    title: 'Barbeque',
  ),
  Amenity(
    iconData: Icons.hvac,
    title: 'Central Heating',
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

List<Amenity> ListOfAmenitiesCoworking = [
  Amenity(
    iconData: Icons.network_wifi,
    title: 'Internet Speed',
  ),
  Amenity(
    iconData: Icons.ac_unit_outlined,
    title: 'Air Conditional',
  ),
  Amenity(
    iconData: Icons.camera_rear_outlined,
    title: 'CCTV Camera',
  ),
  Amenity(
    iconData: Icons.height,
    title: 'Lift Access',
  ),
  Amenity(
    iconData: Icons.access_time,
    title: '24/7 Access',
  ),
  Amenity(
    iconData: Icons.park,
    title: 'Car Park',
  ),
  Amenity(
    iconData: Icons.kitchen_sharp,
    title: 'Kicthen',
  ),
];

class TestLogin {
  TestLogin(
      this.roles, this.message, this.firstName, this.lastName, this.email);
  final List<Map<String, dynamic>> roles;
  final String message;
  final String firstName;
  final String lastName;
  final String email;

  void printRoles() {
    roles.first.keys.first;
  }
}
