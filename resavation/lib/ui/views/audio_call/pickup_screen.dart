import 'package:flutter/material.dart';
import 'package:resavation/ui/views/audio_call/permission_checker.dart';

import '../../../model/call_model.dart';
import '../../shared/dump_widgets/resavation_image.dart';
import '../../shared/text_styles.dart';
import 'audio_call_view.dart';
import 'call_methods.dart';

class PickupScreen extends StatelessWidget {
  final CallModel call;
  final CallMethods callMethods = CallMethods();

  PickupScreen({
    required this.call,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
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
              child: ResavationImage(image: call.callerPic),
            ),
            const SizedBox(height: 10),
            Text(
              'Incoming call from ${call.callerName}',
              style: AppStyle.kBodyRegularBlack15,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.call_end),
                  color: Colors.redAccent,
                  onPressed: () async {
                    await callMethods.endCall(call: call);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.call),
                  color: Colors.green,
                  onPressed: () async => await PermissionChecker
                          .cameraAndMicrophonePermissionsGranted()
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AudioCallView(call: call),
                          ),
                        )
                      : {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
