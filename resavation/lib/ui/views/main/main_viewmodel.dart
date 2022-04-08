import 'package:resavation/app/app.locator.dart';
import 'package:resavation/services/core/user_type_service.dart';
import 'package:resavation/ui/views/signup/signup_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MainViewModel extends IndexTrackingViewModel{
  final _userTypeService = locator<UserTypeService>();

  bool returnUserType(){
    return  _userTypeService.isTenant;
  }

}
