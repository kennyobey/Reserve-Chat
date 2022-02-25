import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PaymentViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  bool _isChecked = false;
  bool get isChecked => _isChecked;

  String _cardName = '';
  String get cardName => _cardName;

  String _cardNumber = '';
  String get cardNumber => _cardNumber;

  String _expiryDate = '';
  String get expiryDate => _expiryDate;

  String _cvvCode = '';
  String get cvvCode => _cvvCode;

  void onCheckedChanged(bool? value) {
    _isChecked = value!;
    notifyListeners();
  }

  void goToConfirmationView() {
    _navigationService.navigateTo(Routes.confirmationView);
  }

  void onCardNameChanged(String value) {
    _cardName = value;
    notifyListeners();
  }

  void onCardNumberChanged(String value) {
    _cardNumber = value;
    notifyListeners();
  }

  void onExpiryDateChanged(String value) {
    _expiryDate = value;
    notifyListeners();
  }

  void oncvvCodeChanged(String value) {
    _cvvCode = value;
    notifyListeners();
  }
}
