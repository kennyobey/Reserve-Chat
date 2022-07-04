import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:resavation/services/core/upload_service.dart';

class PropertyOwnerPaymentViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final propertyOwnerUploadModel = locator<UploadService>();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

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
    if (propertyOwnerUploadModel.isRestoringData) {
      setUpPreviousData();
    } else {
      propertyOwnerUploadModel.clearStage4();
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
    if (propertyOwnerUploadModel.spacePrice != null) {
      if (propertyOwnerUploadModel.spacePrice ==
          propertyOwnerUploadModel.annualPrice) {
        displayPrice = 'Annually';
      } else if (propertyOwnerUploadModel.spacePrice ==
          propertyOwnerUploadModel.biannualPrice) {
        displayPrice = 'Biannually';
      } else if (propertyOwnerUploadModel.spacePrice ==
          propertyOwnerUploadModel.quarterlyPrice) {
        displayPrice = 'Quarterly';
      } else if (propertyOwnerUploadModel.spacePrice ==
          propertyOwnerUploadModel.monthlyPrice) {
        displayPrice = 'Monthly';
      }
    }

    if (propertyOwnerUploadModel.annualPrice != null) {
      propertyannualPriceController.text =
          (propertyOwnerUploadModel.annualPrice ?? 0).toString();
      selectedSubscriptions.add('Annually');
    }
    if (propertyOwnerUploadModel.biannualPrice != null) {
      propertybiannualPriceController.text =
          (propertyOwnerUploadModel.biannualPrice ?? 0).toString();
      selectedSubscriptions.add('Biannually');
    }
    if (propertyOwnerUploadModel.quarterlyPrice != null) {
      propertyquaterlylPriceController.text =
          (propertyOwnerUploadModel.quarterlyPrice ?? 0).toString();
      selectedSubscriptions.add('Quarterly');
    }
    if (propertyOwnerUploadModel.monthlyPrice != null) {
      propertymonthlyPriceController.text =
          (propertyOwnerUploadModel.monthlyPrice ?? 0).toString();
      selectedSubscriptions.add('Monthly');
    }

    if (propertyOwnerUploadModel.startDate != null) {
      startDate = propertyOwnerUploadModel.startDate!;
    }
    if (propertyOwnerUploadModel.endDate != null) {
      endDate = propertyOwnerUploadModel.endDate!;
    }
    notifyListeners();
  }

  void goToPropertyOwnerAmenitiesView() {
    if (displayPrice == 'Annually') {
      propertyOwnerUploadModel.spacePrice =
          int.tryParse(propertyannualPriceController.text);
    } else if (displayPrice == 'Biannually') {
      propertyOwnerUploadModel.spacePrice =
          int.tryParse(propertybiannualPriceController.text);
    } else if (displayPrice == 'Quarterly') {
      propertyOwnerUploadModel.spacePrice =
          int.tryParse(propertyquaterlylPriceController.text);
    } else if (displayPrice == 'Monthly') {
      propertyOwnerUploadModel.spacePrice =
          int.tryParse(propertymonthlyPriceController.text);
    }

    if (selectedSubscriptions.contains('Annually')) {
      propertyOwnerUploadModel.annualPrice =
          int.tryParse(propertyannualPriceController.text);
    }
    if (selectedSubscriptions.contains('Biannually')) {
      propertyOwnerUploadModel.biannualPrice =
          int.tryParse(propertybiannualPriceController.text);
    }
    if (selectedSubscriptions.contains('Quarterly')) {
      propertyOwnerUploadModel.quarterlyPrice =
          int.tryParse(propertyquaterlylPriceController.text);
    }
    if (selectedSubscriptions.contains('Monthly')) {
      propertyOwnerUploadModel.monthlyPrice =
          int.tryParse(propertymonthlyPriceController.text);
    }

    propertyOwnerUploadModel.startDate = startDate;
    propertyOwnerUploadModel.endDate = endDate;

    _navigationService.navigateTo(Routes.propertyOwnerAmenitiesView);
  }

  String getTitle() {
    if (selectedSubscriptions.isEmpty) {
      return 'Select Your Subcription Plan(s)';
    } else {
      return selectedSubscriptions.join(', ').toString();
    }
  }
}
