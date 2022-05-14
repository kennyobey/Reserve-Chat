import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/services/core/image_picker_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';
import '../property_owner_spaceType/property_owner_spacetype_viewmodel.dart';

class PropertyOwnerAddCoverPhotosViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _imagePickerService = locator<ImagePickerService>();
  final httpService = locator<HttpService>();

  void upoloadPropertyToServer() async {
    httpService.uploadProperty(imageUrl: "");
  }

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
  }

  // RxValue<List<XFile>?> showAddedPhoto (){
  //   notifyListeners();
  //   return _imagePickerService.imageFiles;
  //
  // }

  void goToPropertyOwnerPaymentView() {
    _navigationService.navigateTo(Routes.propertyOwnerPaymentView);
  }

  void goToPropertyOwnerPaymentView(
      PropertyOwnerUploadModel propertyOwnerUploadModel) {
    propertyOwnerUploadModel.imageUrl = "";
    _navigationService.navigateTo(Routes.propertyOwnerPaymentView,
        arguments: propertyOwnerUploadModel);
  }
}
