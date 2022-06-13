import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/property_model.dart';
import 'package:resavation/model/top_categories_model/content.dart';
import 'package:resavation/model/top_categories_model/top_categories_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';

class CategoriesListViewModel extends BaseViewModel {
  bool isLoading = false;
  bool hasError = false;
  int page = 0;
  int size = 8;
  final _navigationService = locator<NavigationService>();
  final _httpService = locator<HttpService>();
  List<TopCategoriesModel> topCategoriesList = [];

  final items = [
    'Location',
    'Count',
  ];

  String? selectedValue;

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

  void getData() async {
    isLoading = true;
    hasError = false;
    notifyListeners();
    try {
      final topCities = await _httpService
          .getTopCategoriesWithHighestProperties(page: page, size: size);

      topCategoriesList.add(topCities);
      isLoading = false;
      hasError = false;
      notifyListeners();
    } catch (exception) {
      isLoading = false;
      hasError = true;
      notifyListeners();
    }
  }


  void goToSearchView(String search) {
    _navigationService.navigateTo(Routes.searchView, arguments: SearchViewArguments(passedQuery: search),);
  }

  void onSelectedValueChange(String? value) {
    selectedValue = value;
    notifyListeners();
  }
}
