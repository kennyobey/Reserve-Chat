import 'dart:io';

import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/registration_model.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:resavation/services/core/user_type_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class SignUpViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();
  final userTypeService = locator<UserTypeService>();


  // Global Keys to use with the form text fields
  final registrationFormKey = GlobalKey<FormState>();
  late Timer timer;

  // A controller for each field
  final emailFieldController = TextEditingController();
  final firstNameFieldController = TextEditingController();
  final lastNameFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final verifyPasswordFieldController = TextEditingController();


  bool _checkValue = false;
  bool get checkValue => _checkValue;
  String userType = "PROPERTY_OWNER";


  // To send details to the server
  void sendDetailsToServer() async {
    final String email = emailFieldController.text;
    final String firstname =
        firstNameFieldController.text;
    final String lastname =
        lastNameFieldController.text;
    final String password =
        passwordFieldController.text;
    final String verifyPassword =
        verifyPasswordFieldController.text;
    final bool termAndCondition = true;

    final String accountType = userType;
    httpService.sendDetailsToServer(email, firstname, lastname, password, verifyPassword, termAndCondition, accountType);
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

}
