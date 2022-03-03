import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PaymentViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  static const String payStackKey = "pk_test_e16fa6551c9df39291ec9a0d69efed432d1a6cb3";







  void goToConfirmationView() {
    _navigationService.navigateTo(Routes.confirmationView);
  }


}
