import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/utility/assets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TopCity {
  final String location;
  final int numberOfProperties;
  final String image;

  TopCity(this.location, this.numberOfProperties, this.image);
}

class Category {
  final String category;
  final String image;

  Category(this.category, this.image);
}

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  List<TopCity> topCities = [
    TopCity('Abuja', 50, Assets.abuja_location_placeholder),
    TopCity('Lagos', 20, Assets.lagos_location_placeholder),
    TopCity('Kaduna', 100, Assets.kaduna_location_placeholder),
  ];

  List<Category> categories = [
    Category('Apartment', Assets.house_placeholder),
    Category('Office Space', Assets.office_placeholder),
    Category('Kitchen', Assets.kitchen_placeholder),
  ];

  void goToFilterView() {
    _navigationService.navigateTo(Routes.propertyOwnerIdentificationView);
  }
}
