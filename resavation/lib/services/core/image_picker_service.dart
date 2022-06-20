import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

class ImagePickerService with ReactiveServiceMixin {
  /// Image picker UI logic
  final ImagePicker imgPicker = ImagePicker();
  //late RxValue<List<XFile>?>  imageFiles;

  // RxValue<bool> _isTenant = RxValue<bool>(false);

  Future<List<XFile>> openImages() async {
    try {
      var pickedFiles = await imgPicker.pickMultiImage();
      if (pickedFiles != null) {
        return pickedFiles;
      } else {
        return Future.error('Please select one or more images');
      }
    } catch (e) {
      return Future.error("An error occurred while picking images");
    }
  }
}
