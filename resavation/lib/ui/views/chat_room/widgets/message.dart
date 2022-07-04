import 'package:flutter/material.dart';
import 'package:resavation/model/chat_message_model.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/views/chat_room/widgets/audio_message.dart';
import 'package:resavation/ui/views/chat_room/widgets/text_message.dart';
import 'package:resavation/ui/views/chat_room/widgets/image_message.dart';

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatMessage message) {
      switch (message.messageType) {
        case ChatMessageType.text:
          return TextMessage(message: message);
        case ChatMessageType.audio:
          return AudioMessage(message: message);
        case ChatMessageType.video:
          return ImageMessage();
        default:
          return SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: message.isSender
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              messageContaint(message),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment: message.isSender
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              message.isSender ? Text("18:24") : Text("18:20"),
              if (message.isSender)
                MessageStatusDot(status: message.messageStatus)
            ],
          ),
        ],
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final MessageStatus? status;

  const MessageStatusDot({Key? key, this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color dotColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.not_sent:
          return kErrorColor;
        case MessageStatus.not_view:
          return Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1);
        case MessageStatus.viewed:
          return kPrimaryColor;
        default:
          return Colors.transparent;
      }
    }

    return Container(
      margin: EdgeInsets.only(left: kDefaultPadding / 2),
      child: Icon(
        status == MessageStatus.not_sent ? Icons.close : Icons.done_all,
        size: 16,
        color: dotColor(status!),
      ),
    );
  }
}
