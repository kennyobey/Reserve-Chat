import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';

class VerifyUserAccountViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _httpService = locator<HttpService>();
  final otpFieldController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isLoadingEnabled = false;

  verifyOTP(String email) async {
    isLoadingEnabled = true;
    notifyListeners();

    try {
      await _httpService.confirmRegByOTP(
          email: email, otp: otpFieldController.text.trim());
      isLoadingEnabled = false;
      notifyListeners();
    } catch (exception) {
      isLoadingEnabled = false;
      notifyListeners();
      return Future.error(exception.toString());
    }
  }

  void goToLoginView() {
    _navigationService.clearStackAndShow(Routes.logInView);
  }
}
