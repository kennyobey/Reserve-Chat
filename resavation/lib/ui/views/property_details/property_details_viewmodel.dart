import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/amenities_model.dart';
import 'package:resavation/model/property_model.dart';
import 'package:resavation/services/core/custom_snackbar_service.dart';
import 'package:resavation/ui/views/messages/messages_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyDetailsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<CustomSnackbarService>();
  int _pagePosition = 0;
  int get pagePosition => _pagePosition;

  Property getProperty() {
    return _navigationService.currentArguments;
  }

  void onPageChanged(int index) {
    _pagePosition = index;
    notifyListeners();
  }

  List<Property> get properties => listOfProperties;
  List<Amenity> get amenities => ListOfAmenities;

  void navigateBack() {
    _navigationService.back();
  }

  void showComingSoon() {
    _snackbarService.showComingSoon();
  }

  void goToDatePickerView(Property? property) {
    _navigationService.navigateTo(Routes.datePickerView, arguments: property);
  }

  void gotToChatRoomView(ChatModel? model) {
    _navigationService.navigateTo(Routes.chatRoomView, arguments: model);
  }

  void goToPropertyOwnersProfileView() {
    _navigationService.navigateTo(Routes.propertyOwnerProfileView);
  }

  //Google Map
  void goToMapView() {
    _navigationService.navigateTo(Routes.mapView);
  }
}
