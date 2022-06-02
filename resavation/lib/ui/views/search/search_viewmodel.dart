import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/property_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../model/property_search/property_search.dart';
import '../../../services/core/http_service.dart';
import '../../../services/core/user_type_service.dart';

class SearchViewModel extends BaseViewModel {
  bool isLoading = false;
  bool hasError = false;
  int page = 0;
  int size = 8;
  final _navigationService = locator<NavigationService>();
  final _userTypeService = locator<UserTypeService>();
  final httpService = locator<HttpService>();
  List<PropertySearch> propertySearches = [];

  List<Property> get properties {
    final List<Property> allProperty = [];

    propertySearches.forEach((element) {
      allProperty.addAll(element.properties ?? []);
    });

    return allProperty;
  }

  TextEditingController textFieldController = TextEditingController();

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  SearchViewModel({String passedQuery = ''}) {
    textFieldController.addListener(() {
      searchProperty(textFieldController.text);
    });

    final searchQuery = _userTypeService.searchQuery;

    if (searchQuery.isNotEmpty) {
      textFieldController.text = searchQuery;
    } else if (passedQuery.isNotEmpty) {
      textFieldController.text = passedQuery;
    }

    _userTypeService.clearSearchQuery();
    getInitData();
  }

  void getInitData() async {
    isLoading = true;
    hasError = false;
    notifyListeners();

    try {
      final propertySearch =
          await httpService.getAllProperties(page: page, size: size);
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

  // method behind searching
  void searchProperty(String query) async {
/*     isLoading = true;
    hasError = false;
    propertySearches = [];
    notifyListeners();
    try {
      final propertySearch =
          await httpService.getAllProperties(page: page, size: size);
      propertySearches.add(propertySearch);
      isLoading = false;
      hasError = false;
      notifyListeners();
    } catch (exception) {
      isLoading = false;
      hasError = true;
      notifyListeners();
    } */
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
      Routes.propertyDetailsView,
      arguments: property,
    );
  }

  void goToFilterView() {
    _navigationService.navigateTo(Routes.filterView);
  }
}
