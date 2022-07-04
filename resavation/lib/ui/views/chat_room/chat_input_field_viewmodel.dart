import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:stacked/stacked.dart';

import '../../../services/core/user_type_service.dart';
import '../messages/messages_view.dart';

class ChatInputFieldViewModel extends BaseViewModel {
  // emoji picker UI logic
  final TextEditingController controller = TextEditingController();
  final _userTypeService = locator<UserTypeService>();
  bool isMessageEmpty = true;

  bool emojiShowing = false;

  String imagePath = '';

  clearImage() {
    imagePath = '';
    updateTextState();
  }

  Future<String> showImagePicker(bool isCamera) async {
    try {
      final ImagePicker _picker = ImagePicker();
      // Pick an image
      XFile? image;

      if (isCamera) {
        image = await _picker.pickImage(
          source: ImageSource.camera,
        );
      } else {
        image = await _picker.pickImage(
          source: ImageSource.gallery,
        );
      }

      if (image != null) {
        String filePath = image.path;
        if (filePath.isNotEmpty) {
          imagePath = filePath;
          updateTextState();
          return filePath;
        } else {
          return Future.error('File Selection Failed');
        }
      } else {
        return Future.error('File Selection Canceled');
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  onEmojiSelected(Emoji emoji) {
    controller
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
  }

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

  Future<String> uploadDocument(int timestamp, String imagePath) async {
    String userEmail = _userTypeService.userData.email;
    final file = File(imagePath);
    Reference sFirebaseStorageRef = FirebaseStorage.instance.ref();
    Reference firebaseStorageRef =
        sFirebaseStorageRef.child('users/$userEmail/chatPictures/$timestamp');
    try {
      UploadTask uploadTask = firebaseStorageRef.putFile(file);
      final TaskSnapshot taskSnapshot = await uploadTask;
      String url = await taskSnapshot.ref.getDownloadURL();

      return url;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  sendChatMessage(ChatModel model, String message, String imagePath) async {
    try {
      String userEmail = _userTypeService.userData.email;

      ChatModel chatModel = model;

      int timeStamp = DateTime.now().millisecondsSinceEpoch;

      String imageUrl;
      if (imagePath.isNotEmpty) {
        imageUrl = await uploadDocument(timeStamp, imagePath);
      } else {
        imageUrl = '';
      }

      ChatMessageModel chatMessageModel = ChatMessageModel(
          message: message,
          userId: userEmail,
          timestamp: timeStamp,
          imageUrl: imageUrl);

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

    if (isMessageEmpty && (text.isNotEmpty || imagePath.isNotEmpty)) {
      isMessageEmpty = false;
    } else if (!isMessageEmpty && text.isEmpty && imagePath.isEmpty) {
      isMessageEmpty = true;
    }

    notifyListeners();
  }

  showImage(BuildContext context) {
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
          child: Image.file(
            File(imagePath),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.contain,
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
