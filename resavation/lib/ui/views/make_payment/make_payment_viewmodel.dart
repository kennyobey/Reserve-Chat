import 'package:resavation/app/app.locator.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:resavation/services/core/user_type_service.dart';
import 'package:stacked/stacked.dart';

class MakePaymentViewModel extends BaseViewModel {
  final _httpService = locator<HttpService>();
  final _userService = locator<UserTypeService>();

  final String authorization =
      'sk_live_46a536fc03e687b0ffd42e3a3a09dd82198eb848';
  bool isLoading = false;
  bool hasErrorOnData = false;

  String webLink = '';

  MakePaymentViewModel(double planAmount, String subscriptionCode) {
    getData(planAmount, subscriptionCode);
  }

  void getData(
    double planAmount,
    String subscriptionCode,
  ) async {
    isLoading = true;

    hasErrorOnData = false;

    notifyListeners();
    try {
      final email = _userService.userData.email;
      webLink = await _httpService.getPaymentLink(
          email: email,
          amount: planAmount.toInt(),
          subscriptionCode: subscriptionCode,
          authorization: authorization);

      hasErrorOnData = false;
    } catch (exception) {
      hasErrorOnData = true;
    }
    isLoading = false;
    notifyListeners();
  }
}
