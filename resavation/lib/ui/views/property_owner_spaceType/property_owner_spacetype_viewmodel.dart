import 'dart:async';

import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/upload_type_service.dart';

class PropertyOwnerSpaceTypeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final uploadTypeService = locator<UploadTypeService>();
  final registrationFormKey = GlobalKey<FormState>();
  late Timer timer;

  bool isCategoryEnabled = false;

  List<String> spaceType = [
    'Town House',
    'Plot of Land',
    'Detached Duplex',
    'Terace',
    'Flat',
    'Semi Detached Duplex',
    'Bungalow',
    'Luxury Apartent',
    'PentHouse',
    'Maisoneet',
    'Short-Let'
  ];

// drop-down button UI logic for Listing Option
  String? propertyStyleValue;
  List<String> propertyStyleOption = [
    'Shared Space',
    'Entire Space',
    // 'Serviced',
    // 'Self Servced',
    // 'Shared',
    'Short Let'
  ];

  List<String> propertyStatus = ['For Sale', 'For Rent'];

  final List<String> propertyCategories = [
    'Residential',
    'Commercial',
    'Industrial',
    'Retail',
  ];

  final List<String> propertyType1 = [
    'Duplex',
    'Detached House',
    'Terraced House',
    'Pent House',
    'Apartment',
    'Bungalow',
    'Mansion',
  ];
  final List<String> propertyType2 = [
    'Co-working space',
    'Private Office',
  ];
  final List<String> propertyType3 = [
    'Warehouse',
    'Factory',
  ];
  final List<String> propertyType4 = [
    'Building',
    'Shop',
  ];

  List<String> get getPropertyTypeList {
    final propertyCategory = uploadTypeService.propertyCategory;
    if (propertyCategory == propertyCategories[0]) {
      return propertyType1;
    } else if (propertyCategory == propertyCategories[1]) {
      return propertyType2;
    } else if (propertyCategory == propertyCategories[2]) {
      return propertyType3;
    } else if (propertyCategory == propertyCategories[3]) {
      return propertyType4;
    }

    return ['Error Occurred'];
  }

  bool? isSpaceServiced;
  bool? isSpaceFurnished;

  bool? liveInSpace;
  int noOfBedroom = 0;
  int noOfBathroom = 0;
  int numberOfCarSLot = 0;

  PropertyOwnerSpaceTypeViewModel() {
    uploadTypeService.clearStage1();
  }

  setLiveInSpace(bool liveInSpace) {
    this.liveInSpace = liveInSpace;
    uploadTypeService.liveInSpace = liveInSpace;
    notifyListeners();
  }

  setSpaceServiced(bool isServiced) {
    this.isSpaceServiced = isServiced;
    uploadTypeService.isSpaceServiced = isServiced;
    notifyListeners();
  }

  setSpaceFurnished(bool isFurnished) {
    this.isSpaceFurnished = isFurnished;
    uploadTypeService.isSpaceFurnished = isFurnished;
    notifyListeners();
  }

  void onSelectedSpaceTypeChange(value) {
    uploadTypeService.spaceType = value;
    notifyListeners();
  }

  void onPropertyStyleValueChange(value) {
    propertyStyleValue = value as String;
    uploadTypeService.propertyStyle = propertyStyleValue;
    notifyListeners();
  }

  void onPropertyStatusValueChange(value) {
    uploadTypeService.propertyStatus = value;
    notifyListeners();
  }

  void onPropertyTypeValueChange(value) {
    uploadTypeService.propertyType = value;
    notifyListeners();
  }

  void onPropertyCategoriesValueChange(value) {
    uploadTypeService.propertyCategory = value;
    uploadTypeService.propertyType = null;
    isCategoryEnabled = value != null;
    notifyListeners();
  }

  // method for each amenities tap
  void onPositiveBedRoomTap() {
    noOfBedroom++;
    uploadTypeService.noOfBedroom = noOfBedroom;
    notifyListeners();
  }

  void onNegativeBedRoomTap() {
    if (noOfBedroom != 0) {
      noOfBedroom--;
      uploadTypeService.noOfBedroom = noOfBedroom;

      notifyListeners();
    }
  }

  void onPositiveBathRoomTap() {
    noOfBathroom++;
    uploadTypeService.noOfBathroom = noOfBathroom;

    notifyListeners();
  }

  void onNegativeBathRoomTap() {
    if (noOfBathroom != 0) {
      noOfBathroom--;
      uploadTypeService.noOfBathroom = noOfBathroom;

      notifyListeners();
    }
  }

  void onPositiveCarSlotTap() {
    numberOfCarSLot++;
    uploadTypeService.numberOfCarSLot = numberOfCarSLot;

    notifyListeners();
  }

  void onNegativeCarSlotTap() {
    if (numberOfCarSLot != 0) {
      numberOfCarSLot--;
      uploadTypeService.numberOfCarSLot = numberOfCarSLot;

      notifyListeners();
    }
  }

  void goToPropertyOwnerDetailsView() {
    _navigationService.navigateTo(
      Routes.propertyOwnerDetailsView,
    );
  }
}
