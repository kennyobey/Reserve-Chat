import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/services/core/upload_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../model/login_model.dart';
import '../../../services/core/user_type_service.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer';

class PropertyOwnerHomePageViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserTypeService>();
  final requestSite = "resavation-backend.herokuapp.com";
  final _uploadService = locator<UploadService>();

  LoginModel get userData => _userService.userData;
  final userTypeService = locator<UserTypeService>();

  void goToPropertyOwnerIdentificationVerificationView() {
    _navigationService
        .navigateTo(Routes.propertyOwnerIdentificationVerificationView);
  }

  void goToPropertyOwnerSpaceTypeView(bool isRestoringData) {
    _uploadService.isRestoringData = isRestoringData;
    _navigationService.navigateTo(Routes.propertyOwnerSpaceTypeView);
  }

  void goToPropertyOwnerAnalyticView() {
    _navigationService.navigateTo(Routes.propertyOwnerAnalyticView);
  }

  void goToMessage() {
    _navigationService.navigateTo(Routes.messagesView);
  }

  void PropertyOwnerMyPropertyView() {
    _navigationService.navigateTo(Routes.propertyOwnerMyPropertyView);
  }

  void PropertyOwnerTrackListView() {
    _navigationService.navigateTo(Routes.propertyOwnerTrackListView);
  }

  void CoWorkingSpaceAboutView() {
    _navigationService.navigateTo(Routes.coWorkingSpaceAboutView);
  }

  void UserProfilePageView() {
    _navigationService.navigateTo(Routes.userProfilePageView);
  }

  getBookedProperty() async {
    print("object");
    try {
      var response = await http.get(
        Uri.http(requestSite, "/api/v1/owner/property/booked/all"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': userTypeService.authorization
        },
      );
      log(response.body);
      // if (response.statusCode == 200) {
      //   return fromJson(response.body);
      // } else {
      //   return Future.error(json.decode(response.body)['message'] ?? '');
      // }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
    notifyListeners();
  }
}
