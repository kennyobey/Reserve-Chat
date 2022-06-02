import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/filter/amenity_count.dart';
import 'package:resavation/model/filter/availability.dart' as avail;
import 'package:resavation/model/filter/filter.dart';
import 'package:resavation/model/filter/price_range.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

enum Availability {
  Shortlet,
  Months,
  Year,
  More,
}

class FilterViewModel extends BaseViewModel {
  final oCcy = NumberFormat("#,##0.00", "en_US");
  final _navigationService = locator<NavigationService>();

  RangeValues _rangeValues = const RangeValues(10000, 1000000);

  RangeValues get rangeValue => _rangeValues;

  RangeLabels get rangeLabels => RangeLabels(
        '${String.fromCharCode(8358)}${oCcy.format(_rangeValues.start.round())}',
        '${String.fromCharCode(8358)}${oCcy.format(_rangeValues.end.round())}',
      );

  Availability _availablity = Availability.Shortlet;

  Availability get availibiality => _availablity;

  double _surfaceArea = 0;

  int carCount = 0;
  int batTubCount = 0;
  int bedroomCount = 0;

  double get surfaceArea => _surfaceArea;

  String? propertyType;
  List<String> propertyTypes = [
    'Flat',
    'Bungalow',
    'Self Contain',
  ];

  void onDurationChanged(Availability? value) {
    _availablity = value!;
    notifyListeners();
  }

  void onPropertyTypeChanged(value) {
    propertyType = value as String;

    notifyListeners();
  }

  void onIncrement(int position) {
    if (position == 0) {
      bedroomCount++;
    } else if (position == 1) {
      batTubCount++;
    } else {
      carCount++;
    }
    notifyListeners();
  }

  void onDecrement(int position) {
    if (position == 0 && bedroomCount != 0) {
      bedroomCount--;
    } else if (position == 1 && batTubCount != 0) {
      batTubCount--;
    } else if (carCount != 0) {
      carCount--;
    }
    notifyListeners();
  }

  void onRangeSliderChanged(RangeValues value) {
    _rangeValues = value;
    notifyListeners();
  }

  void onSliderChanged(double value) {
    _surfaceArea = value;
    notifyListeners();
  }

  void applyFilter() {
    final availiability = avail.Availability(
      moreThanOneYear: _availablity == Availability.More,
      shortLet: _availablity == Availability.Shortlet,
      withinOneYear: _availablity == Availability.Year,
      withinSixMonth: _availablity == Availability.Months,
    );
    final amenityCount = AmenityCount(
      bathTubCount: batTubCount,
      bedRoomCount: bedroomCount,
      carSlotCount: carCount,
    );
    final priceRange = PriceRange(
      min: _rangeValues.start.round(),
      max: _rangeValues.end.round(),
    );
    final filter = Filter(
      availability: availiability,
      surfaceArea: surfaceArea,
      priceRange: priceRange,
      amenityCount: amenityCount,
      propertyType: propertyType,
    );

    /*
  final String? amenity;
 
    */

    _navigationService.back(result: filter);
  }

  void goToSearchView() {
    _navigationService.navigateTo(Routes.searchView);
  }
}
