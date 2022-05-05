import 'dart:async';

import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:resavation/services/core/user_type_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyOwnerSpaceTypeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();
  final userTypeService = locator<UserTypeService>();

  void upoloadPropertyToServer() async {
    httpService.uploadProperty(
        spaceServiced: false,
        spaceFurnished: false,
        liveInSPace: false,
        listingOption: "listingOption",
        bathTubCount: numberOfBathrooms,
        bedroomCount: numberOfBedrooms,
        carSlots: numberOfCarSlot);
  }

  // Global Keys to use with the form text fields
  final registrationFormKey = GlobalKey<FormState>();
  late Timer timer;

  bool _notificationSwitchValue = false;
  bool get notificationSwitchValue => _notificationSwitchValue;

  // drop-down button UI logic for spaceType
  String? selectedValue1;
  List<String> spaceType = [
    'Town House',
    'Plot of Land',
    'Detached Duplex',
    'Terace',
    'Flat',
    'Semi Detached Duplex',
    'Bungalow',
    'Luxury Apartent',
    'PentHouse',
    'Maisoneet',
    'Short-Let'
  ];

// drop-down button UI logic for Listing Option
  String? selectedValue2;
  List<String> listingOption = [
    'Shared Space',
    'Entire Space',
    'Serviced',
    'Self Servced',
    'Shared',
    'Short Let'
  ];

  // drop-down button UI logic for property status
  String? selectedValue3;
  List<String> propertyStatus = ['For Sale', 'For Rent'];

  void onSelectedValueChange1(value) {
    selectedValue1 = value as String;

    notifyListeners();
  }

  void onSelectedValueChange2(value) {
    selectedValue2 = value as String;

    notifyListeners();
  }

  void onSelectedValueChange3(value) {
    selectedValue3 = value as String;

    notifyListeners();
  }

  //is your space serviced UI logic
  String isServiced = "";

  void onSpaceServicedRadioChange(String value) {
    isServiced = value.toString();
    notifyListeners();
  }

  // is your furnished  UI logic
  String isFurnished = "";

  void onSpaceFurnishedRadioChange(String value) {
    isFurnished = value.toString();
    notifyListeners();
  }

  // do you leave in this space  UI logic
  String leaveHere = "";

  void onLeaveHereRadioChange(String value) {
    leaveHere = value.toString();
    notifyListeners();
  }

  // Amenities selection logic
  int numberOfBedrooms = 0;
  int numberOfBathrooms = 0;
  int numberOfCarSlot = 0;

  // method for each amenities tap
  void onPositiveBedRoomTap() {
    numberOfBedrooms++;
    notifyListeners();
  }

  void onNegativeBedRoomTap() {
    if (numberOfBedrooms != 0) {
      numberOfBedrooms--;
    }
    notifyListeners();
  }

  void onPositiveBathRoomTap() {
    numberOfBathrooms++;
    notifyListeners();
  }

  void onNegativeBathRoomTap() {
    if (numberOfBathrooms != 0) {
      numberOfBathrooms--;
    }
    notifyListeners();
  }

  void onPositiveCarSlotTap() {
    numberOfCarSlot++;
    notifyListeners();
  }

  void onNegativeCarSlotTap() {
    if (numberOfCarSlot != 0) {
      numberOfCarSlot--;
    }

    notifyListeners();
  }

  void goToPropertyOwnerHomePageView() {
    _navigationService.navigateTo(Routes.propertyOwnerHomePageView);
  }

  void goToPropertyOwnerDetailsView() {
    _navigationService.navigateTo(Routes.propertyOwnerDetailsView);
  }
}
