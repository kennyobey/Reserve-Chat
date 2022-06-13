import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/upload_type_service.dart';

class PropertyOwnerDetailsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final uploadTypeService = locator<UploadTypeService>();

  final uploadFormKey = GlobalKey<FormState>();
  String selectedCountry = "Select Country";

  final TextEditingController propertyNameController = TextEditingController();
  final TextEditingController propertyDescriptionController =
      TextEditingController();
  final TextEditingController propertyAddressController =
      TextEditingController();
  final TextEditingController surfaceAreaController = TextEditingController();
  final TextEditingController propertyStateController = TextEditingController();
  final TextEditingController propertyCityController = TextEditingController();

  PropertyOwnerDetailsViewModel() {
    uploadTypeService.clearStage2();
  }

  @override
  void dispose() {
    propertyNameController.dispose();
    propertyDescriptionController.dispose();
    propertyAddressController.dispose();
    surfaceAreaController.dispose();
    propertyStateController.dispose();
    propertyCityController.dispose();
    super.dispose();
  }

  void goToPropertyOwnerAddPhotosView() {
    uploadTypeService.propertyName = propertyNameController.text.trim();
    uploadTypeService.propertyDescription =
        propertyDescriptionController.text.trim();
    uploadTypeService.address = propertyAddressController.text.trim();
    uploadTypeService.surfaceArea =
        int.tryParse(surfaceAreaController.text.trim()) ?? 0;
    uploadTypeService.state = propertyStateController.text.trim();
    uploadTypeService.city = propertyCityController.text.trim();
    uploadTypeService.country = selectedCountry;

    _navigationService.navigateTo(Routes.propertyOwnerAddPhotosView);
  }

  // country picker UI logic

  void onSelectCountryTap(Country country) {
    selectedCountry = country.name.toString();
    notifyListeners();
  }

  //Google Map
  void goToMapView() {
    _navigationService.navigateTo(Routes.mapView);
  }
}
