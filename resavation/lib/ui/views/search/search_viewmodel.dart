import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/property_model.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_searchbar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';

class SearchViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();
  bool isLoadingData = false;

  String query = '';
  List<Property> properties = listOfProperties;

  TextEditingController textFieldController = TextEditingController();

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  SearchViewModel() {
    textFieldController.addListener(() {
      searchProperty(textFieldController.text);
    });
  }

  Widget buildSearch() => ResavationSearchBar(
        text: query,
        hintText: 'Product Name',
        onChanged: searchProperty,
      );

  // method behind searching
  void searchProperty(String query) {
    final property = listOfProperties.where((property) {
      final propertyLocation = property.location.toLowerCase();
      final propertyAddress = property.address.toLowerCase();
      final propertyCategory = property.category!.toLowerCase();

      final searchLower = query.toLowerCase();

      return propertyLocation.contains(searchLower) ||
          propertyAddress.contains(searchLower) ||
          propertyCategory.contains(searchLower);
    }).toList();

    this.query = query;
    this.properties = property;
    notifyListeners();
  }

  // drop-down button logic
  String? selectedValue;
  List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

  void onSelectedValueChange(value) {
    selectedValue = value as String;

    notifyListeners();
  }

  void onFavoriteTap(Property property) {
    try {
      // await _httpService.togglePropertyAsFavourite(propertyId: property.id, isFavourite: property.isFavoriteTap);
      int index = properties.indexOf(property);

      properties[index].isFavoriteTap = !property.isFavoriteTap;
    } catch (exception) {
      //todo handle error
    }
    notifyListeners();
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

  @override
  void initState() {
    //  property = listOfProperties;
    getData();
  }

  getData() async {
    isLoadingData = true;
    notifyListeners();

    try {
      properties = await httpService.getAllProperties(page: 0, size: 10);
      notifyListeners();
    } catch (exception) {
      //
      properties = [];
    }
    isLoadingData = false;
    notifyListeners();
  }
}
