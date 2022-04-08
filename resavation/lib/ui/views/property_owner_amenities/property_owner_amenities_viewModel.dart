import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyOwnerAmenitiesViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  /// Checkboxes are named to fit their corresponding value
  /// To enable for easy recognition and usage

  bool hasWifi = false;
  //bool get hasWifi => _hasWifi;

  bool _checkValue2 = false;
  bool get checkValue2 => _checkValue2;

  bool _checkValue3 = false;
  bool get checkValue3 => _checkValue3;

  bool _checkValue4 = false;
  bool get checkValue4 => _checkValue4;

  bool _checkValue5 = false;
  bool get checkValue5 => _checkValue5;

  bool _checkValue6 = false;
  bool get checkValue6 => _checkValue6;

  bool _checkValue7 = false;
  bool get checkValue7 => _checkValue7;

  bool _checkValue8 = false;
  bool get checkValue8 => _checkValue8;

  bool _checkValue9 = false;
  bool get checkValue9 => _checkValue9;

  void onHasWifiChange(bool? value) {
    hasWifi = value!;
    notifyListeners();
  }

  void onCheckChanged2(bool? value) {
    _checkValue2 = value ?? false;
    notifyListeners();
  }

  void onCheckChanged3(bool? value) {
    _checkValue3 = value ?? false;
    notifyListeners();

  }

  void onCheckChanged4(bool? value) {
    _checkValue4 = value ?? false;
    notifyListeners();
  }

  void onCheckChanged5(bool? value) {
    _checkValue5 = value ?? false;
    notifyListeners();
  }

  void onCheckChanged6(bool? value) {
    _checkValue6 = value ?? false;
    notifyListeners();
  }

  void onCheckChanged7(bool? value) {
    _checkValue7 = value ?? false;
    notifyListeners();
  }

  void onCheckChanged8(bool? value) {
    _checkValue8 = value ?? false;
    notifyListeners();
  }

  void onCheckChanged9(bool? value) {
    _checkValue9 = value ?? false;
    notifyListeners();
  }

  void goToPropertyOwnerIdentificationView() {
    _navigationService.navigateTo(Routes.propertyOwnerIdentificationView);
  }
}
