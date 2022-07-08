import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';
import '../../../model/login_model.dart';
import '../../../services/core/http_service.dart';
import 'package:resavation/services/core/upload_service.dart';

import '../../../services/core/user_type_service.dart';

class PropertyOwnerAmenitiesViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();
  final _userService = locator<UserTypeService>();
  LoginModel get userData => _userService.userData;
  final uploadTypeService = locator<UploadService>();

  List<String> amenities = [];
  List<String> rules = [];

  PropertyOwnerAmenitiesViewModel() {
    if (uploadTypeService.isRestoringData) {
      setUpPreviousData();
    } else {
      uploadTypeService.clearStage5();
    }
  }

  setUpPreviousData() {
    amenities = uploadTypeService.amenities;
    rules = uploadTypeService.rules;
    notifyListeners();
  }

  void updateData() {
    uploadTypeService.amenities = amenities;
    uploadTypeService.rules = rules;
  }

  saveStage5Data() async {
    uploadTypeService.amenities = amenities;
    uploadTypeService.rules = rules;
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
      await httpService.saveProperty(
        uploadTypeService: uploadTypeService,
        images: images,
      );
      return;
    } catch (exception) {
      return Future.error(exception.toString());
    }
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
