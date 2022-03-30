import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/property_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SearchViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

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

  void onFavoriteTap(Property property) {
    notifyListeners();
  }

  List<Property> get properties => ListOfProperties;

  void goToPropertyDetails() {
    _navigationService.navigateTo(Routes.propertyDetailsView);
  }

  void goToFilterView() {
    _navigationService.navigateTo(Routes.filterView);
  }
}
