import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ChatRoomViewModel extends BaseViewModel {
  // emoji picker UI logic
  final TextEditingController controller = TextEditingController();
  bool emojiShowing = false;

  onEmojiSelected(Emoji emoji) {
    controller
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
  }

  onBackspacePressed() {
    controller
      ..text = controller.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
  }

  final _navigationService = locator<NavigationService>();

  void goToAudioCallView() {
    _navigationService.navigateTo(Routes.audioCallView);
  }

  void goToVideoCallView() {
    _navigationService.navigateTo(Routes.videoCallView);
  }
}
