import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/owner_booked_property/content.dart';
import 'package:resavation/model/owner_booked_property/owner_booked_property.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';

class PropertyOwnerBookedPropertiesViewModel extends BaseViewModel {
  bool isLoading = true;
  bool hasErrorOnData = false;
  int page = 0;
  bool allLoaded = false;
  bool isLoadingOldData = false;
  int size = 8;

  final ScrollController scrollController = ScrollController();
  final _navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();
  List<OwnerBookedProperty> ownerProperties = [];

  List<OwnerBookedPropertyContent> get properties {
    final List<OwnerBookedPropertyContent> allProperty = [];

    ownerProperties.forEach((element) {
      allProperty.addAll(element.content ?? []);
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
          await httpService.getAllOwnerBookedProperty(page: page, size: size);

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
          await httpService.getAllOwnerBookedProperty(page: page, size: size);

      allLoaded =
          (propertySearch.last ?? false) || (propertySearch.empty ?? false);
      ownerProperties.add(propertySearch);
    } catch (exception) {
      allLoaded = true;
    }
    isLoadingOldData = false;

    notifyListeners();
  }

  void goToPropertyDetails(OwnerBookedPropertyContent bookedPropertyContent) {
    _navigationService.navigateTo(
      Routes.propertyDetailsOwnerView,
      arguments: PropertyDetailsOwnerViewArguments(
        passedProperty: bookedPropertyContent.property,
        ownerPropertyContent: bookedPropertyContent,
      ),
    );
  }
}
