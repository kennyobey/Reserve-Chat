import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyOwnerPaymentViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

DateTime selectedDate = DateTime.now();

// drop-down button UI logic for spaceType
  String? selectedValue1;
  List<String> subscriptionType = [
    'Office Space',
    'Appartment',
  ];

  String isServiced = "";

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
        selectedDate = picked;
         print("The picked date is $selectedDate");
      notifyListeners();
    }
  }

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
