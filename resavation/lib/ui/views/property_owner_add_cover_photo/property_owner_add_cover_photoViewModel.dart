import 'package:image_picker/image_picker.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/services/core/image_picker_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyOwnerAddCoverPhotosViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _imagePickerService = locator<ImagePickerService>();


  RxValue<List<XFile>?> showAddedPhoto (){
    return _imagePickerService.imageFiles;

  }

  void goToPropertyOwnerPaymentView() {
    _navigationService.navigateTo(Routes.propertyOwnerPaymentView);
  }
}
