import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/ui/views/messages/messages_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../model/login_model.dart';
import '../../../services/core/user_type_service.dart';

class MessagesViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _userTypeService = locator<UserTypeService>();

  get getUserEmail => _userTypeService.userData.email;

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

  void goToChatRoomView(ChatModel chatModel) {
    resetChatCount(chatModel);
    _navigationService.navigateTo(Routes.chatRoomView, arguments: chatModel);
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getChats() {
    final _userTypeService = locator<UserTypeService>();
    String userEmail = _userTypeService.userData.email; // get user email
    return FirebaseFirestore.instance
        .collection('chat')
        .where('users_id', arrayContains: userEmail)
        .orderBy('last_message_timestamp', descending: true)
        .snapshots();
  }

  static bool isUSerChat(String userEmail) =>
      userEmail == locator<UserTypeService>().userData.email;

  static Future<ChatModel> createChat(String otherUserEmail,
      String otherUserName, String otherUserImage) async {
    try {
      final _userTypeService = locator<UserTypeService>();
      String userEmail = _userTypeService.userData.email;
      LoginModel userData = _userTypeService.userData;

      final List<String> users = [userEmail, otherUserEmail]..sort();
      final chatId = users.join('-');

      var doc = FirebaseFirestore.instance.collection('chat').doc(chatId);
      final documentReference = await doc.get();

      late ChatModel chatModel;
      if (documentReference.exists) {
        //edit item here
        ChatModel oldModel = ChatModel.fromJson(documentReference.data() ?? {});
        oldModel.messageCount[userEmail] = 0;
        oldModel.usersName[userEmail] =
            userData.firstName + " " + userData.lastName;
        oldModel.usersProfileImage[userEmail] = userData.imageUrl;
        chatModel = oldModel;
      } else {
        //create new
        chatModel = ChatModel(
            chatId: chatId,
            usersId: users,
            messageCount: {otherUserEmail: 0, userEmail: 0},
            lastMessage:
                ChatMessageModel(message: '', userId: '', timestamp: 0),
            lastMessageTimeStamp: DateTime.now().millisecondsSinceEpoch,
            usersName: {
              otherUserEmail: otherUserName,
              userEmail: userData.firstName + " " + userData.lastName,
            },
            usersProfileImage: {
              otherUserEmail: otherUserImage,
              userEmail: userData.imageUrl,
            });
      }

      await doc.set(chatModel.toJson(), SetOptions(merge: true));
      return chatModel;
    } catch (exception) {
      return Future.error('An error occurred, please try again later');
    }
  }

  static void resetChatCount(ChatModel model) async {
    try {
      final _userTypeService = locator<UserTypeService>();
      String userEmail = _userTypeService.userData.email;
      LoginModel userData = _userTypeService.userData;
      ChatModel chatModel = model;

      final chatDocumentReference =
          FirebaseFirestore.instance.collection('chat').doc(chatModel.chatId);

      chatModel.messageCount[userEmail] = 0;
      chatModel.usersName[userEmail] =
          userData.firstName + " " + userData.lastName;
      chatModel.usersProfileImage[userEmail] = userData.imageUrl;

      await chatDocumentReference.set(
          chatModel.toJson(), SetOptions(merge: true));
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
