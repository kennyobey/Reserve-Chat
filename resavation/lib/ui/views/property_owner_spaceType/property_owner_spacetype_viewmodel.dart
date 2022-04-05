import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyOwnerSpaceTypeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  bool _notificationSwitchValue = false;
  bool get notificationSwitchValue => _notificationSwitchValue;

  String IsServiced = "Serviced";

  String IsFurnished = "Funrnished";

  String IsLiveSpace = "IsLiveSpace";

  void onRadioChanged(String value) {
    IsServiced = value.toString();
    print(IsServiced);
    notifyListeners();
  }

  void onRadioChanged2(String value) {
    IsFurnished = value.toString();
    print(IsFurnished);
    notifyListeners();
  }

  void onRadioChanged3(String value) {
    IsLiveSpace = value.toString();
    print(IsLiveSpace);
    notifyListeners();
  }

  void onNotificationSwitchChanged(bool? value) {
    _notificationSwitchValue = value!;
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

  void goToPropertyOwnerVerificationView() {
    _navigationService.navigateTo(Routes.propertyOwnerVerificationView);
  }

  void goToPropertyOwnerDetailsView() {
    _navigationService.navigateTo(Routes.propertyOwnerDetailsView);
  }
}
