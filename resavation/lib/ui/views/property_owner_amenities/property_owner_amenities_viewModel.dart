import 'package:resavation/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';
import '../../../model/login_model.dart';
import '../../../services/core/http_service.dart';
import '../../../services/core/upload_type_service.dart';

import '../../../services/core/user_type_service.dart';

class PropertyOwnerAmenitiesViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();
  final _userService = locator<UserTypeService>();
  LoginModel get userData => _userService.userData;
  final propertyOwnerUploadModel = locator<UploadTypeService>();

  List<String> amenities = [];
  List<String> rules = [];

  PropertyOwnerAmenitiesViewModel() {
    propertyOwnerUploadModel.clearStage5();
  }

  void PropertyOwnerVerificationView(BuildContext context) async {
    propertyOwnerUploadModel.amenities = amenities;
    propertyOwnerUploadModel.rules = rules;

    // _navigationService.navigateTo(Routes.propertyOwnerVerificationView);
  }

  void PropertyOwnerAcceptbuttonView() {
    // _navigationService.navigateTo(Routes.propertyOwnerAcceptbuttonView);
  }

  deleteAmenity(String ameniti) {
    amenities.remove(ameniti);
    notifyListeners();
  }

  addAmenity(String amenity) {
    amenities.add(amenity);

    notifyListeners();
  }

  deleteRule(String rule) {
    rules.remove(rule);
    notifyListeners();
  }

  addRules(String rule) {
    rules.add(rule);
    notifyListeners();
  }
}
