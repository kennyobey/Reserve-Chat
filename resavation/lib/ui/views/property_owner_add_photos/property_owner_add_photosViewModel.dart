import 'package:image_picker/image_picker.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/services/core/image_picker_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyOwnerAddPhotosViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _imagePickerService = locator<ImagePickerService>();

  void addPhoto() {
    _imagePickerService.openImages();
    notifyListeners();
  }


  void goToPropertyOwnerAddCoverPhotosView() {
    _navigationService.navigateTo(Routes.propertyOwnerAddCoverPhotosView);
  }
}
