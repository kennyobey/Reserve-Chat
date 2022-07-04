import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/booked_property/content.dart';
import 'package:resavation/model/login_model.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:resavation/services/core/user_type_service.dart';
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
  final httpService = locator<HttpService>();
  final _userService = locator<UserTypeService>();

  LoginModel get userData => _userService.userData;

  void setPositionAsSearch() {
    _userService.changePositionToSearch();
  }

  void goToFilterView() {
    _navigationService.navigateTo(Routes.filterView);
  }

  void goToPropertyDetails() {
    _navigationService.navigateTo(Routes.propertyDetailsView);
  }

  void goToTopItemsView(String itemName, bool isStates) {
    _navigationService.navigateTo(
      Routes.topItemView,
      arguments: TopItemViewArguments(itemName: itemName, isStates: isStates),
    );
  }

  void goToCategoriesView() {
    _navigationService.navigateTo(Routes.categoriesListView);
  }

  void goToStatesView() {
    _navigationService.navigateTo(Routes.statesListView);
  }

  void goToEditProfileView() {
    _navigationService.navigateTo(Routes.editProfileView);
  }

  void goToAppointmentList() {
    _navigationService.navigateTo(Routes.appointmentListView);
  }

  void goToMessage() {
    _navigationService.navigateTo(Routes.messagesView);
  }

<<<<<<< HEAD
=======
  void goToUserProfileView() {
    _navigationService.navigateTo(Routes.userProfileView);
  }

>>>>>>> test
  void goToBookedContentList() {
    _navigationService.navigateTo(Routes.bookedPropertyListView);
  }

  void goToBookedPropertyDetails(BookedPropertyContent content) {
    _navigationService.navigateTo(
      Routes.propertyDetailsView,
      arguments: PropertyDetailsViewArguments(
        passedProperty: content.property,
        propertyContent: content,
      ),
    );
  }
}
