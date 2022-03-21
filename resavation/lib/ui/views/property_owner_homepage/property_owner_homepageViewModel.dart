import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyOwnerHomePageViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void goToPropertyOwnerAppointmentPageoneView() {
    _navigationService.navigateTo(Routes.propertyOwnerAppointmentPageoneView);
  }

  void goToPropertyOwnerSpaceTypeView() {
    _navigationService.navigateTo(Routes.propertyOwnerSpaceTypeView);
  }
}
