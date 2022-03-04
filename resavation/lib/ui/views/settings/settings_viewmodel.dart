import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/services/core/custom_snackbar_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<CustomSnackbarService>();
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
    await _navigationService.clearStackAndShow(Routes.onboardingView);
  }

  void showComingSoon() {
    _snackbarService.showComingSoon();
  }

  void goToPropertyOwner() {
    _navigationService.navigateTo(Routes.propertyOwnerStep1View);
  }

  void goToEditProfileView() {
    _navigationService.navigateTo(Routes.editProfileView);
  }

  void goToResetPasswordView() {
    _navigationService.navigateTo(Routes.resetPasswordView);
  }
}
