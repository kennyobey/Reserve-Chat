import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/property_model.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:resavation/model/property_search/property_search.dart';

class FavoriteViewModel extends BaseViewModel {
  bool isLoading = false;
  bool hasError = false;
  int page = 0;
  int size = 8;
  final _navigationService = locator<NavigationService>();
  final _httpService = locator<HttpService>();
  List<PropertySearch> propertySearches = [];

  List<Property> get properties {
    final List<Property> allProperty = [];

    propertySearches.forEach((element) {
      allProperty.addAll(element.properties ?? []);
    });

    return allProperty;
  }

  FavoriteViewModel() {
    getData();
  }

  void getData() async {
    isLoading = true;
    hasError = false;
    notifyListeners();
    try {
      final propertySearch =
          await _httpService.getAllFavouriteProperties(page: page, size: size);
      propertySearches.add(propertySearch);
      isLoading = false;
      hasError = false;
      notifyListeners();
    } catch (exception) {
      isLoading = false;
      hasError = true;
      notifyListeners();
    }
  }

  changeFavoriteIcon(int propertyId) async {
    try {
      propertySearches.forEach((propertySearch) {
        propertySearch.properties
            ?.removeWhere((property) => property.id == propertyId);
      });
      notifyListeners();
      await _httpService.togglePropertyAsFavourite(propertyId: propertyId);
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  void goToPropertyDetails(Property property) {
    _navigationService.navigateTo(Routes.propertyDetailsView,
        arguments: PropertyDetailsViewArguments(passedProperty: property));
  }
}
