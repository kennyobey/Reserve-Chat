import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class UserProfilePageViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void goToPropertyOwnerEditProfileView() {
    _navigationService.navigateTo(Routes.propertyOwnerEditProfileView);
  }

  void goToPropertyOwnerVerificationView() {
    _navigationService.navigateTo(Routes.propertyOwnerVerificationView);
  }
}
