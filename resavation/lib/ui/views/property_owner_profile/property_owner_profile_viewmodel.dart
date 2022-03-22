import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/property_model.dart';
import 'package:resavation/services/core/custom_snackbar_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyOwnerProfileViewModel extends BaseViewModel {
  final _snackbarService = locator<CustomSnackbarService>();
  final _navigationService = locator<NavigationService>();
  List<Property> get properties => ListOfProperties;

  void goToProfileProductListView() {
    //_navigationService.navigateTo(Routes.profileProductListView);
  }
  void showComingSoon() {
    _snackbarService.showComingSoon();
  }

  void goToAudioCallView() {
    _navigationService.navigateTo(Routes.audioCallView);
  }


  void goToPropertyDetails() {
    _navigationService.navigateTo(Routes.propertyDetailsView);
  }

  void navigateBack() {
    _navigationService.back();
  }

  void goToMessagesView() {
    _navigationService.navigateTo(Routes.messagesView);
  }
}
