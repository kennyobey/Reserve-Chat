import 'package:resavation/utility/assets.dart';

class Property {
  final int? id;
  final String image;
  final int? amountPerYear;
  final String location;
  final String address;
  final int numberOfBedrooms;
  final int numberOfBathrooms;
  final int squareFeet;
  final bool isFavoriteTap;
  final String? category;

  Property({
    this.id,
    required this.image,
    this.amountPerYear,
    required this.location,
    this.address = '',
    required this.numberOfBedrooms,
    required this.numberOfBathrooms,
    required this.squareFeet,
    required this.isFavoriteTap,
    this.category,
  });
}

final listOfProperties = <Property> [
  Property(
      id: 1,
      image: Assets.sitting_room_placeholder,
      amountPerYear: 10000,
      location: 'Eleko Estate',
      address: '57B lagos street',
      numberOfBathrooms: 10,
      numberOfBedrooms: 5,
      squareFeet: 200,
      isFavoriteTap: true,
      category: 'Apartment',),
  Property(
      id: 2,
      image: Assets.house_placeholder,
      amountPerYear: 10000,
      location: 'Eleko Estate',
      address: '57B lagos street',
      numberOfBathrooms: 10,
      numberOfBedrooms: 5,
      squareFeet: 200,
      isFavoriteTap: false,
      category: 'Apartment'),

  Property(
      id: 3,
      image: Assets.sitting_room_placeholder,
      amountPerYear: 10000,
      location: 'Eleko Estate',
      address: '57B lagos street',
      numberOfBathrooms: 10,
      numberOfBedrooms: 5,
      squareFeet: 200,
      isFavoriteTap: true,
      category: 'Office Space'),
  Property(
      id: 4,
      image: Assets.lagos_location_placeholder,
      amountPerYear: 10000,
      location: 'Eleko Estate',
      address: '57B lagos street',
      numberOfBathrooms: 10,
      numberOfBedrooms: 5,
      squareFeet: 200,
      isFavoriteTap: true,
      category: 'Apartment'),
  Property(
      id: 5,
      image: Assets.sitting_room_placeholder,
      amountPerYear: 10000,
      location: 'Eleko Estate',
      address: '57B lagos street',
      numberOfBathrooms: 10,
      numberOfBedrooms: 5,
      squareFeet: 200,
      isFavoriteTap: true,
      category: 'Kitchen'),
  Property(
      id: 6,
      image: Assets.sitting_room_placeholder,
      amountPerYear: 10000,
      location: 'Eleko Estate',
      address: '57B lagos street',
      numberOfBathrooms: 10,
      numberOfBedrooms: 5,
      squareFeet: 200,
      isFavoriteTap: true,
      category: 'Apartment'),
  Property(
      id: 7,
      image: Assets.sitting_room_placeholder,
      amountPerYear: 10000,
      location: 'Eleko Estate',
      address: '57B lagos street',
      numberOfBathrooms: 10,
      numberOfBedrooms: 5,
      squareFeet: 200,
      isFavoriteTap: true,
      category: "Apartment"),
];
