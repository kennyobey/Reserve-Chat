import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/property_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

enum Availability {
  Shortlet,
  Months,
  Year,
  More,
}

class FilterViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  RangeValues _rangeValues = const RangeValues(10000, 1000000);

  RangeValues get rangeValue => _rangeValues;

  RangeLabels get rangeLabels => RangeLabels(
        _rangeValues.end.round().toString(),
        _rangeValues.start.round().toString(),
      );

  Availability _duration = Availability.Shortlet;

  Availability get duration => _duration;

  void onDurationChanged(Availability? value) {
    _duration = value!;
    notifyListeners();
  }

  double _sliderValue = 0;

  double get sliderValue => _sliderValue;

  void onRangeSliderChanged(RangeValues value) {
    _rangeValues = value;
    notifyListeners();
  }

  void onSliderChanged(double value) {
    _sliderValue = value;
    notifyListeners();
  }

  void goToMainView() {
    _navigationService.back();
  }

  void goToSearchView() {
    _navigationService.navigateTo(Routes.searchView);
  }

  String _propertyValue = 'Select Property';
  String get propertyValue => _propertyValue;

  void onDropdownButtonSelect(String? value) {
    _propertyValue = value!;
    notifyListeners();
  }
}
