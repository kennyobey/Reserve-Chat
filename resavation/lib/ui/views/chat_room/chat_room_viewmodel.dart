
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ChatRoomViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void goToAudioCallView() {
    _navigationService.navigateTo(Routes.audioCallView);
  }

  void goToVideoCallView() {
    _navigationService.navigateTo(Routes.videoCallView);
  }


}
