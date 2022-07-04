import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/services/core/custom_snackbar_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../model/login_model.dart';
import '../../../services/core/http_service.dart';
import '../../../services/core/user_type_service.dart';

class EditProfileViewModel extends BaseViewModel {
  final _snackbarService = locator<CustomSnackbarService>();
  final _navigationService = locator<NavigationService>();

  final _httpService = locator<HttpService>();

  final userFirstNameController = TextEditingController();
  final userLastNameController = TextEditingController();
  //final userEmailController = TextEditingController();
  final _userService = locator<UserTypeService>();
  LoginModel get userData => _userService.userData;
  void showComingSoon() {
    _snackbarService.showComingSoon();
  }

  void goToMainView() {
    _navigationService.navigateTo(Routes.mainView);
  }

  List gender = ['Male', 'Female'];

  Future<String> showFilePicker() async {
    try {
      final ImagePicker _picker = ImagePicker();
      // Pick an image
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      // Capture a photo

      if (image != null) {
        String filePath = image.path;
        if (filePath.isNotEmpty) {
          return filePath;
        } else {
          return Future.error('File Selection Failed');
        }
      } else {
        return Future.error('File Selection Canceled');
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  uploadDocument(File file) async {
    Reference sFirebaseStorageRef = FirebaseStorage.instance.ref();
    Reference firebaseStorageRef = sFirebaseStorageRef
        .child('users/${userData.email}/profilePictures/profilePicture');
    try {
      UploadTask uploadTask = firebaseStorageRef.putFile(file);
      final TaskSnapshot taskSnapshot = await uploadTask;
      String url = await taskSnapshot.ref.getDownloadURL();

      final body = {
        "imageUrl": url,
      };
      await _httpService.updateProfile(body: body);
      goToMainView();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  updateProfile() async {
    final firstName = userFirstNameController.text.trim();
    final lastName = userLastNameController.text.trim();
    try {
      final body = {
        "firstName": firstName.isNotEmpty ? firstName : userData.firstName,
        "lastName": lastName.isNotEmpty ? lastName : userData.lastName,
      };
      await _httpService.updateProfile(body: body);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  void goToVerificationPage() {
    _navigationService.navigateTo(Routes.verificationPage);
  }

  void goToUserProfileView() {
    _navigationService.navigateTo(Routes.userProfileView);
  }
}
