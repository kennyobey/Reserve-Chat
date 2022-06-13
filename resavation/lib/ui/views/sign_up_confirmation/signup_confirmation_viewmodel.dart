import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpConfirmationViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _httpService = locator<HttpService>();

  void goToVerifyUser(String email) {
    _navigationService.replaceWith(Routes.verifyUserAccount,
        arguments: VerifyUserAccountArguments(email: email));
  }

  resendCode(String email) async {
    try {
      await _httpService.resendOTP(email: email);
    } catch (exception) {
      return Future.error(
        exception.toString(),
      );
    }
  }
}
