import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/views/audio_call/pickup_layout.dart';
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
    return PickupLayout(scaffold: buildBody());
  }

  ViewModelBuilder<ChatRoomViewModel> buildBody() {
    return ViewModelBuilder<ChatRoomViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: buildAppBar(model),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 20),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: ChatRoomViewModel.getChatMessages(
                      widget.chatModel?.chatId ?? ''),
                  builder: (ctx, asyncDataSnapshot) {
                    if (asyncDataSnapshot.hasError) {
                      return buildErrorBody(ctx);
                    }
                    if (asyncDataSnapshot.hasData) {
                      final queryData = asyncDataSnapshot.data;
                      final List<ChatMessageModel> allChatModel = queryData
                              ?.docs
                              .map((documentSnapshot) =>
                                  ChatMessageModel.fromJson(
                                      documentSnapshot.data()))
                              .toList() ??
                          [];

                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.all(0),
                              physics: const BouncingScrollPhysics(),
                              controller: model.scrollController,
                              itemBuilder: (_, index) {
                                final chatMessageModel = allChatModel[index];
                                return MessageBox(
                                  message: chatMessageModel.message,
                                  time: ChatRoomViewModel.getDetailedDate(
                                      chatMessageModel.timestamp),
                                  isRight: ChatRoomViewModel.isUSerChat(
                                      chatMessageModel.userId),
                                );
                              },
                              itemCount: allChatModel.length,
                            ),
                            /*    ListView.builder(
                              itemCount: demeChatMessages.length,
                              itemBuilder: (context, index) =>
                                  Message(message: demeChatMessages[index]),
                            ),*/
                          ),
                          const SizedBox(height: 5),
                          ChatInputField(widget.chatModel),
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
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      backgroundColor: kWhite,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BackButton(
            color: Colors.black,
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: InkWell(
            onTap: () {
              model.startCall(
                otherUserEmail: otherUserEmail,
                otherUserName: otherUserName,
                otherUserImage: otherUserImage,
                chatID: widget.chatModel?.chatId ?? '',
              );
            },
            child: Icon(
              Icons.phone,
              color: kBlack,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            model.goToVideoCallView();
          },
          child: Icon(
            Icons.videocam_outlined,
            color: kBlack,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Icon(
            Icons.search,
            color: kBlack,
          ),
        ),
      ],
    );
  }
}

class MessageBox extends StatelessWidget {
  final String time;
  final String message;
  final bool isRight;

  const MessageBox({
    Key? key,
    required this.message,
    required this.time,
    required this.isRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final bodyText2 = textTheme.bodyText2!.copyWith(
      fontSize: 14,
      overflow: TextOverflow.clip,
      color: isRight ? Colors.black : Colors.white,
      fontWeight: FontWeight.w400,
    );

    final width = MediaQuery.of(context).size.width;

    var date = Text(
      time,
      style: Theme.of(context).textTheme.headline1!.copyWith(
            fontSize: 10,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
          ),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (isRight) const Spacer(),
          if (isRight) date,
          if (isRight) const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            constraints: BoxConstraints(maxWidth: width * 0.7),
            decoration: BoxDecoration(
              color: isRight ? Colors.grey.withOpacity(0.5) : Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: (isRight)
                    ? const Radius.circular(10)
                    : const Radius.circular(1),
                topRight: (isRight)
                    ? const Radius.circular(1)
                    : const Radius.circular(10),
                bottomLeft: const Radius.circular(10),
                bottomRight: const Radius.circular(10),
              ),
            ),
            child: Text(
              message,
              style: bodyText2,
            ),
          ),
          if (!isRight) const SizedBox(width: 8),
          if (!isRight) date,
          if (!isRight) const Spacer(),
        ],
      ),
    );
  }
}
