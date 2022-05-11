import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/property_model.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FavoriteViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _httpService = locator<HttpService>();
  List<Property> get properties => listOfProperties;

  changeFavoriteIcon(int propertyId) async {
/*    try {
      final property =
          properties.firstWhere((property) => property.id == propertyId);
      // await _httpService.togglePropertyAsFavourite(propertyId: property.id, isFavourite: property.isFavoriteTap);
      int index = properties.indexOf(property);

      properties[index].isFavoriteTap = !property.isFavoriteTap;
    } catch (exception) {
      //todo handle error
    }
    notifyListeners();*/
  }

  void goToPropertyDetails(Property property) {
    _navigationService.navigateTo(Routes.propertyDetailsView,
        arguments: property);
  }
}
