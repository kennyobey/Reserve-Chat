import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/utility/app_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';

class RefreshTokenViewModel extends BaseViewModel {
  final httpService = locator<HttpService>();
  final _navigationService = locator<NavigationService>();
  void goToLogin() {
    _navigationService.clearStackAndShow(Routes.logInView);
  }

  refreshToken() async {
    try {
      await httpService.refreshToken(AppPreferences.getRefeshToken, false);
      _navigationService.clearStackAndShow(Routes.mainView);
    } catch (exception) {
      _navigationService.clearStackAndShow(Routes.logInView);
    }
  }

  RefreshTokenViewModel() {
    refreshToken();
  }
}
