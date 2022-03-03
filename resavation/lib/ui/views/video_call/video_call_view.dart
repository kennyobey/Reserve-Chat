import 'dart:async';
//
// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/video_call/video_call_viewmodel.dart';
import 'package:stacked/stacked.dart';

class VideoCallView extends StatelessWidget {
  const VideoCallView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VideoCallViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child:  Scaffold(
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Stephen", style: AppStyle.kHeading1,),
                    Text("Duration 05:00 min", style: AppStyle.kBodySmallRegular,)
                  ],
                ),
              ),
              // Center(
              //   child: model.swap ? _renderRemoteVideo(model) : _renderLocalPreview(model),
              // ),

              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.2,
                right: MediaQuery.of(context).size.width * 0.1,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: kDarkBlue, width: 3)
                  ),
                  width: 130,
                  height: 164,
                  child: GestureDetector(
                    onTap: () {
                      model.swapView();
                    },
                    child: Container(),
                    // Center(
                    //   child:
                    //   model.swap ? _renderLocalPreview(model) : _renderRemoteVideo(model),
                    // ),
                  ),
                ),
              ),
            ],
          ),
          bottomSheet: Padding(
            padding:  EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //TODO refactor code here
                InkWell(
                  onTap: (){
                    model.initPlatformState();
                  },
                  child: Container(
                    width: 36,
                    height: 38,
                    decoration: BoxDecoration(
                        color: kChatTextColor,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding:  EdgeInsets.all(5.0),
                      child: (model.muteAudio) ? Icon(Icons.mic,color: kWhite,): Icon(Icons.mic_off,color: kWhite,),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 36,
                    height: 38,
                    decoration: BoxDecoration(
                        color: kRed,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding:  EdgeInsets.all(5.0),
                      child: Icon(Icons.call, color: kWhite,),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: (){
                    model.initPlatformState();
                  },
                  child: Container(
                    width: 36,
                    height: 38,
                    decoration: BoxDecoration(
                        color: kChatTextColor,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding:  EdgeInsets.all(5.0),
                      child: (model.muteVideo) ? Icon(Icons.videocam_outlined,color: kWhite,): Icon(Icons.videocam_off_outlined,color: kWhite,),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => VideoCallViewModel(),
    );
  }
//
//   Widget _renderLocalPreview(VideoCallViewModel model) {
//     if (model.joined) {
//       return RtcLocalView.SurfaceView();
//     } else {
//       return Text(
//         'Video call unavailable',
//         textAlign: TextAlign.center,
//       );
//     }
//   }
//
//   // Remote preview
//   Widget _renderRemoteVideo(VideoCallViewModel model) {
//     if (model.remoteUid != 0) {
//       return RtcRemoteView.SurfaceView(
//         uid: model.remoteUid,
//         channelId: model.channelName,
//       );
//     } else {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(),
//           Text(
//             'Please await property owner to join',
//             textAlign: TextAlign.center,
//           ),
//         ],
//       );
//
//     }
//   }
}


