import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/model/search_model/search_model.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FavoriteViewModel extends BaseViewModel {
  bool isLoading = false;
  bool isLoadingOldData = false;
  bool hasErrorOnData = false;
  bool allLoaded = false;
  int page = 0;
  int size = 8;

  final _navigationService = locator<NavigationService>();
  final ScrollController scrollController = ScrollController();
  final _httpService = locator<HttpService>();
  List<SearchModel> propertySearches = [];

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

  attachScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels <=
          scrollController.position.maxScrollExtent - 10) {
        return;
      }
      if (!isLoading &&
          !allLoaded &&
          properties.isNotEmpty &&
          !isLoadingOldData) {
        getOldData();
      }
    });
  }

  getData() async {
    page = 0;
    isLoading = true;
    allLoaded = false;
    hasErrorOnData = false;
    notifyListeners();
    try {
      final propertySearch =
          await _httpService.getAllFavouriteProperties(page: page, size: size);
      allLoaded =
          (propertySearch.last ?? false) || (propertySearch.empty ?? false);
      propertySearches.add(propertySearch);

      hasErrorOnData = false;
      attachScrollListener();
    } catch (exception) {
      hasErrorOnData = true;
    }
    isLoadingOldData = false;
    isLoading = false;
    notifyListeners();
  }

  getOldData() async {
    page++;
    isLoadingOldData = true;

    notifyListeners();
    try {
      final propertySearch =
          await _httpService.getAllFavouriteProperties(page: page, size: size);

      allLoaded =
          (propertySearch.last ?? false) || (propertySearch.empty ?? false);

      propertySearches.add(propertySearch);
    } catch (exception) {
      allLoaded = true;
    }
    isLoadingOldData = false;

    notifyListeners();
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
