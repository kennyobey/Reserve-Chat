import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/services/core/user_type_service.dart';

import 'package:stacked/stacked.dart';

import '../../../services/core/http_service.dart';

class PropertyOwnerEditPropertyViewModel extends BaseViewModel {
  final _httpService = locator<HttpService>();
  final userService = locator<UserTypeService>();
  final uploadFormKey = GlobalKey<FormState>();
  DateTime startDate = DateTime.now();
  DateTime initialDate = DateTime.now();
  DateTime endDate = DateTime.now();
  final TextEditingController propertyDescriptionController =
      TextEditingController();
  Property? property;
  List<String> amenities = [];
  List<String> rules = [];
  PropertyOwnerEditPropertyViewModel(Property property) {
    this.property = property;

    propertyDescriptionController.text = property.description ?? '';

    (property.amenities ?? []).forEach((amenity) {
      final amenityItem = amenity.amenity ?? '';
      if (amenityItem.isNotEmpty) {
        amenities.add(amenityItem);
      }
    });
    (property.propertyRule ?? []).forEach((rule) {
      final ruleItem = rule.rule ?? '';
      if (ruleItem.isNotEmpty) {
        rules.add(ruleItem);
      }
    });
    if (property.availabilityPeriods?.startDate != null) {
      startDate = property.availabilityPeriods!.startDate!;
      if (initialDate.microsecondsSinceEpoch >
          startDate.microsecondsSinceEpoch) {
        initialDate = property.availabilityPeriods!.startDate!;
      }
    }
    if (property.availabilityPeriods?.endDate != null) {
      endDate = property.availabilityPeriods!.endDate!;
    }
    notifyListeners();
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

  Future<void> updateProperty() async {
    if (property == null) {
      return;
    }
    try {
      final newDescription = propertyDescriptionController.text.trim();
      final newAmmenities = [...amenities];
      final newRules = [...rules];
      await _httpService.updateProperty(
        property: property!,
        description: newDescription,
        amenities: newAmmenities,
        rules: newRules,
        startDate: startDate,
        endDate: endDate,
      );
    } catch (exception) {
      debugPrint(exception.toString());
      return Future.error(exception.toString());
    }
  }

  @override
  void dispose() {
    propertyDescriptionController.dispose();
    super.dispose();
  }

  deleteAmenity(String ameniti) {
    amenities.remove(ameniti);
    notifyListeners();
  }

  addAmenity(String amenity) {
    amenities.add(amenity);

    notifyListeners();
  }

  deleteRule(String rule) {
    rules.remove(rule);
    notifyListeners();
  }

  addRules(String rule) {
    rules.add(rule);
    notifyListeners();
  }
}
