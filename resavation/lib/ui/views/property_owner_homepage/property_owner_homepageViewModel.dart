import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyOwnerHomePageViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void goToPropertyOwnerIdentificationVerificationView() {
    _navigationService
        .navigateTo(Routes.propertyOwnerIdentificationVerificationView);
  }

  void goToPropertyOwnerSpaceTypeView() {
    _navigationService.navigateTo(Routes.propertyOwnerSpaceTypeView);
  }
}
