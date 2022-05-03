import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/login_model.dart';
import 'package:resavation/services/core/custom_snackbar_service.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:resavation/services/core/user_type_service.dart';
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
  final bool featureReady;

  Category(this.category, this.image, this.featureReady);
}

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<CustomSnackbarService>();
  final httpService = locator<HttpService>();
  final _userService = locator<UserTypeService>();

  LoginModel get userData => _userService.userData;

  void showComingSoon() {
    _snackbarService.showComingSoon();
  }

  List<TopCity> topCities = [
    TopCity('Abuja', 50, Assets.abuja_location_placeholder),
    TopCity('Lagos', 20, Assets.lagos_location_placeholder),
  ];

  List<Category> categories = [
    Category('Apartment', Assets.house_placeholder, true),
    Category('Office Space', Assets.office_placeholder, false),
  ];

  void goToFilterView() {
    _navigationService.navigateTo(Routes.filterView);
  }

  void goToPropertyDetails() {
    _navigationService.navigateTo(Routes.propertyDetailsView);
  }

  void goToPropertySearch() {
    _navigationService.navigateTo(Routes.searchView);
  }

  void goToProfileProductListView() {
    _navigationService.navigateTo(Routes.profileProductListView);
  }

  void goToEditProfileView() {
    _navigationService.navigateTo(Routes.editProfileView);
  }

  void goToMessage() {
    _navigationService.navigateTo(Routes.messagesView);
  }
}
