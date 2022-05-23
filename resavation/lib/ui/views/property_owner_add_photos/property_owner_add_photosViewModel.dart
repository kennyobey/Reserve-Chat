import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/services/core/image_picker_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../property_owner_add_cover_photo/property_owner_add_cover_photoViewModel.dart';
import '../property_owner_spaceType/property_owner_spacetype_viewmodel.dart';

class PropertyOwnerAddPhotosViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _imagePickerService = locator<ImagePickerService>();
  final PropertyOwnerUploadModel propertyOwnerUploadModel =
      PropertyOwnerUploadModel();

  String fileType = 'All';

  var fileTypeList = ['All', 'Image', 'Video', 'Audio', 'MultipleFile'];
  FilePickerResult? result;
  PlatformFile? file;

  void addPhoto() {
    _imagePickerService.openImages();
    notifyListeners();
  }

  void goToPropertyOwnerAddCoverPhotosView() {
    _navigationService.navigateTo(Routes.propertyOwnerAddCoverPhotosView,
        arguments: propertyOwnerUploadModel);
  }
  // void pickFiles() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //     allowMultiple: true,
  //   );
  //   if (result != null) {
  //     List<String?> data = result.paths;
  //     data.forEach((element) {
  //       PropertyOwnerAddCoverPhotosViewModel().imageContainer.add(element!);
  //     });
  //   }
  //   print(
  //       'From the image house>>>>>>>>>>>>>> ${PropertyOwnerAddCoverPhotosViewModel().imageContainer.toSet().toList()}');
  //   // PlatformFile? file = result.files.first;

  //   // print('File Name: ${file.name}');
  //   // print('File Size: ${file.size}');
  //   // print('File Extension: ${file.extension}');
  //   // print('File Path: ${file.path}');
  // }

  void viewFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
}
