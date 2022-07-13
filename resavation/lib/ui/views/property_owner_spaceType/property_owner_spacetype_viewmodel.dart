import 'dart:async';

import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:resavation/services/core/upload_service.dart';

class PropertyOwnerSpaceTypeViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final _httpService = locator<HttpService>();
  final uploadTypeService = locator<UploadService>();
  final registrationFormKey = GlobalKey<FormState>();
  late Timer timer;

  bool isCategoryEnabled = false;

  bool hasErrorOnData = false;
  bool isLoading = true;

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
  String? propertyTypeValue;
  List<String> propertyStyleOption = ['---Empty---'];

  List<String> propertyStatus = ['---Empty---'];

  List<String> propertyCategories = ['---Empty---'];

  List<String> propertyTypeResidental = ['---Empty---'];

  List<String> propertyTypeCommercial = ['---Empty---'];

  List<String> propertyTypeIndustrial = ['---Empty---'];

  List<String> propertyTypeRetail = ['---Empty---'];

  List<String> get getPropertyTypeList {
    final propertyCategory = uploadTypeService.propertyCategory;
    if (propertyCategory == propertyCategories[0]) {
      return propertyTypeResidental;
    } else if (propertyCategory == propertyCategories[1]) {
      return propertyTypeCommercial;
    } else if (propertyCategory == propertyCategories[2]) {
      return propertyTypeIndustrial;
    } else if (propertyCategory == propertyCategories[3]) {
      return propertyTypeRetail;
    }

    return ['Error Occurred'];
  }

  bool? isSpaceServiced;
  bool? isSpaceFurnished;

  bool? liveInSpace;
  int noOfBedroom = 0;
  int noOfBathroom = 0;
  int numberOfCarSLot = 0;

  setUpPreviousData() {
    final propertyCategories = [
      "Residential",
      "Commercial",
      "Industrial",
      "Retail",
    ];
    this.liveInSpace = uploadTypeService.liveInSpace;
    this.isSpaceServiced = uploadTypeService.isSpaceServiced;
    this.isSpaceFurnished = uploadTypeService.isSpaceFurnished;
    propertyStyleValue = uploadTypeService.propertyStyle;

    final propertyCategory = uploadTypeService.propertyCategory;
    if (propertyCategory == propertyCategories[0]) {
      propertyTypeValue = uploadTypeService.residentialPropertyType;
    } else if (propertyCategory == propertyCategories[1]) {
      propertyTypeValue = uploadTypeService.commercialPropertyType;
    } else if (propertyCategory == propertyCategories[2]) {
      propertyTypeValue = uploadTypeService.industrialPropertyType;
    } else if (propertyCategory == propertyCategories[3]) {
      propertyTypeValue = uploadTypeService.retailPropertyType;
    }

    isCategoryEnabled = uploadTypeService.propertyCategory != null;
    noOfBedroom = uploadTypeService.noOfBedroom;
    noOfBathroom = uploadTypeService.noOfBathroom;
    numberOfCarSLot = uploadTypeService.numberOfCarSLot;
    notifyListeners();
  }

  PropertyOwnerSpaceTypeViewModel() {
    if (uploadTypeService.isRestoringData) {
      setUpPreviousData();
    } else {
      uploadTypeService.clearStage1();
    }
    getData();
  }

  getData() async {
    isLoading = true;
    hasErrorOnData = false;
    notifyListeners();
    try {
      propertyTypeCommercial = await _httpService.getCommercialPropertyTypes();
      propertyTypeIndustrial = await _httpService.getIndustrialPropertyTypes();
      propertyTypeResidental = await _httpService.getResidentialPropertyTypes();
      propertyTypeRetail = await _httpService.getRetailPropertyTypes();
      propertyCategories = await _httpService.getPropertyCategories();
      propertyStatus = await _httpService.getPropertyStatus();
      propertyStyleOption = await _httpService.getPropertyStyle();
    } catch (exception) {
      hasErrorOnData = true;
    }
    isLoading = false;
    notifyListeners();
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
    final propertyCategory = uploadTypeService.propertyCategory;
    if (propertyCategory == propertyCategories[0]) {
      uploadTypeService.residentialPropertyType = value;
    } else if (propertyCategory == propertyCategories[1]) {
      uploadTypeService.commercialPropertyType = value;
    } else if (propertyCategory == propertyCategories[2]) {
      uploadTypeService.industrialPropertyType = value;
    } else if (propertyCategory == propertyCategories[3]) {
      uploadTypeService.retailPropertyType = value;
    }
    propertyTypeValue = value;
    notifyListeners();
  }

  void onPropertyCategoriesValueChange(value) {
    uploadTypeService.propertyCategory = value;
    uploadTypeService.commercialPropertyType = null;
    uploadTypeService.retailPropertyType = null;
    propertyTypeValue = null;
    uploadTypeService.industrialPropertyType = null;
    uploadTypeService.residentialPropertyType = null;

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
    navigationService.navigateTo(
      Routes.propertyOwnerDetailsView,
    );
  }

  saveStage1Data() async {
    try {
      await _httpService.saveProperty(
        uploadTypeService: uploadTypeService,
        images: [],
      );
      return;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
