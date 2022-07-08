import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/login_model.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:resavation/services/core/image_picker_service.dart';
import 'package:resavation/services/core/user_type_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:resavation/services/core/upload_service.dart';

class PropertyOwnerAddPhotosViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final uploadTypeService = locator<UploadService>();
  final _imagePickerService = locator<ImagePickerService>();
  final propertyOwnerUploadModel = locator<UploadService>();
  final _httpService = locator<HttpService>();
  List<dynamic> selectedImages = [];
  final _userService = locator<UserTypeService>();
  LoginModel get userData => _userService.userData;

  PropertyOwnerAddPhotosViewModel() {
    if (propertyOwnerUploadModel.isRestoringData) {
      setUpPreviousData();
    } else {
      propertyOwnerUploadModel.clearStage3();
    }
  }

  setUpPreviousData() {
    selectedImages.addAll(propertyOwnerUploadModel.selectedImages ?? []);

    notifyListeners();
  }

  saveStage3Data() async {
    Reference sFirebaseStorageRef = FirebaseStorage.instance.ref();

    final List<String> images = [];
    propertyOwnerUploadModel.selectedImages = selectedImages;

    for (final image in selectedImages) {
      try {
        if (image.runtimeType == XFile) {
          final uniqueId = DateTime.now().millisecondsSinceEpoch;
          Reference firebaseStorageRef = sFirebaseStorageRef.child(
              'users/${userData.email}/productImages/${propertyOwnerUploadModel.propertyName}/${propertyOwnerUploadModel.propertyName}-$uniqueId');
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

  addPhoto() async {
    try {
      final imageList = await _imagePickerService.openImages();
      selectedImages.addAll(imageList);
      notifyListeners();
    } catch (exception) {
      return Future.error(exception);
    }
  }

  void goToPropertyOwnerPaymentView() {
    propertyOwnerUploadModel.selectedImages = selectedImages;

    navigationService.navigateTo(Routes.propertyOwnerPaymentView);
  }

  clearImage(XFile image) {
    selectedImages.remove(image);
    notifyListeners();
  }
}
