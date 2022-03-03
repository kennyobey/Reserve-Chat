// import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AudioCallViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  static const APP_ID = '2998731ccff54ea78cf2d71a5af4b66d';
  static const Token = '0062998731ccff54ea78cf2d71a5af4b66dIAAAHZGfXdNsay43RHeQR65mgdClxuSVEmFoZo8Ya7T4Ic+UovsAAAAAEAATtvR92RQdYgEAAQDTFB1i';
  bool _joined = false;
  int _remoteUid = 0;
  bool _switch = false;

  @override
  void initState() {
    // initPlatformState();
  }

  // Init the app
  Future<void> initPlatformState() async {
    // Get microphone permission
    // await [Permission.microphone].request();
    //
    // // Create RTC client instance
    // RtcEngineContext context = RtcEngineContext(APP_ID);
    // var engine = await RtcEngine.createWithContext(context);
    // // Define event handling logic
    // engine.setEventHandler(RtcEngineEventHandler(
    //     joinChannelSuccess: (String channel, int uid, int elapsed) {
    //       print('joinChannelSuccess ${channel} ${uid}');
    //       _joined = true;
    //       notifyListeners();
    //     }, userJoined: (int uid, int elapsed) {
    //   print('userJoined ${uid}');
    //   _remoteUid = uid;
    //   notifyListeners();
    // }, userOffline: (int uid, UserOfflineReason reason) {
    //   print('userOffline ${uid}');
    //   _remoteUid = 0;
    // }));
    // // Join channel with channel name as res1
    // await engine.joinChannel(Token, 'res1', null, 0);
  }


}
