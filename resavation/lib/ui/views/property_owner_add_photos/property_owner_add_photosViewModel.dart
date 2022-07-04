import 'package:image_picker/image_picker.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/services/core/image_picker_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:resavation/services/core/upload_service.dart';

class PropertyOwnerAddPhotosViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _imagePickerService = locator<ImagePickerService>();
  final propertyOwnerUploadModel = locator<UploadService>();

  List<XFile> selectedImages = [];

  PropertyOwnerAddPhotosViewModel() {
    if (propertyOwnerUploadModel.isRestoringData) {
      setUpPreviousData();
    } else {
      propertyOwnerUploadModel.clearStage3();
    }
  }

  setUpPreviousData() {
    selectedImages.addAll(propertyOwnerUploadModel.selectedImages ?? []);

    notifyListeners();
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
