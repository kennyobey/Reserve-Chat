import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/top_categories_model/content.dart';
import 'package:resavation/model/top_categories_model/top_categories_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';

class CategoriesListViewModel extends BaseViewModel {
  bool isLoading = false;
  bool hasErrorOnData = false;
  int page = 0;
  bool allLoaded = false;
  bool isLoadingOldData = false;
  int size = 8;
  final ScrollController scrollController = ScrollController();
  final _navigationService = locator<NavigationService>();
  final _httpService = locator<HttpService>();
  List<TopCategoriesModel> topCategoriesList = [];

  List<TopCategoriesContent> get topCategories {
    final List<TopCategoriesContent> allCategories = [];

    topCategoriesList.forEach((element) {
      allCategories.addAll(element.content ?? []);
    });

    return allCategories;
  }

  CategoriesListViewModel() {
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
          topCategories.isNotEmpty &&
          !isLoadingOldData) {
        getOldData();
      }
    });
  }

  getOldData() async {
    page++;
    isLoadingOldData = true;

    notifyListeners();
    try {
      final topCategory = await _httpService
          .getTopCategoriesWithHighestProperties(page: page, size: size);
      allLoaded = (topCategory.last ?? false) || (topCategory.empty ?? false);
      topCategoriesList.add(topCategory);
    } catch (exception) {
      allLoaded = true;
    }
    isLoadingOldData = false;

    notifyListeners();
  }

  void getData() async {
    isLoading = true;
    page = 0;
    topCategoriesList.clear();
    allLoaded = false;
    hasErrorOnData = false;
    notifyListeners();
    try {
      final topCategories = await _httpService
          .getTopCategoriesWithHighestProperties(page: page, size: size);
      allLoaded =
          (topCategories.last ?? false) || (topCategories.empty ?? false);
      topCategoriesList.add(topCategories);
      attachScrollListener();
      hasErrorOnData = false;
    } catch (exception) {
      hasErrorOnData = true;
    }
    isLoading = false;
    isLoadingOldData = false;
    notifyListeners();
  }

  void goToSearchView(String itemName) {
    _navigationService.navigateTo(
      Routes.topItemView,
      arguments: TopItemViewArguments(itemName: itemName, isStates: false),
    );
  }
}
