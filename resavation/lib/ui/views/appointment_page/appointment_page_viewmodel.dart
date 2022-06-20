import 'package:stacked/stacked.dart';

class AppointmentPageViewModel extends BaseViewModel {
  int currentTabPosition = 0;

  onTabItemPressed(int tab) {
    currentTabPosition = tab;
    notifyListeners();
  }
}
