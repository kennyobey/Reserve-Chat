import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

enum ChoiceOfPayment {
  Monthly,
  Annual,
}

class DatePickerViewModel extends BaseViewModel {
  ChoiceOfPayment _paymentChoice = ChoiceOfPayment.Monthly;

  ChoiceOfPayment get paymentChoice => _paymentChoice;
  DateTime selectedDate = DateTime.now();

  void onPaymentChoiceChanged(ChoiceOfPayment? value) {
    _paymentChoice = value!;
    notifyListeners();
  }

  final _navigationService = locator<NavigationService>();

  void goToBookingSubmissionView(Property property) {
    _navigationService.navigateTo(Routes.bookingSubmissionView,
        arguments: BookingSubmissionViewArguments(
          startDate: selectedDate,
          property: property,
        ));
  }

  void setSelectedDate(DateTime date) {
    selectedDate = date;
  }
}
