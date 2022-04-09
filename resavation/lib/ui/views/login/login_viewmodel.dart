import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/login_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http/http.dart' as http;

class LogInViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Login Request Logic
  Future<LoginModel> loginUser(String email, String password) async {
    var response = await http.post(
        Uri.http("resavation-backend.herokuapp.com", "api/v1/auth/login"),
        body: {
          "email": email,
          "password": password,
        });
    var data = response.body;
    print(data);

    if (response.statusCode == 200) {
      String responseString = response.body;
      return loginModelFromJson(responseString);
    } else
      throw Exception("Failed to Login user");
  }

  // Login user
  // void onLoginButtonTap() async{
  //   final String email = emailController.text;
  //   final String password = passwordController.text;
  //
  //   print(email);
  //   print(password);
  //
  //   final LoginModel login = await loginUser(email, password);
  //
  // }

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
