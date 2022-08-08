import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../model/edit_profile_model.dart';
import '../../../model/login_model.dart';
import '../../../services/core/http_service.dart';
import '../../../services/core/user_type_service.dart';

class UserProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final _httpService = locator<HttpService>();

  final userFirstNameController = TextEditingController();
  final userLastNameController = TextEditingController();

  final _userService = locator<UserTypeService>();
  LoginModel get userData => _userService.userData;

  EditProfileModel? userProfile;

  bool hasErrorOnData = false;
  bool isLoading = true;

  void goToMainView() {
    _navigationService.navigateTo(Routes.mainView);
  }

  getProfile() async {
    isLoading = true;
    hasErrorOnData = false;
    notifyListeners();
    try {
      userProfile = await _httpService.getUserProfile();
    } catch (exception) {
      debugPrint(exception.toString());
      hasErrorOnData = true;
    }
    isLoading = false;
    notifyListeners();
  }

  void goToVerificationPage() {
    _navigationService.navigateTo(Routes.verificationPage);
  }

  void goToEditProfileView() {
    _navigationService.navigateTo(
      Routes.editProfileView,
      arguments: EditProfileViewArguments(userProfile: userProfile),
    );
  }
}
