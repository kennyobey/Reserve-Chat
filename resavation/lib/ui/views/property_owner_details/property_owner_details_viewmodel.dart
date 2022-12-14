import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:resavation/services/core/upload_service.dart';

class PropertyOwnerDetailsViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
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
    getData();
  }

  getData() async {
    isLoading = true;
    hasErrorOnData = false;
    notifyListeners();
    try {
      states = await _httpService.getStates();
      if (uploadTypeService.isRestoringData) {
        setUpPreviousData();
      } else {
        uploadTypeService.clearStage2();
      }
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

    navigationService.navigateTo(Routes.propertyOwnerAddPhotosView);
  }

  saveStage2Data() async {
    uploadTypeService.propertyName = propertyNameController.text.trim();
    uploadTypeService.propertyDescription =
        propertyDescriptionController.text.trim();
    uploadTypeService.address = propertyAddressController.text.trim();
    uploadTypeService.surfaceArea =
        double.tryParse(surfaceAreaController.text.trim()) ?? 0;
    uploadTypeService.state = selectedState;
    uploadTypeService.city = propertyCityController.text.trim();

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
    navigationService.navigateTo(Routes.mapView);
  }

  void onStateChanged(value) {
    selectedState = value;
    notifyListeners();
  }
}
