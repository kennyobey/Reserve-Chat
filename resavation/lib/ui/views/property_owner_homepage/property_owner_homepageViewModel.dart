import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/owner_booked_property/content.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/model/saved_property/saved_property.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:resavation/services/core/upload_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../model/login_model.dart';
import '../../../services/core/user_type_service.dart';

class PropertyOwnerHomePageViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserTypeService>();
  final httpService = locator<HttpService>();
  final requestSite = "resavation-backend.herokuapp.com";
  final _uploadService = locator<UploadService>();

  get getUserEmail => _userService.userData.email;
  LoginModel get userData => _userService.userData;
  final userTypeService = locator<UserTypeService>();

  void goToProfileDetails() {
    _navigationService.navigateTo(Routes.userProfileView);
  }

  void goToPropertyOwnerSpaceTypeView(SavedProperty? savedProperty) {
    _uploadService.isRestoringData = savedProperty != null;
    if (savedProperty != null) {
      _uploadService.setUpData(savedProperty);
    }
    _navigationService.navigateTo(Routes.propertyOwnerSpaceTypeView);
  }

  void goToPropertyOwnerAnalyticView() {
    _navigationService.navigateTo(Routes.propertyOwnerAnalyticView);
  }

  void goToMessage() {
    _navigationService.navigateTo(Routes.messagesView);
  }

  void goToPropertyOwnerPropertiesView() {
    _navigationService.navigateTo(Routes.propertyOwnerPropertiesView);
  }

  void PropertyOwnerMyPropertyView() {
    _navigationService.navigateTo(Routes.propertyOwnerMyPropertyView);
  }

  void PropertyOwnerTrackListView() {
    _navigationService.navigateTo(Routes.propertyOwnerTrackListView);
  }

  void CoWorkingSpaceAboutView() {
    _navigationService.navigateTo(Routes.coWorkingSpaceAboutView);
  }

  void UserProfilePageView() {
    _navigationService.navigateTo(Routes.userProfilePageView);
  }

  void goToPropertyDetails(Property property) {
    _navigationService.navigateTo(
      Routes.propertyDetailsOwnerView,
      arguments: PropertyDetailsOwnerViewArguments(
        passedProperty: property,
      ),
    );
  }

  void goToOwnerBookedPropertyDetails(
      OwnerBookedPropertyContent bookedPropertyContent) {
    _navigationService.navigateTo(
      Routes.propertyDetailsOwnerView,
      arguments: PropertyDetailsOwnerViewArguments(
        passedProperty: bookedPropertyContent.property,
        ownerPropertyContent: bookedPropertyContent,
      ),
    );
  }

  Future<SavedProperty> restoreSavedProperty() async {
    try {
      final property = await httpService.getSavedProperty();
      return property;
    } catch (exception) {
      return Future.error(
        exception.toString(),
      );
    }
  }

  void goToPropertyOwnerBookedPropertiesView() {
    _navigationService.navigateTo(Routes.propertyOwnerBookedPropertiesView);
  }

  getNewData() {
    getOwnerBookedPropertyData();
    getOwnerPropertyData();
  }

  bool ownerBookedPropertyLoading = true;
  bool ownerBookedPropertyHasError = false;
  List<OwnerBookedPropertyContent> ownerBookedPropertyModel = [];
  getOwnerBookedPropertyData() async {
    ownerBookedPropertyLoading = true;
    notifyListeners();

    try {
      final data =
          await httpService.getAllOwnerBookedProperty(page: 0, size: 5);
      ownerBookedPropertyModel = data.content ?? [];
      ownerBookedPropertyHasError = false;
    } catch (exception) {
      ownerBookedPropertyHasError = true;
    }
    ownerBookedPropertyLoading = false;
    notifyListeners();
  }

  bool ownerPropertyLoading = true;
  bool ownerPropertyHasError = false;
  List<Property> ownerPropertyModel = [];
  getOwnerPropertyData() async {
    ownerPropertyLoading = true;
    notifyListeners();

    try {
      final data = await httpService.getOwnerProperty(page: 0, size: 5);
      ownerPropertyModel = data.properties ?? [];
      ownerPropertyHasError = false;
    } catch (exception) {
      ownerPropertyHasError = true;
    }
    ownerPropertyLoading = false;
    notifyListeners();
  }
}
