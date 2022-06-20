import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/amenities_model.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/services/core/custom_snackbar_service.dart';
import 'package:resavation/ui/views/messages/messages_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';

class PropertyDetailsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();
  final _snackbarService = locator<CustomSnackbarService>();
  int _pagePosition = 0;
  int get pagePosition => _pagePosition;
  Property? property;

  PropertyDetailsViewModel(Property? property) {
    this.property = property;
    notifyListeners();
  }

  Property getProperty() {
    return _navigationService.currentArguments;
  }

  void onPageChanged(int index) {
    _pagePosition = index;
    notifyListeners();
  }

  // List<Property> get properties => listOfProperties;
  List<Property> get properties => [];
  List<Amenity> get amenities => ListOfAmenities;

  void navigateBack() {
    _navigationService.back();
  }

  onFavouriteTap() async {
    try {
      if (property == null ||
          property!.id == null ||
          property!.favourite == null) {
        return;
      }

      property = property?.copyWith(favourite: !(property!.favourite!));

      notifyListeners();

      /// toggling the property
      await httpService.togglePropertyAsFavourite(
          propertyId: property?.id ?? -1);
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  void showComingSoon() {
    _snackbarService.showComingSoon();
  }

  void goToDatePickerView() {
    if (property != null) {
      _navigationService.navigateTo(Routes.datePickerView,
          arguments: DatePickerViewArguments(property: property!));
    }
  }

  void gotToChatRoomView(ChatModel? model) {
    _navigationService.navigateTo(Routes.chatRoomView,
        arguments: ChatRoomViewArguments(chatModel: model));
  }

  void goToPropertyOwnersProfileView() {
    _navigationService.navigateTo(Routes.propertyOwnerProfileView);
  }

  //Google Map
  void goToMapView() {
    _navigationService.navigateTo(Routes.mapView);
  }
}
