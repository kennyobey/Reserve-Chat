import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  bool _checkValue = false;
  bool get checkValue => _checkValue;
  String userType = "Property Owner" ;


  void onRadioChanged(String value ){
    userType = value.toString();
    print(userType);
    notifyListeners();
  }

  void onCheckChanged(bool? value) {
    _checkValue = value ?? false;
    notifyListeners();
  }

  void goToLoginView() {
    _navigationService.replaceWith(Routes.logInView);
  }

  void goToMainView() {
    if(userType == "Tenant") {
      _navigationService.navigateTo(Routes.mainView);
    }
    else{
      _navigationService.navigateTo(Routes.propertyOwnerProfileView);
    }
  }
}
