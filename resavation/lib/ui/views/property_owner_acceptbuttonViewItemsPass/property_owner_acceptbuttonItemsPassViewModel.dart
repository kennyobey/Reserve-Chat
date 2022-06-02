import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/property_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyOwnerAcceptbuttonItemsPassViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  // List<Property> get properties => listOfProperties;
  List<Property> get properties => [];

  bool _notificationSwitchValue = false;
  bool get notificationSwitchValue => _notificationSwitchValue;
  get goToPropertyDetails => null;

  void onNotificationSwitchChanged(bool? value) {
    _notificationSwitchValue = value!;
    notifyListeners();
  }

  void goToPropertyOwnerAppointmentPageoneView() {
    _navigationService.navigateTo(Routes.propertyOwnerVerificationView);
  }

  void goPropertyOwnerProfileView() {
    _navigationService.navigateTo(Routes.propertyOwnerProfileView);
  }

  bool _appNotificationSwitchValue = false;
  bool get appNotificationSwitchValue => _appNotificationSwitchValue;

  void onAppNotificationSwitchValue(bool? value) {
    _appNotificationSwitchValue = value!;
    notifyListeners();
  }
}
