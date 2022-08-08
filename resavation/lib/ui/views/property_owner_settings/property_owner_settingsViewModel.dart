import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/utility/app_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyOwnerSettingsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  bool _notificationSwitchValue = false;
  bool get notificationSwitchValue => _notificationSwitchValue;

  void onNotificationSwitchChanged(bool? value) {
    _notificationSwitchValue = value!;
    notifyListeners();
  }

  bool _appNotificationSwitchValue = false;
  bool get appNotificationSwitchValue => _appNotificationSwitchValue;

  void onAppNotificationSwitchValue(bool? value) {
    _appNotificationSwitchValue = value!;
    notifyListeners();
  }

  void goToFilterView() {
    _navigationService.navigateTo(Routes.filterView);
  }

  void logout() async {
    AppPreferences.setRefeshTokenAndAccessRole(
        token: '', accessRoles: [], tokenType: '');
    await _navigationService.clearStackAndShow(Routes.onboardingView);
  }
}
