import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/services/core/custom_snackbar_service.dart';
import 'package:resavation/services/core/user_type_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<CustomSnackbarService>();
  final _userTypeService = locator<UserTypeService>();
  bool _notificationSwitchValue = false;
  bool get notificationSwitchValue => _notificationSwitchValue;

  // to check the current state of the user
  bool returnUserType() {
    return _userTypeService.isTenant;
  }

  /// updates the user to a property owner
  toggleUserType() {
    _userTypeService.toggleUserType();
    notifyListeners();
  }

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
    _userTypeService.error.value = "";
    await _navigationService.clearStackAndShow(Routes.logInView);
    _userTypeService.serCurrentIndex(0);
  }

  void showComingSoon() {
    _snackbarService.showComingSoon();
  }

  void goToPropertyOwnerSpacetypeView() {
    _navigationService.navigateTo(Routes.propertyOwnerSpaceTypeView);
  }

  void resetView() {
    _userTypeService.serCurrentIndex(0);
    notifyListeners();
  }

  void goToEditProfileView() {
    _navigationService.navigateTo(Routes.editProfileView);
  }

  void goToResetPasswordView() {
    _navigationService.navigateTo(Routes.resetPasswordView,
        arguments: ResetPasswordViewArguments(isForgotPassword: false));
  }

  bool get hasOwnerRole {
    return _userTypeService.hasOwnerRole;
  }
}
