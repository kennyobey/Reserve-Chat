import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resavation/model/chat_message_model.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/views/chat_room/chat_room_viewmodel.dart';
import 'package:resavation/ui/views/chat_room/widgets/avatar_card_widget.dart';
import 'package:resavation/ui/views/chat_room/widgets/chat_input_field.dart';
import 'package:resavation/ui/views/chat_room/widgets/message.dart';
import 'package:resavation/utility/assets.dart';
import 'package:stacked/stacked.dart';

class ChatRoomView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatRoomViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
          child: Scaffold(
            appBar: buildAppBar(model),
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: ListView.builder(
                      itemCount: demeChatMessages.length,
                      itemBuilder: (context, index) =>
                          Message(message: demeChatMessages[index]),
                    ),
                  ),
                ),
                ChatInputField(),
              ],
            ),
          )),
      viewModelBuilder: () => ChatRoomViewModel(),
    );
  }


  AppBar buildAppBar(ChatRoomViewModel model) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      backgroundColor: kWhite,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
            },
            child: Icon(Icons.arrow_back)),
          Expanded(
            child: AvatarCard(
              name: "Adeyemo Stephen",
              image: AssetImage(Assets.profile_image3),
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
            onTap: () {
              model.goToAudioCallView();
            },
            child: Icon(
              Icons.phone,
              color: kBlack,
            ),
          ),
        ),
        GestureDetector(
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
