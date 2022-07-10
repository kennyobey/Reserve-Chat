import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/services/core/custom_snackbar_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../model/edit_profile_model.dart';
import '../../../model/login_model.dart';
import '../../../services/core/http_service.dart';
import '../../../services/core/user_type_service.dart';
import 'package:http/http.dart' as http;

class UserProfileViewModel extends BaseViewModel {
  final _snackbarService = locator<CustomSnackbarService>();
  final _navigationService = locator<NavigationService>();

  final _httpService = locator<HttpService>();

  final userFirstNameController = TextEditingController();
  final userLastNameController = TextEditingController();
  //final userEmailController = TextEditingController();
  final _userService = locator<UserTypeService>();

  List<EditProfileModel> incomingProfile = <EditProfileModel>[];
  EditProfileModel? content;

  LoginModel get userData => _userService.userData;
  void showComingSoon() {
    _snackbarService.showComingSoon();
  }

  bool hasErrorOnData = false;
  bool isLoading = true;

  void goToMainView() {
    _navigationService.navigateTo(Routes.mainView);
  }

  String? incomingData;
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

  getProfile() async {
    print("profile is ${incomingProfile}");
    print("profile ${content?.email}");
    //print("get profile");
    isLoading = true;
    hasErrorOnData = false;
    notifyListeners();
    try {
      final incoming = await _httpService.getUserProfile();
      incomingProfile.add(incoming);
    } catch (exception) {
      hasErrorOnData = true;
    }
    isLoading = false;
    notifyListeners();
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

  void goToEditProfileView() {
    _navigationService.navigateTo(Routes.editProfileView);
  }

  getUserProfile() async {
    List incomingProfile = [''];
    print("${incomingProfile}");
    print("verify");
    try {
      var headers = {
        'Authorization':
            'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyZXNhdmF0aW9uQGdtYWlsLmNvbSIsInJvbGUiOiJST0xFX1BST1BFUlRZX09XTkVSIiwiaWQiOiI1NyIsImZpcnN0bmFtZSI6IlN0ZXBoZW4iLCJsYXN0bmFtZSI6IkFkZXllbW8iLCJlbWFpbCI6InJlc2F2YXRpb25AZ21haWwuY29tIiwiaWF0IjoxNjU2Mzk3NzYxLCJleHAiOjE2ODc5Mzc3NjF9.nNEt9F5OBGUD4Y7uvof1MHnemQRA7FOHSFtHPY1daL8FUJOHClNZe_12pHBAOyKkBKrMDLRjJv1sr9UlLp3BHw'
      };
      var request = http.Request(
          'GET',
          Uri.parse(
              'https://resavation-backend.herokuapp.com/api/v1/user/profile'));
      request.body = '''''';
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        //print(" respomse is ${await response.stream.bytesToString()}");

        incomingProfile =
            editProfileModelFromJson(await response.stream.bytesToString())
                as List<EditProfileModel>;
      } else {
        print(response.reasonPhrase);
      }
    } catch (exception) {
      return Future.error(
          "Error occurred in communicating wit the server: $exception");
    }
  }
}
