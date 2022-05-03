import 'package:observable_ish/value/value.dart';
import 'package:resavation/model/login_model.dart';
import 'package:stacked/stacked.dart';

class UserTypeService with ReactiveServiceMixin {
  RxValue<LoginModel> _userData = RxValue<LoginModel>(LoginModel());
  RxValue<bool> _isTenant = RxValue<bool>(false);
  bool get isTenant => _isTenant.value;

  /// reactive service logic for to show invalid email or password
  RxValue<String> error = RxValue<String>("");

  /// Reactive service logic to confirm if password field == verify password field
  RxValue<String> _confirmPass = RxValue<String>("");
  String get confirmPass => _confirmPass.value;
  set confirmPass(String value) => _confirmPass.value = value;

  LoginModel get userData => _userData.value;

  setUserData(LoginModel data) {
    _userData.value = data;
    _isTenant.value = data.roles[0] == "ROLE_USER";
  }

  UserTypeService() {
    listenToReactiveValues([_isTenant]);
    listenToReactiveValues([_userData]);
    listenToReactiveValues([_confirmPass]);
    listenToReactiveValues([error]);
  }

  void userType() {
    _isTenant.value = !_isTenant.value;
  }
}
