import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../property_owner_spaceType/property_owner_spacetype_viewmodel.dart';

class PropertyOwnerTrackListViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  String? propertySearchValue;
  List<String> propertyStatus = ['For Sale', 'For Rent'];

  String? selectedProperty;
  List<String> spaceType = [
    'Town House',
    'Plot of Land',
  ];

  final PropertyOwnerUploadModel propertyOwnerUploadModel =
      PropertyOwnerUploadModel();

  void goToPropertyOwnerHomePageView() {
    _navigationService.navigateTo(Routes.propertyOwnerHomePageView);
  }

  void goToDatePickerView() {
    _navigationService.navigateTo(Routes.datePickerView);
  }
}