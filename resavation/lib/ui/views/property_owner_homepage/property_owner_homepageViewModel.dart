import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../model/login_model.dart';
import '../../../services/core/user_type_service.dart';

class PropertyOwnerHomePageViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserTypeService>();

  LoginModel get userData => _userService.userData;

  void goToPropertyOwnerIdentificationVerificationView() {
    _navigationService
        .navigateTo(Routes.propertyOwnerIdentificationVerificationView);
  }

  void goToPropertyOwnerSpaceTypeView() {
    _navigationService.navigateTo(Routes.propertyOwnerSpaceTypeView);
  }

  void goToPropertyOwnerAnalyticView() {
    _navigationService.navigateTo(Routes.propertyOwnerAnalyticView);
  }

  void goToMessage() {
    _navigationService.navigateTo(Routes.messagesView);
  }

  void PropertyOwnerMyPropertyView() {
    _navigationService.navigateTo(Routes.propertyOwnerMyPropertyView);
  }

  void PropertyOwnerTrackListView() {
    _navigationService.navigateTo(Routes.propertyOwnerTrackListView);
  }

  void CoWorkingSpaceAboutView() {
    _navigationService.navigateTo(Routes.coWorkingSpaceAboutView);
  }
}
