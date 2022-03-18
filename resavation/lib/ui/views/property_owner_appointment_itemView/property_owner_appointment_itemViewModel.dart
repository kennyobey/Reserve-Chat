import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyOwnerAppointmentItemViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  bool _notificationSwitchValue = false;
  bool get notificationSwitchValue => _notificationSwitchValue;

  void onNotificationSwitchChanged(bool? value) {
    _notificationSwitchValue = value!;
    notifyListeners();
  }

  void goToPropertyOwnerAppointmentPageoneView() {
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
