import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ResetPasswordViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void goToLogin() {
    _navigationService.navigateTo(Routes.logInView);
  }

  void goToSignUpView() {
    _navigationService.popRepeated(2);
    _navigationService.navigateTo(Routes.signUpView);
  }
}
