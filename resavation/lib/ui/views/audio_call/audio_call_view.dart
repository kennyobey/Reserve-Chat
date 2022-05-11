import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../model/call_model.dart';
import '../../../services/core/user_type_service.dart';
import '../../shared/dump_widgets/resavation_image.dart';
import '../../shared/text_styles.dart';
import 'call_methods.dart';

class AudioCallView extends StatefulWidget {
  final CallModel? call;

  AudioCallView({
    required this.call,
  });

  @override
  _AudioCallViewState createState() => _AudioCallViewState();
}

class _AudioCallViewState extends State<AudioCallView> {
  static const APP_ID = '727ccbedaa644e80a7700e2b17c5fa06';

  static const Token =
      '0062998731ccff54ea78cf2d71a5af4b66dIAAAHZGfXdNsay43RHeQR65mgdClxuSVEmFoZo8Ya7T4Ic+UovsAAAAAEAATtvR92RQdYgEAAQDTFB1i';

  final CallMethods callMethods = CallMethods();
  late RtcEngine _engine;
  int? _remoteUid;

  bool _localUserJoined = false;
  final _userTypeService = locator<UserTypeService>();
  late StreamSubscription callStreamSubscription;

  bool muted = false;

  @override
  void initState() {
    super.initState();
    addPostFrameCallback();
    initializeAgora();
  }

  Future<void> initializeAgora() async {
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableVideo();
    _addAgoraEventHandlers();
    await _engine.setParameters(
        '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');
    await _engine.joinChannel(Token, widget.call?.channelId ?? '', null, 0);
  }

  addPostFrameCallback() {
    Future.delayed(Duration.zero, () {
      callStreamSubscription =
          callMethods.callStream(uid: _userTypeService.userData.email).listen(
        (DocumentSnapshot<Object?> ds) {
          switch (ds.data()) {
            case null:
              Navigator.pop(context);
              break;
            default:
              break;
          }
        },
      );
    });
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    _engine.setEventHandler(
      RtcEngineEventHandler(
        error: (code) {
          locator<SnackbarService>().showSnackbar(
            message: code.toString(),
            duration: const Duration(milliseconds: 1000),
          );
        },
        joinChannelSuccess: (
          String channel,
          int uid,
          int elapsed,
        ) {
          setState(() {
            _localUserJoined = true;
          });
        },
        userJoined: (int uid, int elapsed) {
          setState(() {
            _remoteUid = uid;
          });
        },
        leaveChannel: (state) {
          // get data on user left
          //todo end unique call
        },
        connectionLost: () {
          // show no network
          //todo end unique call
        },
        userOffline: (uid, reason) {
          // if call was picked
          //todo end unique call
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  /// Toolbar layout
  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic : Icons.mic_off,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => callMethods.endCall(
              call: widget.call!,
            ),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _engine.leaveChannel();
    _engine.destroy();
    callStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Center(
            child: _remoteVideo(),
          ),
          _toolbar(),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 100,
              height: 150,
              margin: const EdgeInsets.only(top: 40),
              child: Center(
                child: RtcLocalView.SurfaceView(
                  channelId: widget.call?.channelId ?? '',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid!,
        channelId: widget.call?.callerId ?? '',
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          Container(
            height: 180,
            width: 180,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ResavationImage(image: widget.call?.receiverPic ?? ''),
          ),
          const SizedBox(height: 10),
          Text(
            'Calling ${widget.call?.receiverName ?? ''}, please wait',
            style: AppStyle.kBodyRegularBlack15.copyWith(color: kWhite),
            textAlign: TextAlign.center,
          )
        ],
      );
    }
  }
}
