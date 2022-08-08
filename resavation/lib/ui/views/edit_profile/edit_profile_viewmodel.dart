import 'dart:core';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/edit_profile_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../model/login_model.dart';
import '../../../services/core/http_service.dart';
import '../../../services/core/user_type_service.dart';

class EditProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _httpService = locator<HttpService>();
  final _userService = locator<UserTypeService>();

  String profileImage = '';
  bool isImageFile =
      false; // used to know if the current image is from the web or from the device
  DateTime dateOfBirthInitialTime = DateTime.now();
  LoginModel get userData => _userService.userData;

  bool isLoading = false;

  List<String> gender = ['Male', 'Female'];
  List<String> occupation = ['Student', 'Self Employed', 'Employed'];

  final editProfileFormKey = GlobalKey<FormState>();
  final aboutMeEmailController = TextEditingController();
  final dateOfBirthEmailController = TextEditingController();
  final phoneNumberEmailController = TextEditingController();
  String? selectedGenderValue;
  String? selectedOccupationValue;
  DateTime? dateOfBirth;
  //User Personal address
  final contryEmailController = TextEditingController();
  final stateEmailController = TextEditingController();
  final cityEmailController = TextEditingController();
  final addressEmailController = TextEditingController();
  final postalCodeEmailController = TextEditingController();

  EditProfileViewModel(EditProfileModel? profileModel) {
    profileImage = profileModel?.imageUrl ?? '';
    isImageFile = false;
    aboutMeEmailController.text = profileModel?.aboutMe ?? '';
    phoneNumberEmailController.text = profileModel?.phoneNumber ?? '';
    selectedGenderValue = profileModel?.gender;
    selectedOccupationValue = profileModel?.occupation;
    contryEmailController.text = profileModel?.country ?? '';
    stateEmailController.text = profileModel?.email ?? '';
    cityEmailController.text = profileModel?.city ?? '';
    addressEmailController.text = profileModel?.address ?? '';
    postalCodeEmailController.text = profileModel?.postalCode ?? '';
    dateOfBirth = profileModel?.dateOfBirth;
    notifyListeners();
  }

  editDetails() async {
    isLoading = true;
    notifyListeners();

    try {
      String image = profileImage;
      if (isImageFile) {
        image = await _uploadImage();
      }

      final email = userData.email;

      final lastName = userData.lastName.trim();
      final firstName = userData.firstName.trim();
      final aboutMe = aboutMeEmailController.text.trim();
      final phoneNumber = phoneNumberEmailController.text.trim();
      final gender = selectedGenderValue.toString();
      final occupation = selectedOccupationValue.toString();
      final country = contryEmailController.text.trim();
      final state = stateEmailController.text.trim();
      final city = cityEmailController.text.trim();
      final address = addressEmailController.text.trim();
      final postalCode = postalCodeEmailController.text.trim();
      await _httpService.editDetails(
        firstName: firstName,
        lastName: lastName,
        email: email,
        imageUrl: image,
        gender: gender,
        country: country,
        dateOfBirth: dateOfBirth ?? DateTime.now(),
        state: state,
        occupation: occupation,
        city: city,
        address: address,
        postalCode: postalCode,
        aboutMe: aboutMe,
        phoneNumber: phoneNumber,
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

  Future<String> _uploadImage() async {
    final file = File(profileImage);
    Reference sFirebaseStorageRef = FirebaseStorage.instance.ref();
    Reference firebaseStorageRef = sFirebaseStorageRef
        .child('users/${userData.email}/profilePictures/profilePicture');
    try {
      UploadTask uploadTask = firebaseStorageRef.putFile(file);
      final TaskSnapshot taskSnapshot = await uploadTask;
      String url = await taskSnapshot.ref.getDownloadURL();
      return url;
    } catch (e) {
      return Future.error(
          'An error occurred while updating your profile image');
    }
  }

  void goToVerificationPage() {
    _navigationService.navigateTo(Routes.verificationPage);
  }

  void goToUserProfileView() {
    _navigationService.back();
  }

  void setSelectedDOB(DateTime date) {
    dateOfBirth = date;
    notifyListeners();
  }

  void updateImageLocation(String imageLocation) {
    profileImage = imageLocation;
    isImageFile = true;
    notifyListeners();
  }
}
