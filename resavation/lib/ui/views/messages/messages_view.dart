import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/messages/messages_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MessagesViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: buildBody(model, context),
        ),
      ),
      viewModelBuilder: () => MessagesViewModel(),
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
          'An error occurred with the data fetch, please try again later',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const Spacer(),
      ],
    );
  }

  Widget buildBody(MessagesViewModel model, BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: MessagesViewModel.getChats(),
        builder: (ctx, asyncDataSnapshot) {
          if (asyncDataSnapshot.hasError) {
            return buildErrorBody(ctx);
          }
          if (asyncDataSnapshot.hasData) {
            final queryData = asyncDataSnapshot.data;
            final List<ChatModel> allChats = queryData?.docs
                    .map((documentSnapshot) =>
                        ChatModel.fromJson(documentSnapshot.data()))
                    .toList() ??
                [];
            if (allChats.isEmpty) {
              return buildEmptyBody(ctx);
            } else {
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  itemCount: allChats.length,
                  itemBuilder: (ctx, index) {
                    final chatModel = allChats[index];
                    return MessagesCard(
                      onTap: model.goToChatRoomView,
                      chatModel: chatModel,
                      userEmail: model.getUserEmail,
                    );
                  });
            }
          } else {
            return buildLoadingWidget();
          }
        });
  }

  Column buildEmptyBody(BuildContext context) {
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
          'No chat yet!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'Kindly check back later for new chats',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const Spacer(),
      ],
    );
  }

  Center buildLoadingWidget() {
    return const Center(
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

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kWhite,
      leading: BackButton(
        color: Colors.black,
      ),
      title: Text(
        'Messages',
        style: AppStyle.kBodyBold.copyWith(color: kBlack),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(
            Icons.search,
            color: kBlack,
          ),
        ),
      ],
    );
  }
}

class MessagesCard extends StatelessWidget {
  final ChatModel chatModel;
  final String userEmail;

  const MessagesCard({
    required this.chatModel,
    required this.userEmail,
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final void Function(ChatModel) onTap;

  @override
  Widget build(BuildContext context) {
    final count = chatModel.messageCount[userEmail] ?? 0;
    String otherUserEmail = chatModel.usersId
        .firstWhere((element) => element.toString() != userEmail);
    final userName = chatModel.usersName[otherUserEmail] ?? '';
    final otherUserImage = chatModel.usersProfileImage[otherUserEmail] ?? '';
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () => onTap(chatModel),
        child: Row(
          children: [
            buildImage(otherUserImage),
            horizontalSpaceSmall,
            buildUserDetails(userName),
            buildLastMessages(count),
          ],
        ),
      ),
    );
  }

  Column buildLastMessages(
    int count,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          MessagesViewModel.getDetailedDate(chatModel.lastMessageTimeStamp),
          style: AppStyle.kBodySmallRegular,
        ),
        if (count != 0)
          Container(
            height: 22,
            width: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kPrimaryColor,
            ),
            child: Center(
              child: Text(
                count.toString(),
                style: AppStyle.kBodySmallRegular11W400.copyWith(color: kWhite),
              ),
            ),
          )
      ],
    );
  }

  Expanded buildUserDetails(String userName) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userName,
            style: AppStyle.kBodyBold,
          ),
          const SizedBox(height: 5),
          Text(
            chatModel.lastMessage.message,
            style: AppStyle.kBodySmallRegular.copyWith(
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Container buildImage(String otherUserImage) {
    return Container(
      height: 40,
      width: 40,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ResavationImage(image: otherUserImage),
    );
  }
}

class ChatModel {
  String chatId;
  List<dynamic> usersId;
  Map<String, dynamic> messageCount;
  Map<String, dynamic> usersName;
  Map<String, dynamic> usersProfileImage;
  ChatMessageModel lastMessage;
  int lastMessageTimeStamp;

  ChatModel({
    required this.chatId,
    required this.usersId,
    required this.messageCount,
    required this.usersName,
    required this.usersProfileImage,
    required this.lastMessage,
    required this.lastMessageTimeStamp,
  });

  static ChatModel fromJson(Map<String, dynamic> json) {
    return ChatModel(
      chatId: json['chat_id'] ?? '',
      usersId: json['users_id'] ?? [],
      messageCount: json['message_count'] ?? {},
      usersName: json['users_name'] ?? {},
      usersProfileImage: json['users_profile_image'] ?? {},
      lastMessageTimeStamp: json['last_message_timestamp'] ?? 0,
      lastMessage: ChatMessageModel.fromJson(json['last_message']),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['chat_id'] = chatId;
    data['users_id'] = usersId;
    data['message_count'] = messageCount;
    data['users_name'] = usersName;
    data['users_profile_image'] = usersProfileImage;
    data['last_message_timestamp'] = lastMessageTimeStamp;
    data['last_message'] = lastMessage.toJson();

    return data;
  }
}

class ChatMessageModel {
  String message;
  String userId;
  int timestamp;

  ChatMessageModel({
    required this.message,
    required this.userId,
    required this.timestamp,
  });

  static ChatMessageModel fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      message: json['message'] ?? '',
      userId: json['user_id'] ?? '',
      timestamp: json['timestamp'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['message'] = message;
    data['timestamp'] = timestamp;
    data['user_id'] = userId;

    return data;
  }
}
