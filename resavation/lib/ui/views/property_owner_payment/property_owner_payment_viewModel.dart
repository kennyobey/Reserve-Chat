import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';

class PropertyOwnerPaymentViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();
  DateTime selectedDate = DateTime.now();
  DateTime selectedDate2 = DateTime.now();

  bool hasWifi = false;

  void onHasWifiChange(bool? value) {
    hasWifi = value!;
    notifyListeners();
  }

  final TextEditingController propertySubscriptionController =
      TextEditingController();
  final TextEditingController propertyannualPriceController =
      TextEditingController();
  final TextEditingController propertybiannualPriceController =
      TextEditingController();
  final TextEditingController propertymonthlyPriceController =
      TextEditingController();
  final TextEditingController propertyquaterlylPriceController =
      TextEditingController();

  void upoloadPropertyToServer() async {
    final String subscription = propertySubscriptionController.text;
    var annualPrice = propertyannualPriceController.text;
    final String biannualPrice = propertybiannualPriceController.text;
    final String monthlylPrice = propertymonthlyPriceController.text;
    final String quaterlylPrice = propertyquaterlylPriceController.text;

    httpService.uploadProperty(
      annualPrice: 0,
      biannualPrice: 0,
      quarterlyPrice: 0,
      monthlyPrice: 0,
    );
  }

  void incrementPrice({required String input}) {
    propertyquaterlylPriceController.text = (int.parse(input) * 4).toString();
    propertybiannualPriceController.text = (int.parse(input) * 6).toString();
    propertyannualPriceController.text = (int.parse(input) * 12).toString();
    notifyListeners();
  }

// drop-down button UI logic for spaceType
  String? selectedValue1;
  List<String> subscriptionType = [
    'Office Space',
    'Appartment',
  ];

  String isServiced = "";

  Future<void> selecStarttDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      print("The picked date for date 1 is $selectedDate");

      notifyListeners();
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate2,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate2) {
      selectedDate2 = picked;
      print("The picked date for date 2 is $selectedDate2");

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
