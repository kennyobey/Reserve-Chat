import 'package:resavation/utility/assets.dart';
import 'package:stacked/stacked.dart';

class Property {
  final String image;
  final int? amountPerYear;
  final String location;
  final String address;
  final int numberOfBedrooms;
  final int numberOfBathrooms;
  final int squareFeet;
  final bool isFavoriteTap;

  Property({
    required this.image,
    this.amountPerYear,
    required this.location,
    this.address = '',
    required this.numberOfBedrooms,
    required this.numberOfBathrooms,
    required this.squareFeet,
    required this.isFavoriteTap,
  });
}

class SearchViewModel extends BaseViewModel {
  List<Property> _properties = [
    Property(
      image: Assets.sitting_room_placeholder,
      amountPerYear: 10000,
      location: 'Eleko Estate',
      address: '57B lagos street',
      numberOfBathrooms: 10,
      numberOfBedrooms: 5,
      squareFeet: 200,
      isFavoriteTap: true,
    ),
    Property(
      image: Assets.sitting_room_placeholder,
      amountPerYear: 10000,
      location: 'Eleko Estate',
      address: '57B lagos street',
      numberOfBathrooms: 10,
      numberOfBedrooms: 5,
      squareFeet: 200,
      isFavoriteTap: false,
    ),
    Property(
      image: Assets.sitting_room_placeholder,
      amountPerYear: 10000,
      location: 'Eleko Estate',
      address: '57B lagos street',
      numberOfBathrooms: 10,
      numberOfBedrooms: 5,
      squareFeet: 200,
      isFavoriteTap: true,
    )
  ];
  List<Property> get properties => _properties;

  void onFavoriteTap(Property property) {
    notifyListeners();
  }
}
