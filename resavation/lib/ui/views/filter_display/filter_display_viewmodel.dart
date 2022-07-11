import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/filter/filter.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/model/search_model/search_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';

class FilterDisplayViewModel extends BaseViewModel {
  bool isLoading = false;
  bool hasErrorOnData = false;
  bool allLoaded = false;
  bool isLoadingOldData = false;
  int page = 0;
  int size = 8;
  final _navigationService = locator<NavigationService>();
  final ScrollController scrollController = ScrollController();
  final httpService = locator<HttpService>();
  List<SearchModel> propertySearches = [];

  List<Property> get properties {
    final List<Property> allProperty = [];

    propertySearches.forEach((element) {
      allProperty.addAll(element.properties ?? []);
    });

    return allProperty;
  }

  FilterDisplayViewModel(Filter filter) {
    getInitData(filter);
  }
  attachScrollListener(Filter filter) {
    scrollController.addListener(() {
      if (scrollController.position.pixels <=
          scrollController.position.maxScrollExtent - 10) {
        return;
      }
      if (!isLoading &&
          !allLoaded &&
          properties.isNotEmpty &&
          !isLoadingOldData) {
        getOldData(filter);
      }
    });
  }

  void getInitData(Filter filter) async {
    page = 0;
    isLoading = true;
    hasErrorOnData = false;
    notifyListeners();

    try {
      final propertySearch = await httpService.getFilteredProperty(
          filter: filter, page: page, size: size);
      propertySearches.add(propertySearch);
      hasErrorOnData = false;
      attachScrollListener(filter);
    } catch (exception) {
      hasErrorOnData = true;
    }
    isLoading = false;
    isLoadingOldData = false;
    notifyListeners();
  }

  getOldData(Filter filter) async {
    page++;
    isLoadingOldData = true;

    notifyListeners();
    try {
      final propertySearch = await httpService.getFilteredProperty(
          filter: filter, page: page, size: size);

      allLoaded =
          (propertySearch.last ?? false) || (propertySearch.empty ?? false);

      propertySearches.add(propertySearch);
    } catch (exception) {
      allLoaded = true;
    }
    isLoadingOldData = false;

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
