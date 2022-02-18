import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/services/core/custom_snackbar_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class EditProfileViewModel extends BaseViewModel {
  final _snackbarService = locator<CustomSnackbarService>();
  final _navigationService = locator<NavigationService>();

  void showComingSoon() {
    _snackbarService.showComingSoon();
  }

  void goToMainView() {
    _navigationService.navigateTo(Routes.mainView);
  }
}
