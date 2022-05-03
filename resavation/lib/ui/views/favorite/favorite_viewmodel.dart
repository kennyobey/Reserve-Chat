import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/property_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FavoriteViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  List<Property> get properties => listOfProperties;

  bool isFavorite = false;
  int _id = 0;

  void changeFavoriteIcon(int id) {
    print(id);
    if (id == 1) {
      isFavorite = !isFavorite;
      notifyListeners();
    }
  }

  void goToPropertyDetails(Property property) {
    _navigationService.navigateTo(Routes.propertyDetailsView,
        arguments: property);
  }
}
