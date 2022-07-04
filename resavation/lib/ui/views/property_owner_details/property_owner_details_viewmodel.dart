import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:resavation/services/core/upload_service.dart';

class PropertyOwnerDetailsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final uploadTypeService = locator<UploadService>();
  final _httpService = locator<HttpService>();
  final uploadFormKey = GlobalKey<FormState>();

  final TextEditingController propertyNameController = TextEditingController();
  final TextEditingController propertyDescriptionController =
      TextEditingController();
  final TextEditingController propertyAddressController =
      TextEditingController();
  final TextEditingController surfaceAreaController = TextEditingController();
  final TextEditingController propertyCityController = TextEditingController();

  List<String> states = ['---Empty---'];
  String? selectedState;
  bool hasErrorOnData = false;
  bool isLoading = true;

  PropertyOwnerDetailsViewModel() {
    if (uploadTypeService.isRestoringData) {
      setUpPreviousData();
    } else {
      uploadTypeService.clearStage2();
    }
    getData();
  }

  getData() async {
    isLoading = true;
    hasErrorOnData = false;
    notifyListeners();
    try {
      states = await _httpService.getStates();
    } catch (exception) {
      hasErrorOnData = true;
    }
    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    propertyNameController.dispose();
    propertyDescriptionController.dispose();
    propertyAddressController.dispose();
    surfaceAreaController.dispose();
    propertyCityController.dispose();
    super.dispose();
  }

  void goToPropertyOwnerAddPhotosView() {
    uploadTypeService.propertyName = propertyNameController.text.trim();
    uploadTypeService.propertyDescription =
        propertyDescriptionController.text.trim();
    uploadTypeService.address = propertyAddressController.text.trim();
    uploadTypeService.surfaceArea =
        double.tryParse(surfaceAreaController.text.trim()) ?? 0;
    uploadTypeService.state = selectedState;
    uploadTypeService.city = propertyCityController.text.trim();

    _navigationService.navigateTo(Routes.propertyOwnerAddPhotosView);
  }

  setUpPreviousData() {
    propertyNameController.text = uploadTypeService.propertyName ?? '';
    propertyDescriptionController.text =
        uploadTypeService.propertyDescription ?? '';
    propertyAddressController.text = uploadTypeService.address ?? '';
    surfaceAreaController.text =
        (uploadTypeService.surfaceArea ?? 0).toString();
    selectedState = uploadTypeService.state;
    propertyCityController.text = uploadTypeService.city ?? '';
    notifyListeners();
  }

  //Google Map
  void goToMapView() {
    _navigationService.navigateTo(Routes.mapView);
  }

  void onStateChanged(value) {
    selectedState = value;
    notifyListeners();
  }
}
