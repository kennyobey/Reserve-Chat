import 'package:image_picker/image_picker.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/services/core/image_picker_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/upload_type_service.dart';

class PropertyOwnerAddPhotosViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _imagePickerService = locator<ImagePickerService>();
  final propertyOwnerUploadModel = locator<UploadTypeService>();

  List<XFile> selectedImages = [];

  PropertyOwnerAddPhotosViewModel() {
    propertyOwnerUploadModel.clearStage3();
  }

  addPhoto() async {
    try {
      final imageList = await _imagePickerService.openImages();
      selectedImages.addAll(imageList);
      notifyListeners();
    } catch (exception) {
      return Future.error(exception);
    }
  }

  void goToPropertyOwnerPaymentView() {
    propertyOwnerUploadModel.selectedImages = selectedImages;
    _navigationService.navigateTo(Routes.propertyOwnerPaymentView);
  }

  clearImage(XFile image) {
    selectedImages.remove(image);
    notifyListeners();
  }
}
