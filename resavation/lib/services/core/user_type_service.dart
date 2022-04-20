import 'package:observable_ish/observable_ish.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:stacked/stacked.dart';


class UserTypeService with ReactiveServiceMixin{

  RxValue<bool> _isTenant = RxValue<bool>(false) ;
  bool get isTenant => _isTenant.value;

  /// reactive service logic for to show invalid email or password
  RxValue<String> error = RxValue<String>("");

  /// Reactive service logic to confirm if password field == verify password field
  RxValue<String> _confirmPass = RxValue<String>("");
  String get confirmPass => _confirmPass.value;
  set confirmPass(String value) => _confirmPass.value = value;

  UserTypeService() {
    listenToReactiveValues([_isTenant]);
    listenToReactiveValues([_confirmPass]);
    listenToReactiveValues([error]);
  }
  void userType() {
    _isTenant.value = !_isTenant.value;
  }

}