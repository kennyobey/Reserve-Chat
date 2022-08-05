import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/services/core/image_picker_service.dart';
import 'package:resavation/services/core/user_type_service.dart';

import 'package:stacked/stacked.dart';

import '../../../model/login_model.dart';
import '../../../services/core/http_service.dart';

class PropertyOwnerEditPropertyViewModel extends BaseViewModel {
  final _httpService = locator<HttpService>();
  final userService = locator<UserTypeService>();
  LoginModel get userData => userService.userData;

  final _imagePickerService = locator<ImagePickerService>();
  DateTime startDate = DateTime.now();
  DateTime initialDate = DateTime.now();
  DateTime endDate = DateTime.now();
  final TextEditingController propertyDescriptionController =
      TextEditingController();
  final propertyDescriptionFocusNode = FocusNode();
  Property? property;
  List<dynamic> selectedImages = [];
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
    (property.propertyImages ?? []).forEach((rule) {
      final imageItem = rule.imageUrl ?? '';
      if (imageItem.isNotEmpty) {
        selectedImages.add(imageItem);
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

  Future<void> updatePropertyDescription() async {
    if (property == null) {
      return;
    }
    try {
      final newDescription = propertyDescriptionController.text.trim();

      await _httpService.updatePropertyDescription(
        property: property!,
        description: newDescription,
      );
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  Future<void> updatePropertyAmenities() async {
    if (property == null) {
      return;
    }
    try {
      final newAmmenities = [...amenities];
      await _httpService.updatePropertyAmenities(
        property: property!,
        amenities: newAmmenities,
      );
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  Future<void> updatePropertyRules() async {
    if (property == null) {
      return;
    }
    try {
      final newRules = [...rules];
      await _httpService.updatePropertyRules(
        property: property!,
        rules: newRules,
      );
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  Future<void> updatePropertyImages() async {
    if (property == null) {
      return;
    }

    Reference sFirebaseStorageRef = FirebaseStorage.instance.ref();

    final List<String> images = [];

    for (final image in selectedImages) {
      try {
        if (image.runtimeType == XFile) {
          final uniqueId = DateTime.now().millisecondsSinceEpoch;
          Reference firebaseStorageRef = sFirebaseStorageRef.child(
              'users/${userData.email}/productImages/${property!.propertyName}/${property!.propertyName}-$uniqueId');
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
      await _httpService.updatePropertyImages(
        property: property!,
        images: images,
      );
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  Future<void> updatePropertyAvailiability() async {
    if (property == null) {
      return;
    }
    try {
      await _httpService.updatePropertyAvailiability(
        property: property!,
        startDate: startDate,
        endDate: endDate,
      );
    } catch (exception) {
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

  clearImage(image) {
    selectedImages.remove(image);
    notifyListeners();
  }

  addPhoto() async {
    try {
      final imageList = await _imagePickerService.openImages();
      selectedImages.addAll(imageList);
      notifyListeners();
    } catch (exception) {
      return Future.error(exception);
    }
  }
}
