import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/views/chat_room/chat_room_viewmodel.dart';
import 'package:resavation/ui/views/chat_room/widgets/buttom_sheet_widget.dart';
import 'package:resavation/ui/views/messages/messages_view.dart';
import 'package:stacked/stacked.dart';

class ChatInputField extends ViewModelWidget<ChatRoomViewModel> {
  final ChatModel? chatModel;

  ChatInputField(
    this.chatModel, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding / 2,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ChatInputIcon(
                    icon: Icons.sentiment_satisfied_alt_outlined,
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: kTransparent,
                          context: context,
                          builder: (builder) => showEmoji(context, model));
                      model.emojiShowing = !model.emojiShowing;
                    },
                  ),
                  SizedBox(width: kDefaultPadding / 4),
                  Expanded(
                    child: TextFormField(
                      controller: model.controller,
                      onChanged: (_) {
                        model.updateTextState();
                      },
                      maxLines: 8,
                      minLines: 1,
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.only(
                            bottom: 5, top: 5, left: 5, right: 5),
                        hintText: 'Type your message',
                        // hintStyle: bodyText2
                      ),
                      // cursorColor: kTextColor,
                    ),
                  ),
                  ChatInputIcon(
                    icon: Icons.attach_file,
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: kTransparent,
                          context: context,
                          builder: (builder) => bottomSheet(context));
                    },
                  ),
                  SizedBox(width: kDefaultPadding / 4),
                  ChatInputIcon(
                    icon: Icons.camera_alt_outlined,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: kDefaultPadding / 2),
          AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: model.isMessageEmpty ? 10 : 8),
            child: model.isMessageEmpty
                ? Icon(Icons.mic, color: kPrimaryColor)
                : InkWell(
                    onTap: () => sendChatMessage(model, context),
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Icon(
                        Icons.send,
                        color: kPrimaryColor,
                        size: 22,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  void sendChatMessage(ChatRoomViewModel model, BuildContext context) async {
    final message = model.controller.text.trim();
    if (message.isNotEmpty && chatModel != null) {
      try {
        model.controller.text = '';
        model.updateTextState();
        await ChatRoomViewModel.sendChatMessage(chatModel!, message);
        model.scrollController.animateTo(
          model.scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500),
        );
      } catch (exception) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(exception.toString())));
      }
    }
  }

  Widget showEmoji(BuildContext context, ChatRoomViewModel model) {
    return SizedBox(
      height: 250,
      child: EmojiPicker(
          onEmojiSelected: (Category category, Emoji emoji) {
            model.onEmojiSelected(emoji);
          },
          onBackspacePressed: () {
            model.onBackspacePressed();
          },
          config: Config(
              columns: 7,
              emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
              verticalSpacing: 0,
              horizontalSpacing: 0,
              initCategory: Category.RECENT,
              bgColor: const Color(0xFFF2F2F2),
              indicatorColor: Colors.blue,
              iconColor: Colors.grey,
              iconColorSelected: Colors.blue,
              progressIndicatorColor: Colors.blue,
              backspaceColor: Colors.blue,
              skinToneDialogBgColor: Colors.white,
              skinToneIndicatorColor: Colors.grey,
              enableSkinTones: true,
              showRecentsTab: true,
              recentsLimit: 28,
              noRecentsText: 'No Recents',
              noRecentsStyle:
                  const TextStyle(fontSize: 20, color: Colors.black26),
              tabIndicatorAnimDuration: kTabScrollDuration,
              categoryIcons: const CategoryIcons(),
              buttonMode: ButtonMode.MATERIAL)),
    );
  }
}

class ChatInputIcon extends StatelessWidget {
  const ChatInputIcon({Key? key, this.icon, this.onTap}) : super(key: key);

  final IconData? icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.64),
      ),
    );
  }
}
