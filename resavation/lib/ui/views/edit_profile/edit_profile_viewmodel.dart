import 'dart:core';
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

  // Global Keys to use with the form text fields
  final editProfileFormKey = GlobalKey<FormState>();

  String? selectedGenderValue = 'Male';
  String? selectedOccupationValue = 'Student';
  bool isLoading = false;

  DateTime dob = DateTime.now();
  late final date = dob.toIso8601String();
  String? url;

  //user personal details
  final userFirstNameController = TextEditingController();
  final userLastNameController = TextEditingController();
  final aboutMeEmailController = TextEditingController();
  final dateOfBirthEmailController = TextEditingController();
  final phoneNumberEmailController = TextEditingController();
  final genderEmailController = TextEditingController();
  final occupatuionEmailController = TextEditingController();

  //User Personal address
  final contryEmailController = TextEditingController();
  final stateEmailController = TextEditingController();
  final cityEmailController = TextEditingController();
  final addressEmailController = TextEditingController();
  final postalCodeEmailController = TextEditingController();

  final _userService = locator<UserTypeService>();
  LoginModel get userData => _userService.userData;
  void showComingSoon() {
    _snackbarService.showComingSoon();
  }

  editDetails() async {
    isLoading = true;
    notifyListeners();
    final firstName = userFirstNameController.text.trim();
    final lastName = userLastNameController.text.trim();
    final email = aboutMeEmailController.text.trim();
    final imageUrl = url;
    final gender = selectedGenderValue.toString();
    final dateOfBirth = '';
    final country = contryEmailController.text.trim();
    final state = stateEmailController.text.trim();
    final city = cityEmailController.text.trim();
    final address = addressEmailController.text.trim();
    final postalCode = postalCodeEmailController.text.trim();
    final aboutMe = aboutMeEmailController.text.trim();
    final occupation = selectedOccupationValue.toString();
    final phoneNumber = phoneNumberEmailController.text.trim();

    try {
      await _httpService.editDetails(
        firstName,
        lastName,
        email,
        url ?? "",
        gender,
        country,
        dob,
        state,
        occupation,
        city,
        address,
        postalCode,
        aboutMe,
        phoneNumber,
      );
      isLoading = false;
      notifyListeners();
    } catch (exception) {
      isLoading = false;
      notifyListeners();
      return Future.error(exception.toString());
    }
  }

  void onSelectedGender(value) {
    selectedGenderValue = value;
    notifyListeners();
  }

  void onSelectedOccupation(value) {
    selectedOccupationValue = value;
    notifyListeners();
  }

  void goToMainView() {
    _navigationService.navigateTo(Routes.mainView);
  }

  List<String> gender = ['Male', 'Female'];
  List<String> occupation = ['Student', 'Self Employed', 'Employed'];

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
