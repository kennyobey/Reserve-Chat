import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/tenant_booked_property/content.dart';
import 'package:resavation/model/tenant_booked_property/tenant_booked_property.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';

class BookedPropertyListViewModel extends BaseViewModel {
  bool isLoading = true;
  bool hasErrorOnData = false;
  int page = 0;
  bool allLoaded = false;
  bool isLoadingOldData = false;
  int size = 8;

  final ScrollController scrollController = ScrollController();
  final httpService = locator<HttpService>();

  final _navigationService = locator<NavigationService>();
  List<TenantBookedProperty> bookedSearches = [];

  List<TenantBookedPropertyContent> get contents {
    final List<TenantBookedPropertyContent> allContents = [];

    bookedSearches.forEach((element) {
      allContents.addAll(element.content ?? []);
    });

    return allContents;
  }

  BookedPropertyListViewModel() {
    attachScrollListener();
  }
  attachScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels <=
          scrollController.position.maxScrollExtent - 10) {
        return;
      }
      if (!isLoading &&
          !allLoaded &&
          contents.isNotEmpty &&
          !isLoadingOldData) {
        getOldData();
      }
    });
  }

  void getInitData() async {
    page = 0;
    bookedSearches.clear();
    isLoading = true;
    hasErrorOnData = false;
    allLoaded = false;
    notifyListeners();

    try {
      final bookedSearch =
          await httpService.getAllTenantsBookedProperty(page: page, size: size);
      allLoaded = (bookedSearch.last ?? false) || (bookedSearch.empty ?? false);
      bookedSearches.add(bookedSearch);

      hasErrorOnData = false;
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
      final bookedSearch =
          await httpService.getAllTenantsBookedProperty(page: page, size: size);
      bookedSearches.add(bookedSearch);

      allLoaded = (bookedSearch.last ?? false) || (bookedSearch.empty ?? false);
    } catch (exception) {
      allLoaded = true;
    }
    isLoadingOldData = false;

    notifyListeners();
  }

  void goToPropertyDetails(TenantBookedPropertyContent content) {
    _navigationService.navigateTo(
      Routes.propertyDetailsTenantView,
      arguments: PropertyDetailsTenantViewArguments(
        passedProperty: content.property,
        tenantPropertyContent: content,
      ),
    );
  }
}
