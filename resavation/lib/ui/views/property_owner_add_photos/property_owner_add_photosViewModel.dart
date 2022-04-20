import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/services/core/image_picker_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyOwnerAddPhotosViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _imagePickerService = locator<ImagePickerService>();

  String fileType = 'All';
  var fileTypeList = ['All', 'Image', 'Video', 'Audio', 'MultipleFile'];
  FilePickerResult? result;
  PlatformFile? file;

  void addPhoto() {
    _imagePickerService.openImages();
    notifyListeners();
  }

  void goToPropertyOwnerAddCoverPhotosView() {
    _navigationService.navigateTo(Routes.propertyOwnerAddCoverPhotosView);
  }

  void pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (result == null) return;

    PlatformFile? file = result.files.first;

    print('File Name: ${file.name}');
    print('File Size: ${file.size}');
    print('File Extension: ${file.extension}');
    print('File Path: ${file.path}');
  }

  void viewFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
}
