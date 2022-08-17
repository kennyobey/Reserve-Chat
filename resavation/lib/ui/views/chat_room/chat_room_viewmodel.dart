import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../model/call_model.dart';
import '../../../services/core/user_type_service.dart';
import '../../shared/dump_widgets/resavation_image.dart';
import '../audio_call/call_methods.dart';
import '../audio_call/permission_checker.dart';

class ChatRoomViewModel extends BaseViewModel {
  final scrollController = ScrollController();

  static final CallMethods callMethods = CallMethods();

  final _navigationService = locator<NavigationService>();
  final _userTypeService = locator<UserTypeService>();

  get getUserEmail => _userTypeService.userData.email;

  onMessageSent() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
  }

  static bool isUSerChat(String userEmail) =>
      userEmail == locator<UserTypeService>().userData.email;

  static String getDetailedDate(int timestamp) {
    try {
      var dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      if (today.day == dateTime.day &&
          today.month == dateTime.month &&
          today.year == dateTime.year) {
        return DateFormat('h:mm a').format(dateTime);
      } else {
        return DateFormat('MMM dd, yyyy').format(dateTime);
      }
    } catch (exception) {
      return "";
    }
  }

  void goToVideoCallView() {
    _navigationService.navigateTo(Routes.videoCallView);
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages(
      String chatId) {
    return FirebaseFirestore.instance
        .collection('chat')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  void startCall(
      {required String otherUserEmail,
      required String otherUserName,
      required String otherUserImage,
      required String chatID}) async {
    final status =
        await PermissionChecker.cameraAndMicrophonePermissionsGranted();
    if (status) {
      var userData = _userTypeService.userData;
      CallModel call = CallModel(
        callerId: userData.email.trim(),
        callerName: userData.firstName.trim() + " " + userData.lastName.trim(),
        callerPic: userData.imageUrl.trim(),
        receiverId: otherUserEmail.trim(),
        receiverName: otherUserName.trim(),
        callUtcTime: DateTime.now().toUtc().millisecondsSinceEpoch,
        receiverPic: otherUserImage.trim(),
        channelId: chatID.trim(),
        hasDialled: false,
      );

      bool callMade = await callMethods.makeCall(call: call);

      call.hasDialled = true;

      if (callMade) {
        _navigationService.navigateTo(Routes.audioCallView,
            arguments: AudioCallViewArguments(call: call));
      }
    }
  }

  showImage(String imageUrl, BuildContext context) {
    final size = MediaQuery.of(context).size;
    Dialog dialog = Dialog(
      backgroundColor: Colors.black,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      elevation: 5,
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        height: size.height * 0.8,
        width: size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: PhotoView.customChild(
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2.5,
          child: ResavationImage(
            image: imageUrl,
          ),
        ),
      ),
    );

    showGeneralDialog(
      context: context,
      barrierLabel: "Image Viewer",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => dialog,
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      ),
    );
  }
}
