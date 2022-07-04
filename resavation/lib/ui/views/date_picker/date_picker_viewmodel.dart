import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

enum ChoiceOfPayment {
  Monthly,
  Annually,
  Biannually,
  Quartely,
}

class DatePickerViewModel extends BaseViewModel {
  ChoiceOfPayment? paymentChoice;

  bool hasError = false;
  bool isNotValid = false;
  bool isLoading = true;

  final _navigationService = locator<NavigationService>();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime? selectedDate;
  final Property property;

  DatePickerViewModel(this.property) {
    final availabilityPeriods = property.availabilityPeriods;
    if (availabilityPeriods == null ||
        availabilityPeriods.startDate == null ||
        availabilityPeriods.endDate == null) {
      hasError = true;
    } else if (availabilityPeriods.startDate!.millisecondsSinceEpoch >=
        availabilityPeriods.endDate!.millisecondsSinceEpoch) {
      hasError = true;
    } else if (DateTime.now().millisecondsSinceEpoch >
        availabilityPeriods.endDate!.millisecondsSinceEpoch) {
      isNotValid = true;
    } else {
      startDate = availabilityPeriods.startDate!;
      endDate = availabilityPeriods.endDate!;
    }

    isLoading = false;
    notifyListeners();
  }

  void onPaymentChoiceChanged(ChoiceOfPayment value) {
    paymentChoice = value;
    notifyListeners();
  }

  void goToBookingSubmissionView(Property property) {
    _navigationService.navigateTo(Routes.bookingSubmissionView,
        arguments: BookingSubmissionViewArguments(
          startDate: selectedDate!,
          property: property,
          choiceOfPayment: paymentChoice!,
        ));
  }

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }
}
