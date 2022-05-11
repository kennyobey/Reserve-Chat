import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../model/call_model.dart';
import '../../../services/core/user_type_service.dart';
import '../audio_call/call_methods.dart';
import '../audio_call/permission_checker.dart';
import '../messages/messages_view.dart';

class ChatRoomViewModel extends BaseViewModel {
  // emoji picker UI logic
  final TextEditingController controller = TextEditingController();

  bool isMessageEmpty = true;

  bool emojiShowing = false;

  final scrollController = ScrollController();

  static final CallMethods callMethods = CallMethods();
  final _navigationService = locator<NavigationService>();
  final _userTypeService = locator<UserTypeService>();

  get getUserEmail => _userTypeService.userData.email;

  onEmojiSelected(Emoji emoji) {
    controller
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
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

  onBackspacePressed() {
    controller
      ..text = controller.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
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

  static sendChatMessage(ChatModel model, String message) async {
    try {
      final _userTypeService = locator<UserTypeService>();
      String userEmail = _userTypeService.userData.email;

      ChatModel chatModel = model;

      int timeStamp = DateTime.now().millisecondsSinceEpoch;
      ChatMessageModel chatMessageModel = ChatMessageModel(
          message: message, userId: userEmail, timestamp: timeStamp);

      String otherUserEmail = chatModel.usersId
          .where((element) => element.toString() != userEmail)
          .first;

      //check if chat already exists
      var chatDocumentReference =
          FirebaseFirestore.instance.collection('chat').doc(chatModel.chatId);

      final newCount = chatModel.messageCount[otherUserEmail] + 1;

      chatModel.lastMessage = chatMessageModel;
      chatModel.lastMessageTimeStamp = chatMessageModel.timestamp;
      chatModel.messageCount = {otherUserEmail: newCount, userEmail: 0};

      //update or create the chat document
      await chatDocumentReference.set(
          chatModel.toJson(), SetOptions(merge: true));
      // add the message to the chat document
      await chatDocumentReference
          .collection('messages')
          .doc()
          .set(chatMessageModel.toJson());
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  void updateTextState() {
    final text = controller.text.trim();

    if (isMessageEmpty && text.isNotEmpty) {
      isMessageEmpty = false;
      notifyListeners();
    } else if (!isMessageEmpty && text.isEmpty) {
      isMessageEmpty = true;
      notifyListeners();
    }
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
        callerId: userData.email,
        callerName: userData.firstName + " " + userData.lastName,
        callerPic: userData.imageUrl,
        receiverId: otherUserEmail,
        receiverName: otherUserName,
        receiverPic: otherUserImage,
        channelId: chatID,
        hasDialled: false,
      );

      bool callMade = await callMethods.makeCall(call: call);

      call.hasDialled = true;

      if (callMade) {
        _navigationService.navigateTo(Routes.audioCallView, arguments: call);
      }
    }
  }
}
