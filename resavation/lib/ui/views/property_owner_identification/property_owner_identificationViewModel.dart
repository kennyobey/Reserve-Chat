import 'package:country_picker/country_picker.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyOwnerIdentificationViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // country picker UI logic
  String selectedCountry = "Country";
  Function(Country) onSelectCountryTap(Country country){
    return   (Country country){
      selectedCountry = country.name.toString();
      notifyListeners();
    };
  }

  void goToPropertyOwnerVerificationView() {
    _navigationService.navigateTo(Routes.propertyOwnerVerificationView);
  }
}
