import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
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

  Availability _duration = Availability.Shortlet;

  Availability get duration => _duration;

  void onDurationChanged(Availability? value) {
    _duration = value!;
    notifyListeners();
  }

  double _sliderValue = 0;

  double get sliderValue => _sliderValue;

  List<int> selectFacilityIndex = [];

  // drop-down button UI logic
  String? selectedValue;
  List<String> items = [
    'Flat',
    'Bungalow',
    'Self Contain',
  ];
  void onSelectedValueChange(value) {
    selectedValue = value as String;

    notifyListeners();
  }

  bool isFacilitySelected(int index) => selectFacilityIndex.contains(index);

  void onSelectFacilityTap(int index) {
    if (selectFacilityIndex.contains(index)) {
      selectFacilityIndex.remove(index);
    } else {
      selectFacilityIndex.add(index);
    }
    notifyListeners();
  }

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
}
