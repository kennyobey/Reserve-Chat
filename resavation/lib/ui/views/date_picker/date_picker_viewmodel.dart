import 'package:stacked/stacked.dart';

enum ChoiceOfPayment {
  Monthly,
  Annual,
}

class DatePickerViewModel extends BaseViewModel {
  ChoiceOfPayment _paymentChoice = ChoiceOfPayment.Monthly;
  ChoiceOfPayment get paymentChoice => _paymentChoice;

  void onPaymentChoiceChanged(ChoiceOfPayment? value) {
    _paymentChoice = value!;
    notifyListeners();
  }
}
