import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class VideoCallViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();


  String APP_ID = '2998731ccff54ea78cf2d71a5af4b66d';
  String channelName = 'server3';
  static const Token = '0062998731ccff54ea78cf2d71a5af4b66dIADfiFSOUGSTdFV96EX523Bm6HDiTV07ROuI5D3EfCWONWe0VjkAAAAAEAAp2Q6pTroXYgEAAQBLuhdi';

  late RtcEngine engine;

  bool joined = false;
  int remoteUid = 0;
  bool swap = false;
  bool muteAudio = false;
  bool muteVideo = false;

  @override
  initState() {
    initPlatformState();
    // Create RTC client instance
  }

  void swapView(){
    swap = !swap;
    notifyListeners();
  }
  Future<void> initPlatformState() async {
    await [Permission.camera, Permission.microphone].request();

    RtcEngineContext context = RtcEngineContext(APP_ID);
    engine =  await RtcEngine.createWithContext(context);
    // Define event handling logic
    engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print('joinChannelSuccess ${channel} ${uid}');
          joined = true;
          notifyListeners();
        }, userJoined: (int uid, int elapsed) {
      print('userJoined ${uid}');
      remoteUid = uid;
      notifyListeners();

    }, userOffline: (int uid, UserOfflineReason reason) {
      print('userOffline ${uid}');
      remoteUid = 0;
      notifyListeners();
    }));
    // Enable video
    await engine.enableVideo();
    // Join channel with channel name as 123
    await engine.joinChannel(Token, channelName, null, 0);
  }

  Future<void> muteAudioStream() async{
    muteAudio = !muteAudio;
    engine.muteLocalAudioStream(muteAudio);
    notifyListeners();
  }

  Future<void> muteVideoStream() async{
    muteVideo = !muteVideo;
    engine.muteLocalVideoStream(muteVideo);
    notifyListeners();
  }




}
