import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/model/search_model/search_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';

class TopItemViewModel extends BaseViewModel {
  bool isLoading = false;
  bool hasErrorOnData = false;
  int page = 0;
  bool allLoaded = false;
  bool isLoadingOldData = false;
  int size = 8;

  final ScrollController scrollController = ScrollController();
  final _navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();
  List<SearchModel> propertySearches = [];

  List<Property> get properties {
    final List<Property> allProperty = [];

    propertySearches.forEach((element) {
      allProperty.addAll(element.properties ?? []);
    });

    return allProperty;
  }

  TopItemViewModel({
    required String itemName,
    required bool isStates,
  }) {
    getInitData(itemName, isStates);
  }

  attachScrollListener(String itemName, bool isStates) {
    scrollController.addListener(() {
      if (scrollController.position.pixels <=
          scrollController.position.maxScrollExtent - 10) {
        return;
      }
      if (!isLoading &&
          !allLoaded &&
          properties.isNotEmpty &&
          !isLoadingOldData) {
        getOldData(itemName, isStates);
      }
    });
  }

  void getInitData(String itemName, bool isStates) async {
    page = 0;
    propertySearches.clear();
    isLoading = true;
    hasErrorOnData = false;
    allLoaded = false;
    notifyListeners();

    try {
      final categoryFuture = httpService.getPropertiesByCategories(
          category: itemName, page: page, size: size);

      final stateFuture = httpService.getPropertiesByStates(
          state: itemName, page: page, size: size);

      final propertySearch = await (isStates ? stateFuture : categoryFuture);

      allLoaded =
          (propertySearch.last ?? false) || (propertySearch.empty ?? false);
      propertySearches.add(propertySearch);

      hasErrorOnData = false;
      attachScrollListener(itemName, isStates);
    } catch (exception) {
      hasErrorOnData = true;
    }
    isLoading = false;
    isLoadingOldData = false;
    notifyListeners();
  }

  getOldData(String itemName, bool isStates) async {
    page++;
    isLoadingOldData = true;

    notifyListeners();
    try {
      final categoryFuture = httpService.getPropertiesByCategories(
          category: itemName, page: page, size: size);

      final stateFuture = httpService.getPropertiesByStates(
          state: itemName, page: page, size: size);

      final propertySearch = await (isStates ? stateFuture : categoryFuture);
      allLoaded =
          (propertySearch.last ?? false) || (propertySearch.empty ?? false);
      propertySearches.add(propertySearch);
    } catch (exception) {
      allLoaded = true;
    }
    isLoadingOldData = false;

    notifyListeners();
  }

  // drop-down button logic
  String? sortByType;
  List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

  void onSortByChanged(value) {
    sortByType = value as String;
    notifyListeners();
  }

  onFavoriteTap(Property selectedProperty) async {
    try {
      if (selectedProperty.id == null || selectedProperty.favourite == null) {
        return;
      }
      int propertySearchIndex = -1;
      int propertyIndex = -1;

      propertySearches.forEach((propertySearch) {
        propertySearch.properties?.forEach((property) {
          if (property.id == selectedProperty.id) {
            propertySearchIndex = propertySearches.indexOf(propertySearch);
            propertyIndex = propertySearch.properties!.indexOf(property);
          }
        });
      });

      if (propertySearchIndex != -1 && propertyIndex != -1) {
        propertySearches[propertySearchIndex]
            .properties?[propertyIndex]
            .favourite = !(selectedProperty.favourite!);
      }
      notifyListeners();

      /// toggling the property
      await httpService.togglePropertyAsFavourite(
          propertyId: selectedProperty.id ?? -1);
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  void goToPropertyDetails(Property property) {
    _navigationService.navigateTo(
      Routes.propertyDetailsTenantView,
      arguments: PropertyDetailsTenantViewArguments(passedProperty: property),
    );
  }
}
