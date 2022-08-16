import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/services/core/http_service.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../model/call_model.dart';
import '../../../services/core/user_type_service.dart';
import '../../shared/dump_widgets/resavation_image.dart';
import '../../shared/text_styles.dart';
import 'call_methods.dart';

class AudioCallView extends StatelessWidget {
  final _httpLocator = locator<HttpService>();
  final _userService = locator<UserTypeService>();
  final CallModel? call;
  final bool reciever;
  AudioCallView({
    Key? key,
    required this.call,
    this.reciever = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>(
        future: _httpLocator.getCallToken(
            callId: call?.channelId ?? '',
            isSender: call?.callerId == _userService.userData.email,
            userId: _userService.userData.id),
        builder: (context, asyncDataSnapshot) {
          if (asyncDataSnapshot.hasError) {
            return buildErrorBody(context);
          }

          if (asyncDataSnapshot.data != null) {
            final token = asyncDataSnapshot.data ?? '';
            return AudioCallViewBody(
              call: call,
              reciever: reciever,
              token: token,
            );
          } else {
            return buildLoadingWidget();
          }
        },
      ),
    );
  }

  Center buildLoadingWidget() {
    return const Center(
      child: SizedBox(
        height: 40,
        width: 40,
        child: CircularProgressIndicator.adaptive(
          backgroundColor: Colors.blue,
          valueColor: AlwaysStoppedAnimation(kWhite),
        ),
      ),
    );
  }

  Column buildErrorBody(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        Text(
          'Error occurred!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'An error occured with the data fetch, please try again later',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const Spacer(),
      ],
    );
  }
}

class AudioCallViewBody extends StatefulWidget {
  final CallModel? call;
  final String token;
  final bool reciever;
  AudioCallViewBody({
    required this.call,
    required this.token,
    required this.reciever,
  });

  @override
  _AudioCallViewBodyState createState() => _AudioCallViewBodyState();
}

class _AudioCallViewBodyState extends State<AudioCallViewBody> {
  static const APP_ID = '727ccbedaa644e80a7700e2b17c5fa06';
  final _userService = locator<UserTypeService>();
  final CallMethods callMethods = CallMethods();
  late RtcEngine _engine;
  int? _remoteUid;

  final _userTypeService = locator<UserTypeService>();
  late StreamSubscription callStreamSubscription;
  bool hasPicked = false;
  bool muted = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    addPostFrameCallback();
    initializeAgora();
    if (!widget.reciever) {
      checkTime();
    }
  }

  checkTime() {
    Future.delayed(Duration(milliseconds: 180000), () async {
      if (hasPicked) {
        return;
      } else {
        /// show prompt here and end call if needed
        AlertDialog alert = AlertDialog(
          contentPadding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
          titlePadding: EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 5),
          title: Text("Call Termination"),
          content: Text(
              "Your call would be terminated  has been no response for 3 minutes."),
          actions: [
            TextButton(
              child: Text("Okay"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
        callMethods.endCall(
          call: widget.call!,
        );
      }
    });
  }

  Future<void> initializeAgora() async {
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableVideo();
    _addAgoraEventHandlers();
    await _engine.setParameters(
        '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');

    await _engine.joinChannel(widget.token, widget.call?.channelId ?? '', null,
        _userService.userData.id);
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
        userJoined: (int uid, int elapsed) {
          setState(() {
            hasPicked = true;
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

          if (reason == UserOfflineReason.Dropped) {
            callMethods.endCall(
              call: widget.call!,
            );
          }
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
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.blueAccent : Colors.white,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.white : Colors.blueAccent,
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
    final topPadding = MediaQuery.of(context).padding.top;
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
              height: 200,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              margin: EdgeInsets.only(top: topPadding + 10, right: 10),
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
        channelId: widget.call?.channelId ?? '',
      );
    } else if (hasPicked || widget.reciever) {
      return const SizedBox();
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
          const SizedBox(height: 25),
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
