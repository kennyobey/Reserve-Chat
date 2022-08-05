import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/owner_property/owner_property.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';

class PropertyOwnerPropertiesViewModel extends BaseViewModel {
  bool isLoading = true;
  bool hasErrorOnData = false;
  int page = 0;
  bool allLoaded = false;
  bool isLoadingOldData = false;
  int size = 8;

  final ScrollController scrollController = ScrollController();
  final _navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();
  List<OwnerPropertyModel> ownerProperties = [];

  List<Property> get properties {
    final List<Property> allProperty = [];

    ownerProperties.forEach((element) {
      allProperty.addAll(element.properties ?? []);
    });

    return allProperty;
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

  void getInitData() async {
    page = 0;
    ownerProperties.clear();
    isLoading = true;
    hasErrorOnData = false;
    allLoaded = false;
    notifyListeners();

    try {
      final propertySearch =
          await httpService.getOwnerProperty(page: page, size: size);

      allLoaded =
          (propertySearch.last ?? false) || (propertySearch.empty ?? false);
      ownerProperties.add(propertySearch);

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
          await httpService.getOwnerProperty(page: page, size: size);

      allLoaded =
          (propertySearch.last ?? false) || (propertySearch.empty ?? false);
      ownerProperties.add(propertySearch);
    } catch (exception) {
      allLoaded = true;
    }
    isLoadingOldData = false;

    notifyListeners();
  }

  void goToPropertyDetails(Property property) {
    _navigationService.navigateTo(
      Routes.propertyDetailsOwnerView,
      arguments: PropertyDetailsOwnerViewArguments(
        passedProperty: property,
      ),
    );
  }
}
