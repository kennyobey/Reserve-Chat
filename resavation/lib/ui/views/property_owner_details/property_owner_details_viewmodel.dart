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

  // To upoload property to the server

  void upoloadPropertyToServer() async{
    final String propertyName = propertyNameController.text;
    final String description = propertDescriptionController.text;
    final String address = propertAddressController.text;

   //httpService.uploadProperty(address, amenities, availability, bathTubCount, bedroomCount, carSlots, city, country, description, imageUrl, listingOption, liveInSPace, propertyName, roomType, rules, spaceFurnished, spacePrice, spaceServiced, spaceType, state, subscription, surfaceArea);
  }

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
