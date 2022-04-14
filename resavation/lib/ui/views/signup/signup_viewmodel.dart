import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/registration_model.dart';
import 'package:resavation/services/core/user_type_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class SignUpViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // Global Keys to use with the form text fields
  final registrationFormKey = GlobalKey<FormState>();

  late Timer timer;

  // A controller for each field
  final emailFieldController = TextEditingController();
  final firstNameFieldController = TextEditingController();
  final lastNameFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final verifyPasswordFieldController = TextEditingController();

  Future<RegistrationModel> registerUser(
      String accountType,
      String email,
      String firstname,
      String lastname,
      String password,
      bool termAndCondition,
      String verifyPassword) async {
    final String apiUrl =
        "https://resavation-backend.herokuapp.com/api/v1/auth/register";

    final response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
      'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic> {
      "accountType": accountType,
      "email": email,
      "firstname": firstname,
      "lastname": lastname,
      "password": password,
      "termAndCondition": termAndCondition,
      "verifyPassword": verifyPassword,
    }));

    if (response.statusCode == 200) {
      final dynamic registrationResponse = response.body;
      print("The Result${response.body}");
      return registrationModelFromJson(registrationResponse);
    } else {
      throw Exception('Failed to create registration.');
    }
  }

  bool _checkValue = false;

  bool get checkValue => _checkValue;
  String userType = "PROPERTY_OWNER";


  // To send details to the server
  void sendDetailsToServer() async {

    notifyListeners();

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
  final _userTypeService = locator<UserTypeService>();
  updateUserType(){
    _userTypeService.userType();
    print(_userTypeService.isTenant);
    notifyListeners();
  }

  @override
  void initState() {

    sendDetailsToServer();


  }
}