import 'package:stacked/stacked.dart';

class PaymentViewModel extends BaseViewModel {
  bool _isChecked = false;
  bool get isChecked => _isChecked;

  void onCheckedChanged(bool? value) {
    _isChecked = value!;
    notifyListeners();
  }
}
