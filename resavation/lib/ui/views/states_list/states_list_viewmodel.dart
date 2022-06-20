// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/top_states_model/content.dart';
import 'package:resavation/model/top_states_model/top_states_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';

class StatesListViewModel extends BaseViewModel {
  bool isLoading = false;
  bool hasErrorOnData = false;
  int page = 0;
  bool allLoaded = false;
  bool isLoadingOldData = false;
  int size = 8;
  final ScrollController scrollController = ScrollController();
  final _navigationService = locator<NavigationService>();
  final _httpService = locator<HttpService>();
  List<TopStatesModel> topCitiesList = [];

  List<TopStatesContent> get topStates {
    final List<TopStatesContent> allCities = [];

    topCitiesList.forEach((element) {
      allCities.addAll(element.content ?? []);
    });

    return allCities;
  }

  StatesListViewModel() {
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
          topStates.isNotEmpty &&
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
      final topCities = await _httpService.getTopStatesWithHighestProperties(
          page: page, size: size);
      allLoaded = (topCities.last ?? false) || (topCities.empty ?? false);
      topCitiesList.add(topCities);
    } catch (exception) {
      allLoaded = true;
    }
    isLoadingOldData = false;

    notifyListeners();
  }

  void getData() async {
    isLoading = true;
    page = 0;
    topCitiesList.clear();
    hasErrorOnData = false;
    allLoaded = false;
    notifyListeners();
    try {
      final topCities = await _httpService.getTopStatesWithHighestProperties(
          page: page, size: size);
      allLoaded = (topCities.last ?? false) || (topCities.empty ?? false);
      topCitiesList.add(topCities);
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
      arguments: TopItemViewArguments(itemName: itemName, isStates: true),
    );
  }
}
