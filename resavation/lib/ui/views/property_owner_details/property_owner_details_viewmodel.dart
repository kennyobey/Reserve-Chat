import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/ui/views/property_owner_spaceType/property_owner_spacetype_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';

class PropertyOwnerDetailsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();
  final PropertyOwnerUploadModel propertyOwnerUploadModel =
      PropertyOwnerUploadModel();

// Global Keys to use with the form text fields
  // final uploadFormKey = GlobalKey<FormState>();

  final TextEditingController propertyNameController = TextEditingController();
  final TextEditingController propertyDescriptionController =
      TextEditingController();
  final TextEditingController propertyAddressController =
      TextEditingController();
  final TextEditingController propertyStateController = TextEditingController();
  final TextEditingController propertyCityController = TextEditingController();

  // To upoload property to the server

  void upoloadPropertyToServer() async {
    final String propertyName = propertyNameController.text;
    final String description = propertyDescriptionController.text;
    final String address = propertyAddressController.text;
    final String state = propertyStateController.text;
    final String city = propertyCityController.text;

    httpService.uploadProperty(
        propertyName: propertyName,
        description: description,
        address: address,
        state: state,
        city: city,
        country: selectedCountry);
  }

  void goToPropertyOwnerAddPhotosView() {
    propertyOwnerUploadModel.propertyName = propertyNameController.text.trim();
    propertyOwnerUploadModel.propertyDescription =
        propertyDescriptionController.text.trim();
    propertyOwnerUploadModel.address = propertyAddressController.text.trim();
    propertyOwnerUploadModel.state = propertyStateController.text.trim();
    propertyOwnerUploadModel.city = propertyCityController.text.trim();
    _navigationService.navigateTo(Routes.propertyOwnerAddPhotosView,
        arguments: propertyOwnerUploadModel);
  }

  // country picker UI logic
  String selectedCountry = "Country";
  Function(Country) onSelectCountryTap(Country country) {
    return (Country country) {
      selectedCountry = country.name.toString();
      notifyListeners();
    };
  }

  //Google Map
  void goToMapView() {
    _navigationService.navigateTo(Routes.mapView);
  }
}

// class PropertyOwnerUploadModel {
//   ///stage 1 data
//   String? propertyType;
//   bool? isSpaceServiced;
//   bool? isSpaceFurnished;
//   String? listingOption;
//   String? propertyStatus;
//   bool? liveInSpace;
//   int? noOfBedroom;
//   int? noOfBathroom;
//   int? numberOfCarSLot;

//   ///stage 2 data
//   String? propertyName;
//   String? propertyDescription;
//   String? location;
//   String? state;
//   String? city;
//   String? address;

//   //add stage 3 data here
//   String? imageUrl;

//   //Stage 4 data
//   int? annualPrice;
//   int? biannualPrice;
//   int? monthlyPrice;
//   int? quarterlyPrice;
//   String? from;
//   String? to;

//   //Stage 5 data
//   List<String>? amenities;
//   List<String>? rules;

//   PropertyOwnerUploadModel({
//     this.propertyType,
//     this.isSpaceServiced,
//     this.isSpaceFurnished,
//     this.listingOption,
//     this.propertyStatus,
//     this.liveInSpace,
//     this.noOfBedroom,
//     this.noOfBathroom,
//     this.numberOfCarSLot,
//     this.propertyName,
//     this.propertyDescription,
//     this.location,
//     this.state,
//     this.city,
//     this.address,
//     this.imageUrl,
//     this.annualPrice,
//     this.biannualPrice,
//     this.monthlyPrice,
//     this.quarterlyPrice,
//   });
// }
