import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/chat_room/chat_room_viewmodel.dart';
import 'package:resavation/ui/views/chat_room/widgets/avatar_card_widget.dart';
import 'package:resavation/ui/views/chat_room/widgets/chat_input_field.dart';
import 'package:stacked/stacked.dart';

import '../messages/messages_view.dart';

class ChatRoomView extends StatefulWidget {
  final ChatModel? chatModel;

  const ChatRoomView({required this.chatModel, Key? key}) : super(key: key);

  @override
  State<ChatRoomView> createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends State<ChatRoomView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatRoomViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: buildAppBar(model),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: ChatRoomViewModel.getChatMessages(
                  widget.chatModel?.chatId ?? '',
                ),
                builder: (ctx, asyncDataSnapshot) {
                  if (asyncDataSnapshot.hasError) {
                    return buildErrorBody(ctx);
                  }
                  if (asyncDataSnapshot.hasData) {
                    final queryData = asyncDataSnapshot.data;
                    final List<ChatMessageModel> allChatModel = queryData?.docs
                            .map((documentSnapshot) =>
                                ChatMessageModel.fromJson(
                                    documentSnapshot.data()))
                            .toList() ??
                        [];

                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 5, top: 10),
                            physics: const BouncingScrollPhysics(),
                            controller: model.scrollController,
                            itemBuilder: (_, index) {
                              final chatMessageModel = allChatModel[index];
                              return MessageBox(
                                message: chatMessageModel.message,
                                imageUrl: chatMessageModel.imageUrl,
                                onTap: () => model.showImage(
                                    chatMessageModel.imageUrl, context),
                                time: ChatRoomViewModel.getDetailedDate(
                                    chatMessageModel.timestamp),
                                isRight: ChatRoomViewModel.isUSerChat(
                                    chatMessageModel.userId),
                              );
                            },
                            itemCount: allChatModel.length,
                          ),
                        ),
                        const SizedBox(height: 5),
                        ChatInputField(
                          chatModel: widget.chatModel,
                          onMessageSent: model.onMessageSent,
                        ),
                        const SizedBox(height: 5),
                      ],
                    );
                  } else {
                    return buildLoadingWidget();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => ChatRoomViewModel(),
    );
  }

  Center buildLoadingWidget() {
    return Center(
      child: SizedBox(
        height: 40,
        width: 40,
        child: CircularProgressIndicator.adaptive(
          backgroundColor: Colors.blue,
          valueColor: AlwaysStoppedAnimation(kWhite),
        ),
      ),
    );
  }

  Column buildErrorBody(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        Text(
          'Error occurred!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'An error occured with the data fetch, please try again later',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const Spacer(),
      ],
    );
  }

  AppBar buildAppBar(ChatRoomViewModel model) {
    final otherUserEmail = widget.chatModel?.usersId.firstWhere(
            (element) => element.toString() != model.getUserEmail) ??
        '';
    final otherUserName = widget.chatModel?.usersName[otherUserEmail] ?? '';
    final otherUserImage =
        widget.chatModel?.usersProfileImage[otherUserEmail] ?? '';
    return AppBar(
      elevation: 1,
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      backgroundColor: kWhite,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BackButton(
            color: Color.fromARGB(255, 19, 10, 10),
          ),
          Expanded(
            child: AvatarCard(
              name: otherUserName,
              image: otherUserImage,
            ),
          ),
        ],
      ),
      actions: [
        InkWell(
          onTap: () {
            model.startCall(
              otherUserEmail: otherUserEmail,
              otherUserName: otherUserName,
              otherUserImage: otherUserImage,
              chatID: widget.chatModel?.chatId ?? '',
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.videocam_rounded,
              color: kBlack,
            ),
          ),
        ),
      ],
    );
  }
}

class MessageBox extends StatelessWidget {
  final String time;
  final String message;
  final String imageUrl;
  final bool isRight;
  final VoidCallback onTap;

  const MessageBox({
    Key? key,
    required this.message,
    required this.imageUrl,
    required this.time,
    required this.onTap,
    required this.isRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bodyText2 = AppStyle.kBodyRegularBlack14W600.copyWith(
      fontSize: 14,
      overflow: TextOverflow.clip,
      color: isRight ? Colors.white : Colors.black,
      fontWeight: !isRight ? FontWeight.w400 : FontWeight.w300,
    );

    final width = MediaQuery.of(context).size.width;

    final date = Text(
      time,
      style: Theme.of(context).textTheme.headline1!.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: isRight ? Colors.white : Colors.black,
          ),
    );
    return Align(
      alignment: isRight ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 5,
        ),
        margin: const EdgeInsets.only(bottom: 10),
        constraints: BoxConstraints(maxWidth: width * 0.7),
        decoration: BoxDecoration(
          color: isRight ? kDarkGrey : kGray,
          borderRadius: BorderRadius.all(
            const Radius.circular(5),
          ),
        ),
        child: Column(
          crossAxisAlignment:
              isRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (imageUrl.isNotEmpty)
              Container(
                width: double.infinity,
                height: 130,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    const Radius.circular(5),
                  ),
                ),
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: onTap,
                  child: ResavationImage(
                    image: imageUrl,
                  ),
                ),
              ),
            if (message.isNotEmpty && imageUrl.isNotEmpty)
              const SizedBox(
                height: 8,
              ),
            if (message.isNotEmpty)
              Text(
                message,
                style: bodyText2,
              ),
            const SizedBox(height: 5),
            date,
          ],
        ),
      ),
    );
  }
}
