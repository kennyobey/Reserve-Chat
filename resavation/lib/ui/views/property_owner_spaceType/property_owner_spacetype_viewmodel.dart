import 'dart:async';

import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:resavation/services/core/user_type_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyOwnerSpaceTypeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();
  final userTypeService = locator<UserTypeService>();
  final PropertyOwnerUploadModel propertyOwnerUploadModel =
      PropertyOwnerUploadModel();

  setLiveInSpace(bool? liveInSpace) {
    propertyOwnerUploadModel.liveInSpace = liveInSpace;
  }

  setSpaceServiced(bool? isServiced) {
    propertyOwnerUploadModel.isSpaceServiced = isServiced;
  }

  setSpaceFurnished(bool? isFurnished) {
    propertyOwnerUploadModel.isSpaceFurnished = isFurnished;
  }

  void upoloadPropertyToServer() async {
    httpService.uploadProperty(
        spaceServiced: false,
        // spaceFurnished: false,
        // liveInSPace: false,
        listingOption: [],
        bathTubCount: numberOfBathrooms,
        bedroomCount: numberOfBedrooms,
        carSlots: numberOfCarSlot);
  }

  // Global Keys to use with the form text fields
  final registrationFormKey = GlobalKey<FormState>();
  late Timer timer;

  bool _notificationSwitchValue = false;

  bool get notificationSwitchValue => _notificationSwitchValue;

  // drop-down button UI logic for spaceType
  String? selectedProperty;
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
  String? listingOptionValue;
  List<String> listingOption = [
    'Shared Space',
    'Entire Space',
    'Serviced',
    'Self Servced',
    'Shared',
    'Short Let'
  ];

  // drop-down button UI logic for property status
  String? propertyStatusValue;
  List<String> propertyStatus = ['For Sale', 'For Rent'];

  void onSelectedPropertyChange(value) {
    selectedProperty = value as String;
    propertyOwnerUploadModel.propertyType = selectedProperty;
    notifyListeners();
  }

  void onListingOptionValueChange(value) {
    listingOptionValue = value as String;
    propertyOwnerUploadModel.listingOption = listingOptionValue;
    notifyListeners();
  }

  void onPropertyStatusValueChange(value) {
    propertyStatusValue = value;
    propertyOwnerUploadModel.propertyStatus = propertyStatusValue;
    notifyListeners();
  }

  //is your space serviced UI logic
  bool isServiced = false;

  void onSpaceServicedRadioChange(bool? value) {
    isServiced == value!;
    if (isServiced == "Yes") {
      print("fjfffk ${true.toString()}");
    } else {
      print("Somethij");
    }
    notifyListeners();
  }

  // is your furnished  UI logic
  String isFurnished = "";

  void onSpaceFurnishedRadioChange(String value) {
    isFurnished = value.toString();
    notifyListeners();
  }

  // do you leave in this space  UI logic
  String leaveHere = "";

  void onLeaveHereRadioChange(String value) {
    leaveHere = value.toString();
    notifyListeners();
  }

  // Amenities selection logic
  int numberOfBedrooms = 0;
  int numberOfBathrooms = 0;
  int numberOfCarSlot = 0;

  // method for each amenities tap
  void onPositiveBedRoomTap() {
    numberOfBedrooms++;
    propertyOwnerUploadModel.noOfBedroom = numberOfBedrooms;
    notifyListeners();
  }

  void onNegativeBedRoomTap() {
    if (numberOfBedrooms != 0) {
      numberOfBedrooms--;
      propertyOwnerUploadModel.noOfBedroom = numberOfBedrooms;
    }
    notifyListeners();
  }

  void onPositiveBathRoomTap() {
    numberOfBathrooms++;
    propertyOwnerUploadModel.noOfBathroom = numberOfBathrooms;
    notifyListeners();
  }

  void onNegativeBathRoomTap() {
    if (numberOfBathrooms != 0) {
      numberOfBathrooms--;
      propertyOwnerUploadModel.noOfBathroom = numberOfBathrooms;
    }
    notifyListeners();
  }

  void onPositiveCarSlotTap() {
    numberOfCarSlot++;
    propertyOwnerUploadModel.numberOfCarSLot = numberOfCarSlot;
    notifyListeners();
  }

  void onNegativeCarSlotTap() {
    if (numberOfCarSlot != 0) {
      numberOfCarSlot--;
      propertyOwnerUploadModel.numberOfCarSLot = numberOfCarSlot;
    }

    notifyListeners();
  }

  void goToPropertyOwnerHomePageView() {
    _navigationService.navigateTo(Routes.propertyOwnerHomePageView);
  }

  void goToPropertyOwnerDetailsView() {
    _navigationService.navigateTo(Routes.propertyOwnerDetailsView,
        arguments: propertyOwnerUploadModel);
  }
}

class PropertyOwnerUploadModel {
  ///stage 1 data
  String? propertyType;
  bool? isSpaceServiced;
  bool? isSpaceFurnished;
  String? listingOption;
  String? propertyStatus;
  bool? liveInSpace;
  int? noOfBedroom;
  int? noOfBathroom;
  int? numberOfCarSLot;

  ///stage 2 data
  String? propertyName;
  String? propertyDescription;
  String? location;
  String? state;
  String? city;
  String? address;

  //add stage 3 data here
  String? imageUrl;

  //Stage 4 data
  int? annualPrice;
  int? biannualPrice;
  int? monthlyPrice;
  int? quarterlyPrice;
  String? from;
  String? to;

  //Stage 5 data
  List<String>? amenities;
  List<String>? rules;

  PropertyOwnerUploadModel({
    this.propertyType,
    this.isSpaceServiced,
    this.isSpaceFurnished,
    this.listingOption,
    this.propertyStatus,
    this.liveInSpace,
    this.noOfBedroom,
    this.noOfBathroom,
    this.numberOfCarSLot,
    this.propertyName,
    this.propertyDescription,
    this.location,
    this.state,
    this.city,
    this.address,
    this.imageUrl,
    this.annualPrice,
    this.biannualPrice,
    this.monthlyPrice,
    this.quarterlyPrice,
  });
}
