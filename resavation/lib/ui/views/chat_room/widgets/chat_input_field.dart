import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/views/chat_room/chat_input_field_viewmodel.dart';
import 'package:resavation/ui/views/messages/messages_view.dart';
import 'package:stacked/stacked.dart';

class ChatInputField extends StatelessWidget {
  final ChatModel? chatModel;
  final VoidCallback onMessageSent;

  ChatInputField({
    required this.chatModel,
    required this.onMessageSent,
    Key? key,
  }) : super(key: key);

  Widget buildImageWidget(ChatInputFieldViewModel model, BuildContext context) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: model.imagePath.isNotEmpty
            ? Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    margin: const EdgeInsets.only(bottom: 10),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      onTap: () => model.showImage(context),
                      child: Image.file(
                        File(model.imagePath),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      onTap: model.clearImage,
                      child: Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        child: Icon(Icons.cancel_outlined, color: kWhite),
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox());
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatInputFieldViewModel>.reactive(
        viewModelBuilder: () => ChatInputFieldViewModel(),
        builder: (context, model, child) {
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
            child: Column(children: [
              buildImageWidget(model, context),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          buildEmojiField(context, model),
                          SizedBox(width: kDefaultPadding / 4),
                          buildInputField(model),
                          ChatInputIcon(
                            icon: Icons.attach_file,
                            onTap: () {
                              try {
                                model.showImagePicker(false);
                              } catch (exception) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      exception.toString(),
                                    ),
                                  ),
                                );
                              }
                              /*    showModalBottomSheet(
                                  backgroundColor: kTransparent,
                                  context: context,
                                  builder: (builder) => bottomSheet(context)); */
                            },
                          ),
                          SizedBox(width: kDefaultPadding / 4),
                          ChatInputIcon(
                            onTap: () => model.showImagePicker(true),
                            icon: Icons.camera_alt_outlined,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: kDefaultPadding / 2),
                  buildSendButton(model, context),
                ],
              ),
            ]),
          );
        });
  }

  ChatInputIcon buildEmojiField(
      BuildContext context, ChatInputFieldViewModel model) {
    return ChatInputIcon(
      icon: Icons.sentiment_satisfied_alt_outlined,
      onTap: () {
        showModalBottomSheet(
            backgroundColor: kTransparent,
            context: context,
            builder: (builder) => showEmoji(context, model));
        model.emojiShowing = !model.emojiShowing;
      },
    );
  }

  Expanded buildInputField(ChatInputFieldViewModel model) {
    return Expanded(
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
          contentPadding:
              const EdgeInsets.only(bottom: 5, top: 5, left: 5, right: 5),
          hintText: 'Type your message',
          // hintStyle: bodyText2
        ),
        // cursorColor: kTextColor,
      ),
    );
  }

  AnimatedContainer buildSendButton(
      ChatInputFieldViewModel model, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: /* model.isMessageEmpty ? 10 : */ 8),
      child:/*  model.isMessageEmpty
          ? Icon(Icons.mic, color: kPrimaryColor)
          :  */InkWell(
              onTap: () => sendChatMessage(model, context),
              child: Icon(
                Icons.send,
                color: kPrimaryColor,
                size: 22,
              ),
            ),
    );
  }

  void sendChatMessage(
      ChatInputFieldViewModel model, BuildContext context) async {
    final message = model.controller.text.trim();
    final imagePath = model.imagePath;
    if ((message.isNotEmpty || imagePath.isNotEmpty) && chatModel != null) {
      if (imagePath.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Uploading image, your message would be sent after a successful file upload.'),
          ),
        );
      }
      try {
        model.controller.text = '';
        model.imagePath = '';
        model.updateTextState();
        await model.sendChatMessage(chatModel!, message, imagePath);
        onMessageSent();
      } catch (exception) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              exception.toString(),
            ),
          ),
        );
      }
    }
  }

  Widget showEmoji(BuildContext context, ChatInputFieldViewModel model) {
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
