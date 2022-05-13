import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';';
import 'package:resavation/ui/views/property_owner_spaceType/property_owner_spacetype_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';

class PropertyOwnerDetailsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();

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

  void goToPropertyOwnerAddPhotosView(
      PropertyOwnerUploadModel propertyOwnerUploadModel) {
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
