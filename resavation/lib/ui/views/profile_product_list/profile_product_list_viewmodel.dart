import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/property_model.dart';
import 'package:resavation/services/core/custom_snackbar_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileProductListViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<CustomSnackbarService>();
  List<Property> get properties => listOfProperties;

  // drop-down button
  String? selectedValue;
  List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

  void onSelectedValueChange(value){
    selectedValue = value as String;

    notifyListeners();
  }

  void showComingSoon() {
    _snackbarService.showComingSoon();
  }

  void goToPropertyDetails() {
    _navigationService.navigateTo(Routes.propertyDetailsView);
  }
}
