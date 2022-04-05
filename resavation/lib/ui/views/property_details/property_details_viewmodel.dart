import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/amenities_model.dart';
import 'package:resavation/model/property_model.dart';
import 'package:resavation/services/core/custom_snackbar_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyDetailsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<CustomSnackbarService>();
  int _pagePosition = 0;
  int get pagePosition => _pagePosition;

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

  void goToDatePickerView() {
    _navigationService.navigateTo(Routes.datePickerView);
  }

  //Google Map
  void goToMapView() {
    _navigationService.navigateTo(Routes.mapView);
  }


}
