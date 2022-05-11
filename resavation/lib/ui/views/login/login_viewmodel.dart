import 'dart:async';

import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/login_model.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:resavation/services/core/user_type_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LogInViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();
  final userTypeService = locator<UserTypeService>();

  late LoginModel logIn;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Global Keys to use with the form text fields
  final loginFormKey = GlobalKey<FormState>();
  late Timer timer;

  bool isLoading = false;

  // Login user
  onLoginButtonTap() async {
    isLoading = true;
    notifyListeners();
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    try {
      await httpService.loginUser(email, password);
      isLoading = false;
      notifyListeners();
    } catch (exception) {
      isLoading = false;
      notifyListeners();
      return Future.error(exception.toString());
    }
  }

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
