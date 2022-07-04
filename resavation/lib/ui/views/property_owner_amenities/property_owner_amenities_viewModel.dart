import 'package:resavation/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';
import '../../../model/login_model.dart';
import '../../../services/core/http_service.dart';
import 'package:resavation/services/core/upload_service.dart';

import '../../../services/core/user_type_service.dart';

class PropertyOwnerAmenitiesViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();
  final _userService = locator<UserTypeService>();
  LoginModel get userData => _userService.userData;
  final propertyOwnerUploadModel = locator<UploadService>();

  List<String> amenities = [];
  List<String> rules = [];

  PropertyOwnerAmenitiesViewModel() {
    if (propertyOwnerUploadModel.isRestoringData) {
      setUpPreviousData();
    } else {
      propertyOwnerUploadModel.clearStage5();
    }
  }

  setUpPreviousData() {
    amenities = propertyOwnerUploadModel.amenities;
    rules = propertyOwnerUploadModel.rules;
    notifyListeners();
  }

  void updateData() {
    propertyOwnerUploadModel.amenities = amenities;
    propertyOwnerUploadModel.rules = rules;
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
