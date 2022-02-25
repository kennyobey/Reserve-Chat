import 'dart:async';


import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioCallView extends StatefulWidget {
  const AudioCallView({Key? key}) : super(key: key);

  @override
  _AudioCallViewState createState() => _AudioCallViewState();
}

class _AudioCallViewState extends State<AudioCallView> {
  static const APP_ID = '2998731ccff54ea78cf2d71a5af4b66d';
  static const Token = '0062998731ccff54ea78cf2d71a5af4b66dIADuQJYjDcTdQxAAkLxuOnkpqp3lbZZycSdqMgVbouQOp3XFq2IAAAAAEAAg1/Vgsd4VYgEAAQCx3hVi';

  bool _joined = false;
  int _remoteUid = 0;
  bool _switch = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Init the app
  Future<void> initPlatformState() async {
    // Get microphone permission
    await [Permission.microphone].request();

    // Create RTC client instance
    RtcEngineContext context = RtcEngineContext(APP_ID);
    var engine = await RtcEngine.createWithContext(context);
    // Define event handling logic
    engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print('joinChannelSuccess ${channel} ${uid}');
          setState(() {
            _joined = true;
          });
        }, userJoined: (int uid, int elapsed) {
      print('userJoined ${uid}');
      setState(() {
        _remoteUid = uid;
      });
    }, userOffline: (int uid, UserOfflineReason reason) {
      print('userOffline ${uid}');
      setState(() {
        _remoteUid = 0;
      });
    }));
    // Join channel with channel name as res2
    await engine.joinChannel(Token, 'res2', null, 0);
  }

  // Build chat UI
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agora Audio quickstart',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Agora Audio quickstart'),
        ),
        body: Center(
          child: Text('Please chat!'),
        ),
      ),
    );
  }
}
