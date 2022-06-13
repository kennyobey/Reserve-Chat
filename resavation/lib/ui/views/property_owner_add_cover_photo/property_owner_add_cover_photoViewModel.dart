import 'package:file_picker/file_picker.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';

class PropertyOwnerAddCoverPhotosViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();

  // void upoloadPropertyToServer() async {
  //   httpService.uploadProperty();
  // }

  final List<String> imageContainer = <String>[];

  void pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (result != null) {
      List<String?> data = result.paths;
      data.forEach((element) {
        imageContainer.add(element!);
      });
    }
    print(
        'From the image house>>>>>>>>>>>>>> ${imageContainer.toSet().toList()}');
    // PlatformFile? file = result.files.first;

    // print('File Name: ${file.name}');
    // print('File Size: ${file.size}');
    // print('File Extension: ${file.extension}');
    // print('File Path: ${file.path}');
    notifyListeners();
  }

  // RxValue<List<XFile>?> showAddedPhoto (){
  //   notifyListeners();
  //   return _imagePickerService.imageFiles;
  //
  // }

  // void goToPropertyOwnerPaymentView() {

  //   _navigationService.navigateTo(Routes.propertyOwnerPaymentView);
  // }

  // uploadDocument(File file) async {
  //   Reference sFirebaseStorageRef = FirebaseStorage.instance.ref();
  //   Reference firebaseStorageRef = sFirebaseStorageRef
  //       .child('users/${userData.email}/profilePictures/profilePicture');
  //   try {
  //     UploadTask uploadTask = firebaseStorageRef.putFile(file);
  //     final TaskSnapshot taskSnapshot = await uploadTask;
  //     String url = await taskSnapshot.ref.getDownloadURL();

  //     final body = {
  //       "imageUrl": url,
  //     };
  //     await _httpService.updateProfile(body: body);
  //   } catch (e) {
  //     return Future.error(e.toString());
  //   }
  // }

  void goToPropertyOwnerPaymentView() {
    _navigationService.navigateTo(
      Routes.propertyOwnerPaymentView,
    );
  }
}


//image_picker: ^0.6.7+14
//firebase_storage: ^5.0.1

// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// void demo() async {
//   var pickedImage = await ImagePicker().getImage(
//       source: ImageSource.gallery, //pick from device gallery
//       maxWidth: 1920,
//       maxHeight: 1200,   //specify size and quality
//       imageQuality: 80); //so image_picker will resize for you

//   var anotherPickedImage = await ImagePicker().getImage(
//       source: ImageSource.camera, //pick from camera
//       maxWidth: 1920,
//       maxHeight: 1200,
//       imageQuality: 80);

//   //upload and get download url
//   Reference ref = FirebaseStorage.instance.ref().child("unique_name.jpg");//generate a unique name
//   await ref.putFile(File(pickedImage.path));//you need to add path here
//   String imageUrl = await ref.getDownloadURL();

//   // To use the image within your widgets:
//   // Image.network(imageUrl);
// }