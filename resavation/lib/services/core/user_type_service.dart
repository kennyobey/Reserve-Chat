import 'package:observable_ish/value/value.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/model/login_model.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:stacked/stacked.dart';

class UserTypeService with ReactiveServiceMixin {
  RxValue<LoginModel> _userData = RxValue<LoginModel>(LoginModel());

  RxValue<bool> _isTenant = RxValue<bool>(true);
  RxValue<int> _currentIndex = RxValue<int>(0);
  bool get isTenant => _isTenant.value;
  bool get hasOwnerRole =>
      _userData.value.accessRoles.contains('ROLE_PROPERTY_OWNER');

  int get currentIndex => _currentIndex.value;

  /// reactive service logic for to show invalid email or password
  RxValue<String> error = RxValue<String>("");

  /// Reactive service logic to confirm if password field == verify password field
  RxValue<String> _confirmPass = RxValue<String>("");
  String get confirmPass => _confirmPass.value;
  set confirmPass(String value) => _confirmPass.value = value;

  LoginModel get userData => _userData.value;

  setUserData(LoginModel data) {
    _userData.value = data;
    if (data.role.isNotEmpty) {
      _isTenant.value = !data.accessRoles.contains('ROLE_PROPERTY_OWNER');
    }
  }

  serCurrentIndex(int index) {
    _currentIndex.value = index;
    notifyListeners();
  }

  updateUserData(LoginModel data) {
    _userData.value = data;
  }

  Future<String> authorization() async {
    final tokenType = _userData.value.tokenType;
    String authorization = _userData.value.accessToken;
    final currentTimeStamp = DateTime.now().millisecondsSinceEpoch;
    final tokenExpiryTime = _userData.value.tokenExpiry * 1000;

    if (currentTimeStamp > tokenExpiryTime) {
      try {
        authorization = await locator<HttpService>()
            .refreshToken(_userData.value.refreshToken);
      } catch (exception) {
        return Future.error(
            'An error occurred while verifying your access token, please login again');
      }
    }
    return '$tokenType $authorization';
  }

  UserTypeService() {
    listenToReactiveValues([_isTenant]);
    listenToReactiveValues([_currentIndex]);
    listenToReactiveValues([_userData]);
    listenToReactiveValues([_confirmPass]);
    listenToReactiveValues([error]);
  }

  void toggleUserType() {
    _isTenant.value = !_isTenant.value;
  }

  void changePositionToSearch() {
    _currentIndex.value = 2;
    notifyListeners();
  }
}
