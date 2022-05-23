import 'dart:async';

import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:resavation/services/core/user_type_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();
  final userTypeService = locator<UserTypeService>();

  // Global Keys to use with the form text fields
  final registrationFormKey = GlobalKey<FormState>();

  // A controller for each field
  final emailFieldController = TextEditingController();
  final firstNameFieldController = TextEditingController();
  final lastNameFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final verifyPasswordFieldController = TextEditingController();

  bool _checkValue = false;
  bool get checkValue => _checkValue;
  String userType = "PROPERTY_OWNER";

  bool isLoading = false;

  // To send details to the server
  sendDetailsToServer() async {
    isLoading = true;
    notifyListeners();
    final String email = emailFieldController.text.trim();
    final String firstname = firstNameFieldController.text.trim();
    final String lastname = lastNameFieldController.text.trim();
    final String password = passwordFieldController.text.trim();
    final String verifyPassword = verifyPasswordFieldController.text.trim();
    final bool termAndCondition = _checkValue;
    final String accountType = userType.trim();
    try {
      await httpService.sendDetailsToServer(email, firstname, lastname,
          password, verifyPassword, termAndCondition, accountType);
      isLoading = false;
      notifyListeners();
    } catch (exception) {
      isLoading = false;
      notifyListeners();
      return Future.error(exception.toString());
    }
  }

  // To select the userType
  void onRadioChanged(String value) {
    userType = value.toString();
    notifyListeners();
  }

  void onCheckChanged(bool? value) {
    _checkValue = value ?? false;
    notifyListeners();
  }

  void goToLoginView() {
    _navigationService.replaceWith(Routes.logInView);
  }

  void goToMainView() {
    _navigationService.navigateTo(Routes.mainView);
  }

  //  User type UI Logic

  updateUserType() {
    userTypeService.userType();
    print(userTypeService.isTenant);
    notifyListeners();
  }

  void goToSignUpConfirmation() {
    final String email = emailFieldController.text.trim();
    _navigationService.navigateTo(Routes.signUpConfirmationView,
        arguments: email);
  }
}
