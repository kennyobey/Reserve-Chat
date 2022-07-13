import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/model/search_model/search_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';

class SearchViewModel extends BaseViewModel {
  bool isLoading = false;
  bool isLoadingFromSearch = false;
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

  @override
  void dispose() {
    super.dispose();
  }

  SearchViewModel() {
    getInitData();
  }
  attachScrollListener({String query = ''}) {
    scrollController.addListener(() {
      if (scrollController.position.pixels <=
          scrollController.position.maxScrollExtent - 10) {
        return;
      }
      if (!isLoading &&
          !allLoaded &&
          properties.isNotEmpty &&
          !isLoadingOldData) {
        if (isLoadingFromSearch) {
          getOldDataFromSearch(query);
        } else {
          getOldData();
        }
      }
    });
  }

  void getInitData() async {
    page = 0;
    propertySearches.clear();
    isLoading = true;
    isLoadingFromSearch = false;
    allLoaded = false;
    hasErrorOnData = false;
    notifyListeners();

    try {
      final propertySearch =
          await httpService.getAllProperties(page: page, size: size);
      allLoaded =
          (propertySearch.last ?? false) || (propertySearch.empty ?? false);
      propertySearches.add(propertySearch);

      hasErrorOnData = false;
      attachScrollListener();
    } catch (exception) {
      hasErrorOnData = true;
    }
    isLoading = false;
    isLoadingOldData = false;
    notifyListeners();
  }

  getOldData() async {
    page++;
    isLoadingOldData = true;

    notifyListeners();
    try {
      final propertySearch =
          await httpService.getAllProperties(page: page, size: size);
      propertySearches.add(propertySearch);

      allLoaded =
          (propertySearch.last ?? false) || (propertySearch.empty ?? false);
    } catch (exception) {
      allLoaded = true;
    }
    isLoadingOldData = false;

    notifyListeners();
  }

  getOldDataFromSearch(String query) async {
    page++;
    isLoadingOldData = true;

    notifyListeners();
    try {
      final propertySearch =
          await httpService.getAllProperties(page: page, size: size);
      propertySearches.add(propertySearch);

      allLoaded =
          (propertySearch.last ?? false) || (propertySearch.empty ?? false);
    } catch (exception) {
      allLoaded = true;
    }
    isLoadingOldData = false;

    notifyListeners();
  }

  // method behind searching
  void searchProperty(String query) async {
    if (query.isEmpty) {
      getInitData();
    } else {
      page = 0;
      propertySearches.clear();
      isLoading = true;
      isLoadingFromSearch = true;
      allLoaded = false;
      hasErrorOnData = false;
      notifyListeners();

      try {
        final propertySearch = await httpService.getSearchProperty(
          text: query,
          page: page,
          size: size,
        );
        allLoaded =
            (propertySearch.last ?? false) || (propertySearch.empty ?? false);
        propertySearches.add(propertySearch);

        hasErrorOnData = false;
        attachScrollListener(
          query: query,
        );
      } catch (exception) {
        hasErrorOnData = true;
      }
      isLoading = false;
      isLoadingOldData = false;
      notifyListeners();
    }
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
      Routes.propertyDetailsView,
      arguments: PropertyDetailsViewArguments(passedProperty: property),
    );
  }

  void goToFilterView() {
    _navigationService.navigateTo(Routes.filterView);
  }
}
