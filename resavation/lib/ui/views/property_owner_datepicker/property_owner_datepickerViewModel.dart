import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyOwnerDatePickerViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void goToPropertyVerificationView() {
    _navigationService.navigateTo(Routes.propertyVerificationView);
  }

  void goToPropertyOwnerPaymentView() {
    _navigationService.navigateTo(Routes.propertyOwnerPaymentView);
  }
}
