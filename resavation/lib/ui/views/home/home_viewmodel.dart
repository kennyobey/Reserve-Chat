import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/appointment.dart';
import 'package:resavation/model/login_model.dart';
import 'package:resavation/model/tenant_booked_property/content.dart';
import 'package:resavation/model/top_categories_model/top_categories_model.dart';
import 'package:resavation/model/top_states_model/top_states_model.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:resavation/services/core/user_type_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

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

class TopCity {
  final String location;
  final int numberOfProperties;
  final String image;

  TopCity(this.location, this.numberOfProperties, this.image);
}

class Category {
  final String category;
  final String image;
  final bool featureReady;

  Category(this.category, this.image, this.featureReady);
}

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final httpService = locator<HttpService>();
  final _userService = locator<UserTypeService>();
  int lastImagePosition = 0;
  HomeViewModel() {
    propertyImages.shuffle();
    getTopCategoriesData();
    getTopStatesData();
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

  LoginModel get userData => _userService.userData;

  get getUserEmail => _userService.userData.email;
  void setPositionAsSearch() {
    _userService.changePositionToSearch();
  }

  void goToFilterView() {
    _navigationService.navigateTo(Routes.filterView);
  }

  void goToPropertyDetails() {
    _navigationService.navigateTo(Routes.propertyDetailsTenantView);
  }

  void goToTopItemsView(String itemName, bool isStates) {
    _navigationService.navigateTo(
      Routes.topItemView,
      arguments: TopItemViewArguments(itemName: itemName, isStates: isStates),
    );
  }

  void goToCategoriesView() {
    _navigationService.navigateTo(Routes.categoriesListView);
  }

  void goToStatesView() {
    _navigationService.navigateTo(Routes.statesListView);
  }

  void goToEditProfileView() {
    _navigationService.navigateTo(Routes.editProfileView);
  }

  void goToAppointmentList() {
    _navigationService.navigateTo(Routes.appointmentListView);
  }

  void goToMessage() {
    _navigationService.navigateTo(Routes.messagesView);
  }

  void goToUserProfileView() {
    _navigationService.navigateTo(Routes.userProfileView);
  }

  void goToBookedContentList() {
    _navigationService.navigateTo(Routes.bookedPropertyListView);
  }

  void goToBookedPropertyDetails(TenantBookedPropertyContent content) {
    _navigationService.navigateTo(
      Routes.propertyDetailsTenantView,
      arguments: PropertyDetailsTenantViewArguments(
        passedProperty: content.property,
        tenantPropertyContent: content,
      ),
    );
  }

  bool topStatesLoading = true;
  bool topStateHasError = false;
  TopStatesModel topStatesModel = TopStatesModel();
  final List<String> topStatesImages = [];
  getTopStatesData() async {
    topStatesLoading = true;
    notifyListeners();

    try {
      topStatesImages.clear();
      topStatesModel = await httpService.getTopStatesWithHighestProperties();
      topStatesModel.content?.forEach((element) {
        topStatesImages.add(getImage());
      });
      topStateHasError = false;
    } catch (exception) {
      topStateHasError = true;
    }
    topStatesLoading = false;
    notifyListeners();
  }

  bool topCategoriesLoading = true;
  bool topCategoriesHasError = false;
  TopCategoriesModel topCategoriesModel = TopCategoriesModel();
  List<String> topCategoriesImages = [];
  getTopCategoriesData() async {
    topCategoriesLoading = true;
    notifyListeners();

    try {
      topCategoriesImages.clear();
      topCategoriesModel =
          await httpService.getTopCategoriesWithHighestProperties();
      topCategoriesModel.content?.forEach((element) {
        topCategoriesImages.add(getImage());
      });
      topCategoriesHasError = false;
    } catch (exception) {
      topCategoriesHasError = true;
    }
    topCategoriesLoading = false;
    notifyListeners();
  }

  getNewData() {
    getTenantAppointmentData();
    getTenantBookedPropertyData();
  }

  bool tenantAppointmentLoading = true;
  bool tenantAppointmentHasError = false;
  List<Appointment> tenantAppointmentModel = [];
  getTenantAppointmentData() async {
    tenantAppointmentLoading = true;
    notifyListeners();

    try {
      final data = await getTenantAppointments(userData.email);
      tenantAppointmentModel = data.docs
          .map(
            (documentSnapshot) => Appointment.fromMap(
              documentSnapshot.data(),
            ),
          )
          .toList();
      tenantAppointmentHasError = false;
    } catch (exception) {
      tenantAppointmentHasError = true;
    }
    tenantAppointmentLoading = false;
    notifyListeners();
  }

  bool tenantBookedPropertyLoading = true;
  bool tenantBookedPropertyHasError = false;
  List<TenantBookedPropertyContent> tenantBookedPropertyModel = [];
  getTenantBookedPropertyData() async {
    tenantBookedPropertyLoading = true;
    notifyListeners();

    try {
      final data =
          await httpService.getAllTenantsBookedProperty(page: 0, size: 5);
      tenantBookedPropertyModel = data.content ?? [];
      tenantBookedPropertyHasError = false;
    } catch (exception) {
      tenantBookedPropertyHasError = true;
    }
    tenantBookedPropertyLoading = false;
    notifyListeners();
  }
}
