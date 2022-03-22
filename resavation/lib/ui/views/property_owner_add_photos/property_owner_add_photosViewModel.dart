import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyOwnerAddPhotosViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void goToPropertyOwnerAddCoverPhotosView() {
    _navigationService.navigateTo(Routes.propertyOwnerAddCoverPhotosView);
  }
}
