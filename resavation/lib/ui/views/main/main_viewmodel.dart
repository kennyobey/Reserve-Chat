import 'package:resavation/app/app.locator.dart';
import 'package:resavation/services/core/user_type_service.dart';
import 'package:stacked/stacked.dart';

class MainViewModel extends ReactiveViewModel {
  final _userTypeService = locator<UserTypeService>();

  bool returnUserType() {
    return _userTypeService.isTenant;
  }

  int get currentIndex => _userTypeService.currentIndex;

  bool _reverse = false;

  /// Indicates whether we're going forward or backward in terms of the index we're changing.
  /// This is very helpful for the page transition directions.
  bool get reverse => _reverse;

  void setIndex(int value) {
    if (value < _userTypeService.currentIndex) {
      _reverse = true;
    } else {
      _reverse = false;
    }
    _userTypeService.serCurrentIndex(value);
    notifyListeners();
  }

  bool isIndexSelected(int index) => _userTypeService.currentIndex == index;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_userTypeService];
}
