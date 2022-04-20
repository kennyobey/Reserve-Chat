import 'package:file_picker/file_picker.dart';
import 'package:stacked/stacked.dart';

class ImagePickerService with ReactiveServiceMixin {
  void pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    PlatformFile? file = result!.files.first;
  }
}
