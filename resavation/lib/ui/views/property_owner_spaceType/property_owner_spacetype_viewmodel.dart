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
    notifyListeners();
  }

  void goToPropertyOwnerVerificationView() {
    _navigationService.navigateTo(Routes.propertyOwnerVerificationView);
  }

  void goToPropertyOwnerDetailsView() {
    _navigationService.navigateTo(Routes.propertyOwnerDetailsView);
  }

  bool _appNotificationSwitchValue = false;
  bool get appNotificationSwitchValue => _appNotificationSwitchValue;

  void onAppNotificationSwitchValue(bool? value) {
    _appNotificationSwitchValue = value!;
    notifyListeners();
  }
}
