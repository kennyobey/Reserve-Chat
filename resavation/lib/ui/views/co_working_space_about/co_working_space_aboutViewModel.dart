import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/amenities_model.dart';
import 'package:resavation/model/property_model.dart';
import 'package:resavation/services/core/custom_snackbar_service.dart';
import 'package:resavation/ui/views/messages/messages_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';

class CoWorkingSpaceAboutViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();
  final _snackbarService = locator<CustomSnackbarService>();
  int _pagePosition = 0;
  int get pagePosition => _pagePosition;
  Property? property;

  get numberOfBathrooms => null;

  PropertyDetailsViewModel() {
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
  List<Amenity> get amenities => ListOfAmenitiesCoworking;

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
    _navigationService.navigateTo(Routes.datePickerView, arguments: property);
  }

  void gotToChatRoomView(ChatModel? model) {
    _navigationService.navigateTo(Routes.chatRoomView, arguments: model);
  }

  void goToPropertyOwnersProfileView() {
    _navigationService.navigateTo(Routes.propertyOwnerProfileView);
  }

  // plan selection logic
  int numberOfDays = 0;
  int numberOfWeeks = 0;
  int numberOfMonths = 0;

//No of days
  void onPositiveNumberOfDaysTap() {
    numberOfDays++;
    notifyListeners();
  }

  void onNegativeNumberOfDaysTap() {
    if (numberOfDays != 0) {
      numberOfDays--;
    }
    notifyListeners();
  }

  //No of weeks
  void onPositiveNumberOfMonthsTap() {
    numberOfWeeks++;
    notifyListeners();
  }

  void onNegativeNumberOfMonthsTap() {
    if (numberOfWeeks != 0) {
      numberOfWeeks--;
    }
    notifyListeners();
  }

  //No Of Months

  void onPositiveNumberOfWeeksTap() {
    numberOfMonths++;
    notifyListeners();
  }

  void onNegativeNumberOfWeeksTap() {
    if (numberOfMonths != 0) {
      numberOfMonths--;
    }
    notifyListeners();
  }

  //Google Map
  void goToMapView() {
    _navigationService.navigateTo(Routes.mapView);
  }

  setSpaceFurnished(bool? isFurnished) {}
}
