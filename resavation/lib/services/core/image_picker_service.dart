import 'package:image_picker/image_picker.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

class ImagePickerService with ReactiveServiceMixin {
  /// Image picker UI logic
  final ImagePicker imgPicker = ImagePicker();
  //late RxValue<List<XFile>?>  imageFiles;

  RxValue<bool> _isTenant = RxValue<bool>(false);

  openImages() async {
    try {
      var pickedFiles = await imgPicker.pickMultiImage();
      if (pickedFiles != null) {
        RxValue<List<XFile>?> imageFiles = RxValue<List<XFile>?>(pickedFiles);

        notifyListeners();
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
    notifyListeners();
  }
}
