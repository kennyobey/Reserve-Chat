import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyOwnerPaymentViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

// drop-down button UI logic for spaceType
  String? selectedValue1;
  List<String> spaceType = [
    'Office Space',
    'Appartment',
  ];

  String isServiced = "";

  void onSpaceServicedRadioChange(String value) {
    isServiced = value.toString();
    notifyListeners();
  }

  void onSelectedValueChange1(value) {
    selectedValue1 = value as String;

    notifyListeners();
  }

  void goToPropertyOwnerAmenitiesView() {
    _navigationService.navigateTo(Routes.propertyOwnerAmenitiesView);
  }

  void goToPropertyOwnerDatePickerView() {
    _navigationService.navigateTo(Routes.propertyOwnerDatePickerView);
  }
}
