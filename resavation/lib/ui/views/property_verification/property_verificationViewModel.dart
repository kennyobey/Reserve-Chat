import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyVerificationViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void goToPropertyOwnerHomePageView() {
    _navigationService.navigateTo(Routes.propertyOwnerHomePageView);
  }

  void goToDatePickerView() {
    _navigationService.navigateTo(Routes.datePickerView);
  }
}
