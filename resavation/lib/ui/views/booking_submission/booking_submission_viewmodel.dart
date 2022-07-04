import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/user_type_service.dart';

class BookingSubmissionViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _userTypeService = locator<UserTypeService>();

  String get email => _userTypeService.userData.email;
  void goToConfirmationView() {
    _navigationService.navigateTo(Routes.confirmationView);
  }
}
