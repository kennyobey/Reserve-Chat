import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LogInViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  bool _checkValue = false;
  bool get checkValue => _checkValue;

  void onCheckChanged(bool? value) {
    _checkValue = value ?? false;
    notifyListeners();
  }

  void goToResetPasswordView() {
    _navigationService.navigateTo(Routes.resetPasswordView);
  }

  void goToSignUpView() {
    _navigationService.replaceWith(Routes.signUpView);
  }

  void goToMainView() {
    _navigationService.clearStackAndShow(Routes.mainView);
  }
}
