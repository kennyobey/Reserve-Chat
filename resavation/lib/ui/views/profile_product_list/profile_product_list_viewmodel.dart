import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/services/core/custom_snackbar_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../model/login_model.dart';
import '../../../services/core/user_type_service.dart';

class ProfileProductListViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final _snackbarService = locator<CustomSnackbarService>();
  // List<Property> get properties => listOfProperties;
  List<Property> get properties => [];

  final _userService = locator<UserTypeService>();

  LoginModel get userData => _userService.userData;

  // drop-down button
  String? selectedValue;
  List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

  void onSelectedValueChange(value) {
    selectedValue = value as String;

    notifyListeners();
  }

  void showComingSoon() {
    _snackbarService.showComingSoon();
  }

  void goToPropertyDetails(Property property) {
    _navigationService.navigateTo(Routes.propertyDetailsView,
        arguments: PropertyDetailsViewArguments(passedProperty: property));
  }
}
