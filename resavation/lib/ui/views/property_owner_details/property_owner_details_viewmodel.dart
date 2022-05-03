import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/upload_property_model.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyOwnerDetailsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();

  late UploadProperty logIn;

  final TextEditingController propertyNameController = TextEditingController();
  final TextEditingController propertDescriptionController = TextEditingController();
  final TextEditingController propertAddressController = TextEditingController();

  void goToPropertyOwnerAddPhotosView() {
    _navigationService.navigateTo(Routes.propertyOwnerAddPhotosView);
  }

  // country picker UI logic
  String selectedCountry = "Country";
  Function(Country) onSelectCountryTap(Country country){
      return   (Country country){
      selectedCountry = country.name.toString();
      notifyListeners();
    };
  }

  //Google Map
  void goToMapView() {
    _navigationService.navigateTo(Routes.mapView);
  }
}
