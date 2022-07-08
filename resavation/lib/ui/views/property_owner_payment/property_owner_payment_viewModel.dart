import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/login_model.dart';
import 'package:resavation/services/core/user_type_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:resavation/services/core/upload_service.dart';

import '../../../services/core/http_service.dart';

class PropertyOwnerPaymentViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final uploadTypeService = locator<UploadService>();
  final _userService = locator<UserTypeService>();
  LoginModel get userData => _userService.userData;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  final _httpService = locator<HttpService>();
  List<String> subscriptionType = [
    'Monthly',
    'Quarterly',
    'Biannually',
    'Annually'
  ];

  String? displayPrice;

  final TextEditingController propertyannualPriceController =
      TextEditingController();
  final TextEditingController propertybiannualPriceController =
      TextEditingController();
  final TextEditingController propertymonthlyPriceController =
      TextEditingController();
  final TextEditingController propertyquaterlylPriceController =
      TextEditingController();

  List<String> selectedSubscriptions = [];

  PropertyOwnerPaymentViewModel() {
    if (uploadTypeService.isRestoringData) {
      setUpPreviousData();
    } else {
      uploadTypeService.clearStage4();
    }
  }

  bool isVerified() {
    bool isVerified = true;
    if (selectedSubscriptions.contains('Annually')) {
      isVerified = isVerified && propertyannualPriceController.text.isNotEmpty;
    }
    if (selectedSubscriptions.contains('Biannually')) {
      isVerified =
          isVerified && propertybiannualPriceController.text.isNotEmpty;
    }
    if (selectedSubscriptions.contains('Quarterly')) {
      isVerified =
          isVerified && propertyquaterlylPriceController.text.isNotEmpty;
    }
    if (selectedSubscriptions.contains('Monthly')) {
      isVerified = isVerified && propertymonthlyPriceController.text.isNotEmpty;
    }

    return isVerified;
  }

  void setSelectedSubscriptions(List<String> subscriptions) {
    selectedSubscriptions = subscriptions;
    displayPrice = null;
    notifyListeners();
  }

  void setDisplayPrice(price) {
    if (price is String) {
      displayPrice = price;
      notifyListeners();
    }
  }

  Future<void> selectStartDate(DateTime? pickedDate) async {
    if (pickedDate != null && pickedDate != startDate) {
      startDate = pickedDate;
      notifyListeners();
    }
  }

  Future<void> selectEndDate(DateTime? pickedDate) async {
    if (pickedDate != null && pickedDate != endDate) {
      endDate = pickedDate;
      notifyListeners();
    }
  }

  setUpPreviousData() {
    if (uploadTypeService.spacePrice != null) {
      if (uploadTypeService.spacePrice == uploadTypeService.annualPrice) {
        displayPrice = 'Annually';
      } else if (uploadTypeService.spacePrice ==
          uploadTypeService.biannualPrice) {
        displayPrice = 'Biannually';
      } else if (uploadTypeService.spacePrice ==
          uploadTypeService.quarterlyPrice) {
        displayPrice = 'Quarterly';
      } else if (uploadTypeService.spacePrice ==
          uploadTypeService.monthlyPrice) {
        displayPrice = 'Monthly';
      }
    }

    if (uploadTypeService.annualPrice != null) {
      propertyannualPriceController.text =
          (uploadTypeService.annualPrice ?? 0).toString();
      selectedSubscriptions.add('Annually');
    }
    if (uploadTypeService.biannualPrice != null) {
      propertybiannualPriceController.text =
          (uploadTypeService.biannualPrice ?? 0).toString();
      selectedSubscriptions.add('Biannually');
    }
    if (uploadTypeService.quarterlyPrice != null) {
      propertyquaterlylPriceController.text =
          (uploadTypeService.quarterlyPrice ?? 0).toString();
      selectedSubscriptions.add('Quarterly');
    }
    if (uploadTypeService.monthlyPrice != null) {
      propertymonthlyPriceController.text =
          (uploadTypeService.monthlyPrice ?? 0).toString();
      selectedSubscriptions.add('Monthly');
    }

    if (uploadTypeService.startDate != null) {
      startDate = uploadTypeService.startDate!;
    }
    if (uploadTypeService.endDate != null) {
      endDate = uploadTypeService.endDate!;
    }
    notifyListeners();
  }

  void goToPropertyOwnerAmenitiesView() {
    if (displayPrice == 'Annually') {
      uploadTypeService.spacePrice =
          int.tryParse(propertyannualPriceController.text);
    } else if (displayPrice == 'Biannually') {
      uploadTypeService.spacePrice =
          int.tryParse(propertybiannualPriceController.text);
    } else if (displayPrice == 'Quarterly') {
      uploadTypeService.spacePrice =
          int.tryParse(propertyquaterlylPriceController.text);
    } else if (displayPrice == 'Monthly') {
      uploadTypeService.spacePrice =
          int.tryParse(propertymonthlyPriceController.text);
    }

    if (selectedSubscriptions.contains('Annually')) {
      uploadTypeService.annualPrice =
          int.tryParse(propertyannualPriceController.text);
    }
    if (selectedSubscriptions.contains('Biannually')) {
      uploadTypeService.biannualPrice =
          int.tryParse(propertybiannualPriceController.text);
    }
    if (selectedSubscriptions.contains('Quarterly')) {
      uploadTypeService.quarterlyPrice =
          int.tryParse(propertyquaterlylPriceController.text);
    }
    if (selectedSubscriptions.contains('Monthly')) {
      uploadTypeService.monthlyPrice =
          int.tryParse(propertymonthlyPriceController.text);
    }

    uploadTypeService.startDate = startDate;
    uploadTypeService.endDate = endDate;

    navigationService.navigateTo(Routes.propertyOwnerAmenitiesView);
  }

  saveStage4Data() async {
    if (displayPrice == 'Annually') {
      uploadTypeService.spacePrice =
          int.tryParse(propertyannualPriceController.text);
    } else if (displayPrice == 'Biannually') {
      uploadTypeService.spacePrice =
          int.tryParse(propertybiannualPriceController.text);
    } else if (displayPrice == 'Quarterly') {
      uploadTypeService.spacePrice =
          int.tryParse(propertyquaterlylPriceController.text);
    } else if (displayPrice == 'Monthly') {
      uploadTypeService.spacePrice =
          int.tryParse(propertymonthlyPriceController.text);
    }

    if (selectedSubscriptions.contains('Annually')) {
      uploadTypeService.annualPrice =
          int.tryParse(propertyannualPriceController.text);
    }
    if (selectedSubscriptions.contains('Biannually')) {
      uploadTypeService.biannualPrice =
          int.tryParse(propertybiannualPriceController.text);
    }
    if (selectedSubscriptions.contains('Quarterly')) {
      uploadTypeService.quarterlyPrice =
          int.tryParse(propertyquaterlylPriceController.text);
    }
    if (selectedSubscriptions.contains('Monthly')) {
      uploadTypeService.monthlyPrice =
          int.tryParse(propertymonthlyPriceController.text);
    }

    uploadTypeService.startDate = startDate;
    uploadTypeService.endDate = endDate;

    Reference sFirebaseStorageRef = FirebaseStorage.instance.ref();

    final List<String> images = [];
    final selectedImages = uploadTypeService.selectedImages ?? [];

    for (final image in selectedImages) {
      try {
        if (image.runtimeType == XFile) {
          final uniqueId = DateTime.now().millisecondsSinceEpoch;
          Reference firebaseStorageRef = sFirebaseStorageRef.child(
              'users/${userData.email}/productImages/${uploadTypeService.propertyName}/${uploadTypeService.propertyName}-$uniqueId');
          UploadTask uploadTask = firebaseStorageRef.putFile(File(image.path));
          final TaskSnapshot taskSnapshot = await uploadTask;
          String url = await taskSnapshot.ref.getDownloadURL();
          images.add(url);
        } else {
          images.add(image);
        }
      } catch (e) {
        //
      }
    }

    try {
      await _httpService.saveProperty(
        uploadTypeService: uploadTypeService,
        images: images,
      );
      return;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  String getTitle() {
    if (selectedSubscriptions.isEmpty) {
      return 'Select Your Subcription Plan(s)';
    } else {
      return selectedSubscriptions.join(', ').toString();
    }
  }
}
