import 'package:observable_ish/observable_ish.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:stacked/stacked.dart';


class UserTypeService with ReactiveServiceMixin{

  RxValue<bool> _isTenant = RxValue<bool>(false) ;
  bool get isTenant => _isTenant.value;

  UserTypeService() {
    listenToReactiveValues([_isTenant]);
  }
  void userType() {
    _isTenant.value = !_isTenant.value;
  }

}