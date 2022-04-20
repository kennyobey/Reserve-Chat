import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/model/login_model.dart';
import 'package:resavation/model/registration_model.dart';
import 'package:resavation/services/core/user_type_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpService  {
  final userTypeService = locator<UserTypeService>();

  //final _httpService = locator<HttpService>();
  late RegistrationModel registration;
  final requestSite = "resavation-backend.herokuapp.com";

  // Sign-up Request Logic
  Future<RegistrationModel> registerUser(
    String accountType,
    String email,
    String firstname,
    String lastname,
    String password,
    String verifyPassword,
    bool termAndCondition,
  ) async {
    var response =
        await http.post(Uri.http(requestSite, "api/v1/auth/register"),
            headers: <String, String>{'Content-Type': 'application/json'},
            body: jsonEncode(<String, dynamic>{
              "verifyPassword": verifyPassword,
              "accountType": accountType,
              "email": email,
              "firstname": firstname,
              "lastname": lastname,
              "password": password,
              "termAndCondition": termAndCondition,
            }));
    var data = response.body;
    print(data);

    if (response.statusCode == 200) {
      String responseString = response.body;
      return registrationModelFromJson(responseString);
    } else
      throw Exception("Failed to Login user");
  }

  // Sign-In Request Logic
  void sendDetailsToServer(
      String email,
      String firstname,
      String lastname,
      String password,
      String verifyPassword,
      bool termAndCondition,
      String accountType) async {
    String? email;
    String? firstname;
    String? lastname;
    String? password;
    String? verifyPassword;
    bool? termAndCondition;
    String? accountType;

    RegistrationModel register = await registerUser(accountType!, email!,
        firstname!, lastname!, password!, verifyPassword!, termAndCondition!);

    @override
    void initState() {
      registration = register;
      //super.initState();
    }


  }

  // Login Request Logic
  Future<LoginModel> loginUser(String email, String password) async {
    var response = await http.post(Uri.http(requestSite, "api/v1/auth/login"),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password,
        }));

    if (response.statusCode == 200) {
      String responseString = response.body;
      return loginModelFromJson(responseString);
    } else if (response.statusCode == 400) {
      String responseString = response.body;
      userTypeService.error.value =  "Incorrect Username or Password";
      throw Exception(userTypeService.error.value);
    } else
      throw Exception("Failed to Login user");

  }



}
