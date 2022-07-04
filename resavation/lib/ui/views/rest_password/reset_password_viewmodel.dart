import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';
import '../../../services/core/user_type_service.dart';

class ResetPasswordViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();
  final userTypeService = locator<UserTypeService>();

  // A controller for each field
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final otpFieldController = TextEditingController();
  final verifyPasswordFieldController = TextEditingController();

  // Global Keys to use with the form text fields
  final formKey = GlobalKey<FormState>();

  final stage1FormKey = GlobalKey<FormState>();
  final stage2FormKey = GlobalKey<FormState>();
  final stage3FormKey = GlobalKey<FormState>();

  ///used to check if a valid mail is existing
  String? verifyEmail() {
    final String email = emailFieldController.text.trim();
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@+[a-zA-Z0-9]+\.[a-zA-Z]")
        .hasMatch(email);

    if (email.isEmpty) {
      return 'Please provide your email.';
    } else if (!emailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  final pageController = PageController();

  int _pagePosition = 0;

  bool isStage1Loading = false;
  bool isStage2Loading = false;

  int get pagePosition => _pagePosition;

  void onPageChanged(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
    _pagePosition = index;
    notifyListeners();
  }

  sendResetPasswordLink() async {
    isStage2Loading = true;
    notifyListeners();
    final String email = emailFieldController.text.trim();
    final String otp = otpFieldController.text.trim();
    final String password = passwordFieldController.text.trim();
    final String confirmPassword = verifyPasswordFieldController.text.trim();

    try {
      await httpService.forgotPassword(
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          otp: otp);
      isStage2Loading = false;
      notifyListeners();
    } catch (exception) {
      isStage2Loading = false;
      notifyListeners();
      return Future.error(exception.toString());
    }
  }

  sendOTP() async {
    isStage1Loading = true;
    notifyListeners();
    final String email = emailFieldController.text.trim();
    try {
      await httpService.forgotPasswordOtp(email: email);
      isStage1Loading = false;
      notifyListeners();
    } catch (exception) {
      isStage1Loading = false;
      notifyListeners();
      return Future.error(exception.toString());
    }
  }

  void goToLogin() {
    _navigationService.clearStackAndShow(Routes.logInView);
  }

  void goToSignUpView() {
    _navigationService.popRepeated(2);
    _navigationService.navigateTo(Routes.signUpView);
  }
}
