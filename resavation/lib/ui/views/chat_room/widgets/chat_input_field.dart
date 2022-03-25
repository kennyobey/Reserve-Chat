import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/views/chat_room/chat_room_viewmodel.dart';
import 'package:resavation/ui/views/chat_room/widgets/buttom_sheet_widget.dart';
import 'package:stacked/stacked.dart';

class ChatInputField extends ViewModelWidget<ChatRoomViewModel> {
  const ChatInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
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
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    ChatInputIcon(
                      icon: Icons.sentiment_satisfied_alt_outlined,
                      onTap: () {
                        showModalBottomSheet(
                            backgroundColor: kTransparent,
                            context: context,
                            builder: (builder) => showEmoji(context));
                        model.emojiShowing = !model.emojiShowing;
                      },
                    ),
                    SizedBox(width: kDefaultPadding / 4),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
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
            SizedBox(width: kDefaultPadding),
            Icon(Icons.mic, color: kPrimaryColor),
          ],
        ),
      ),
    );
  }

  Widget showEmoji(BuildContext context) {
    return SizedBox(
      height: 250,
      child: EmojiPicker(
          onEmojiSelected: (Category category, Emoji emoji) {
            // model.onEmojiSelected(emoji);
          },
          onBackspacePressed: () {},
          config: Config(
              columns: 7,
// Issue: https://github.com/flutter/flutter/issues/28894
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
