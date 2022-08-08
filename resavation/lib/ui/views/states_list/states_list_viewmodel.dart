// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/top_states_model/content.dart';
import 'package:resavation/model/top_states_model/top_states_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/http_service.dart';

final propertyImages = [
  'https://drive.google.com/uc?export=view&id=1CjO_Wr0NGVCm3_41Dke_VfePIRX3Vx6U',
  'https://drive.google.com/uc?export=view&id=1AlSGC3Aw0S4rs52KehJYRNhKh_u9EHST',
  'https://drive.google.com/uc?export=view&id=1AWqzOnYLCm_ZrE_kl6H8yFMDWWYRyoog',
  'https://drive.google.com/uc?export=view&id=1Av-r3D-XqdMr1GCd8TDEZeEkuoIn9PVw',
  'https://drive.google.com/uc?export=view&id=1Av8LH2w1ykQRjEq399O4syw1Ya_v0aAi',
  'https://drive.google.com/uc?export=view&id=1AFa-K_wprjJ9_9YqvznH5wOe4xRlpcuB',
  'https://drive.google.com/uc?export=view&id=1A_2lclgR2WF_BnqB8XKZHWy4gqPI_DWX',
  'https://drive.google.com/uc?export=view&id=1BNrCZ5BvYVvp2KoKUa2j1hN68Acpuw9q',
  'https://drive.google.com/uc?export=view&id=19xl2MzN5mlle9l1Krbl4a_GCnuHMYE8G',
  'https://drive.google.com/uc?export=view&id=1Akqr1uUz7EhFWZr7PzDKIt35tnNqZwSc',
  'https://drive.google.com/uc?export=view&id=1C5HClg9BQyJyBMrfJ9xvC_LzcIinOe91',
  'https://drive.google.com/uc?export=view&id=1Aeas6unQkz_qEDDHkKHYrgbcyzQZOIWi',
  'https://drive.google.com/uc?export=view&id=1C5HClg9BQyJyBMrfJ9xvC_LzcIinOe91',
  'https://drive.google.com/uc?export=view&id=1944Rbear4O089E5edHPKw6aQtIKyuiA2',
  'https://drive.google.com/uc?export=view&id=18s1V2altrQ-Ty-auSIDBS7lfi72q1tKt',
  'https://drive.google.com/uc?export=view&id=1BNrCZ5BvYVvp2KoKUa2j1hN68Acpuw9q',
  'https://drive.google.com/uc?export=view&id=1Cqu4hIPy1Z2NeX42u3GxD9OeiwV-ryF_',
  'https://drive.google.com/uc?export=view&id=18DP9Jq3fq2JHkNW-P-Y8zeaiAT6-NDXd',
  'https://drive.google.com/uc?export=view&id=190IaVX5vob7rSuhrYGyoYi9fMKf91cYL',
  'https://drive.google.com/uc?export=view&id=1A65-9KjWjmEWkk1Rzz2eciPFgtDK1qBq',
  'https://drive.google.com/uc?export=view&id=1oJ-MsNm1kMcNq5DxJ6kh0PkEK3MsT1SW',
  'https://drive.google.com/uc?export=view&id=19oEV1QKIv7DDpy5XaidURwg553818jWQ',
];

class StatesListViewModel extends BaseViewModel {
  bool isLoading = true;
  int lastImagePosition = 0;
  bool hasErrorOnData = false;
  int page = 0;
  bool allLoaded = false;
  bool isLoadingOldData = false;
  int size = 8;
  final ScrollController scrollController = ScrollController();
  final _navigationService = locator<NavigationService>();
  final _httpService = locator<HttpService>();
  List<TopStatesModel> topCitiesList = [];
  List<String> topCitiesImages = [];

  List<TopStatesContent> get topStates {
    final List<TopStatesContent> allCities = [];

    topCitiesList.forEach((element) {
      allCities.addAll(element.content ?? []);
    });

    return allCities;
  }

  StatesListViewModel() {
    propertyImages.shuffle();
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
          topStates.isNotEmpty &&
          !isLoadingOldData) {
        getOldData();
      }
    });
  }

  String getImage() {
    if (lastImagePosition < propertyImages.length - 1) {
      lastImagePosition++;
      return propertyImages[lastImagePosition - 1];
    } else if (lastImagePosition == propertyImages.length - 1) {
      lastImagePosition = 0;
      return propertyImages[propertyImages.length - 1];
    } else {
      return propertyImages[0];
    }
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
      //generating images
      topCities.content?.forEach((element) {
        topCitiesImages.add(getImage());
      });
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
    topCitiesImages.clear();
    hasErrorOnData = false;
    allLoaded = false;
    notifyListeners();
    try {
      final topCities = await _httpService.getTopStatesWithHighestProperties(
          page: page, size: size);
      allLoaded = (topCities.last ?? false) || (topCities.empty ?? false);
      topCitiesList.add(topCities);
//generating images
      topCities.content?.forEach((element) {
        topCitiesImages.add(getImage());
      });
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
