import 'package:resavation/utility/assets.dart';

class Property {
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

List<Property> ListOfProperties = [
  Property(
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
      image: Assets.house_placeholder,
      amountPerYear: 10000,
      location: 'Eleko Estate',
      address: '57B lagos street',
      numberOfBathrooms: 10,
      numberOfBedrooms: 5,
      squareFeet: 200,
      isFavoriteTap: false,
      category: 'Sitting Room'),

  Property(
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
      image: Assets.lagos_location_placeholder,
      amountPerYear: 10000,
      location: 'Eleko Estate',
      address: '57B lagos street',
      numberOfBathrooms: 10,
      numberOfBedrooms: 5,
      squareFeet: 200,
      isFavoriteTap: true,
      category: 'Bathroom'),
  Property(
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
      image: Assets.sitting_room_placeholder,
      amountPerYear: 10000,
      location: 'Eleko Estate',
      address: '57B lagos street',
      numberOfBathrooms: 10,
      numberOfBedrooms: 5,
      squareFeet: 200,
      isFavoriteTap: true,
      category: 'Nursery'),
  Property(
      image: Assets.sitting_room_placeholder,
      amountPerYear: 10000,
      location: 'Eleko Estate',
      address: '57B lagos street',
      numberOfBathrooms: 10,
      numberOfBedrooms: 5,
      squareFeet: 200,
      isFavoriteTap: true,
      category: "Visitor's Room"),
];
