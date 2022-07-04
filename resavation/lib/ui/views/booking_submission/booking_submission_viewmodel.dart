import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:resavation/ui/views/date_picker/date_picker_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/core/user_type_service.dart';

class BookingSubmissionViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _userTypeService = locator<UserTypeService>();
  final _httpService = locator<HttpService>();

  String get email => _userTypeService.userData.email;
  void goToConfirmationView() {
    _navigationService.navigateTo(Routes.confirmationView);
  }

  bookProperty(
      {required Property property,
      required ChoiceOfPayment choiceOfPayment,
      required DateTime startDate}) async {
    final subscription = property.subscription;
    double amount = 0;

    if (choiceOfPayment == ChoiceOfPayment.Monthly) {
      amount = subscription?.monthlyPrice ?? 0;
    } else if (choiceOfPayment == ChoiceOfPayment.Quartely) {
      amount = subscription?.quarterlyPrice ?? 0;
    } else if (choiceOfPayment == ChoiceOfPayment.Biannually) {
      amount = subscription?.biannualPrice ?? 0;
    } else if (choiceOfPayment == ChoiceOfPayment.Annually) {
      amount = subscription?.annualPrice ?? 0;
    }
    try {
      await _httpService.bookProperty(
          amount: amount,
          id: property.id ?? -1,
          paymentType: choiceOfPayment.name.toUpperCase(),
          checkInDate: startDate);
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  void goToHomePage() {
    _navigationService.clearStackAndShow(Routes.mainView);
  }
}
