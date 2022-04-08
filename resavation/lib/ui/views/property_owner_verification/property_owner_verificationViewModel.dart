import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PropertyOwnerVerificationViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void goToPropertyOwnerMainView() {
    _navigationService.navigateTo(Routes.mainView);
  }
}
