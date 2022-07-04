import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/filter/amenity_count.dart';
import 'package:resavation/model/filter/availability.dart' as avail;
import 'package:resavation/model/filter/filter.dart';
import 'package:resavation/model/filter/price_range.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

enum Availability {
  Shortlet,
  Months,
  Year,
  More,
}

enum LetType {
  Sale,
  Rent,
}

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
    isLoading = false;
    notifyListeners();
    try {
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

  List<Availability> availablities = [];
  List<LetType> letTypes = [];

  double surfaceArea = 0;

  int carCount = 0;
  int batTubCount = 0;
  int bedroomCount = 0;

  String? propertyType;
  List<String> propertyTypes = ['--Empty--'];

  void onDurationChanged(Availability? value) {
    if (value != null) {
      if (availablities.contains(value)) {
        availablities.remove(value);
      } else {
        availablities.add(value);
      }
      notifyListeners();
    }
  }

  void onLetChanged(LetType? value) {
    if (value != null) {
      if (letTypes.contains(value)) {
        letTypes.remove(value);
      } else {
        letTypes.add(value);
      }
      notifyListeners();
    }
  }

  void onPropertyTypeChanged(value) {
    if (value is String) {
      propertyType = value;
      notifyListeners();
    }
  }

  void onIncrement(int position) {
    if (position == 0) {
      bedroomCount++;
    } else if (position == 1) {
      batTubCount++;
    } else {
      carCount++;
    }
    notifyListeners();
  }

  void onDecrement(int position) {
    if (position == 0 && bedroomCount != 0) {
      bedroomCount--;
    } else if (position == 1 && batTubCount != 0) {
      batTubCount--;
    } else if (carCount != 0) {
      carCount--;
    }
    notifyListeners();
  }

  void onRangeSliderChanged(RangeValues value) {
    _rangeValues = value;
    notifyListeners();
  }

  void onSliderChanged(double value) {
    surfaceArea = value;
    notifyListeners();
  }

  void applyFilter() {
    final availiability = avail.Availability(
      moreThanOneYear: availablities.contains(Availability.More),
      withinOneYear: availablities.contains(Availability.Year),
      withinSixMonth: availablities.contains(Availability.Months),
      shortLet: availablities.contains(Availability.Shortlet),
    );
    final amenityCount = AmenityCount(
      bathTubCount: batTubCount,
      bedRoomCount: bedroomCount,
      carSlotCount: carCount,
    );

    final priceRange = PriceRange(
      min: _rangeValues.start.round(),
      max: _rangeValues.end.round(),
    );
    final filter = Filter(
      availability: availiability,
      surfaceArea: surfaceArea == 0 ? null : surfaceArea,
      priceRange: priceRange,
      amenityCount: amenityCount,
      propertyType: propertyType,
    );

    _navigationService.replaceWith(
      Routes.filterDisplay,
      arguments: FilterDisplayArguments(filter: filter),
    );
  }

  void goToSearchView() {
    _navigationService.navigateTo(Routes.searchView);
  }
}
