import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/filter.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FilterViewModel extends BaseViewModel {
  final oCcy = NumberFormat("#,##0.00", "en_US");
  bool hasErrorOnData = false;
  bool isLoading = false;

  final _navigationService = locator<NavigationService>();
  final _httpService = locator<HttpService>();

  FilterViewModel() {
    getPropertyType();
  }

  getPropertyType() async {
    hasErrorOnData = false;
    isLoading = true;
    notifyListeners();
    try {
      propertyStatusList = await _httpService.getPropertyStatus();
      final types = await Future.wait([
        _httpService.getRetailPropertyTypes(),
        _httpService.getCommercialPropertyTypes(),
        _httpService.getIndustrialPropertyTypes(),
        _httpService.getResidentialPropertyTypes(),
      ]);
      propertyTypes = types.expand((x) => x).toList();

      hasErrorOnData = false;
    } catch (exception) {
      hasErrorOnData = true;
    }
    isLoading = false;
    notifyListeners();
  }

  RangeValues _rangeValues = const RangeValues(10000, 1000000);

  RangeValues get rangeValue => _rangeValues;

  RangeLabels get rangeLabels => RangeLabels(
        '${String.fromCharCode(8358)}${oCcy.format(_rangeValues.start.round())}',
        '${String.fromCharCode(8358)}${oCcy.format(_rangeValues.end.round())}',
      );
  bool rangeLabelsValid = false;

  List<String> propertyStatusList = ['---Empty---'];

  double surfaceArea = 0;
  bool surfaceAreaValid = false;

  int carCount = 0;
  bool carValid = false;
  int batTubCount = 0;
  bool batTubValid = false;
  int bedroomCount = 0;
  bool bedrooomValid = false;

  String? propertyType;
  String? propertyStatus;
  List<String> propertyTypes = ['--Empty--'];

  void onPropertyTypeChanged(value) {
    if (value is String) {
      propertyType = value;
      notifyListeners();
    }
  }

  void onIncrement(int position) {
    if (position == 0) {
      bedroomCount++;
      bedrooomValid = true;
    } else if (position == 1) {
      batTubCount++;
      batTubValid = true;
    } else {
      carCount++;
      carValid = true;
    }
    notifyListeners();
  }

  void onDecrement(int position) {
    if (position == 0 && bedroomCount != 0) {
      bedroomCount--;
      bedrooomValid = true;
    } else if (position == 1 && batTubCount != 0) {
      batTubCount--;
      batTubValid = true;
    } else if (carCount != 0) {
      carCount--;
      carValid = true;
    }
    notifyListeners();
  }

  void onRangeSliderChanged(RangeValues value) {
    _rangeValues = value;
    rangeLabelsValid = true;
    notifyListeners();
  }

  void onSliderChanged(double value) {
    surfaceArea = value;
    surfaceAreaValid = true;
    notifyListeners();
  }

  void applyFilter() {
    final filter = Filter();
    filter.bathrooms = bedrooomValid ? bedroomCount : null;
    filter.bathtubs = batTubValid ? batTubCount : null;
    filter.packingSpace = carValid ? carCount : null;
    filter.minPrice = rangeLabelsValid ? _rangeValues.start.round() : null;
    filter.maxPrice = rangeLabelsValid ? _rangeValues.end.round() : null;
    filter.surfaceArea = surfaceAreaValid ? surfaceArea : null;
    filter.propertyType = propertyType;
    filter.propertyStatus = propertyStatus;

    _navigationService.replaceWith(
      Routes.filterDisplay,
      arguments: FilterDisplayArguments(filter: filter),
    );
  }

  void goToSearchView() {
    _navigationService.navigateTo(Routes.searchView);
  }

  void onPropertyStatusValueChange(value) {
    propertyStatus = value;
    notifyListeners();
  }
}
