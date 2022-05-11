import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';

class PropertyOwnerAmenitiesViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();

  /// Checkboxes are named to fit their corresponding value
  /// To enable for easy recognition and usage

  void upoloadPropertyToServer(
      List<String>? amenities, List<String>? rules) async {
    httpService.uploadProperty(amenities: amenities, rules: rules);
  }

  List amenities = [];

  bool _hasWifi = false;
  bool get hasWifi => _hasWifi;

  bool _hasMachine = false;
  bool get hasMachine => _hasMachine;

  bool _hasAC = false;
  bool get hasAC => _hasAC;

  bool _hasTV = false;
  bool get hasTV => _hasTV;

  bool _hasHairDryer = false;
  bool get hasHairDryer => _hasHairDryer;

  bool _hasFireAlarm = false;
  bool get hasFireAlarm => _hasFireAlarm;

  bool _smoking = false;
  bool get smoking => _smoking;

  bool _pets = false;
  bool get pets => _pets;

  bool _houseParty = false;
  bool get houseParty => _houseParty;

  void onHasWifiChange(bool? value) {
    _hasWifi = value!;
    notifyListeners();
  }

  void onCheckChanged2(bool? value) {
    _hasMachine = value ?? false;
    if (amenities.contains("Machine")) {
      amenities.remove("Machine");
      print(amenities);
    } else {
      amenities.add("Machine");
      print(amenities);
    }

    notifyListeners();
  }

  void onCheckChanged3(bool? value) {
    _hasAC = value ?? false;
    notifyListeners();
  }

  void onCheckChanged4(bool? value) {
    _hasTV = value ?? false;
    notifyListeners();
  }

  void onCheckChanged5(bool? value) {
    _hasHairDryer = value ?? false;
    notifyListeners();
  }

  void onCheckChanged6(bool? value) {
    _hasFireAlarm = value ?? false;
    notifyListeners();
  }

  void onCheckChanged7(bool? value) {
    _smoking = value ?? false;
    notifyListeners();
  }

  void onCheckChanged8(bool? value) {
    _pets = value ?? false;
    notifyListeners();
  }

  void onCheckChanged9(bool? value) {
    _houseParty = value ?? false;
    notifyListeners();
  }

  void goToPropertyOwnerIdentificationView() {
    _navigationService.navigateTo(Routes.propertyOwnerIdentificationView);
  }
}
