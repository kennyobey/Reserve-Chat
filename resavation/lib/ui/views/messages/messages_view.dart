import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/messages/messages_viewmodel.dart';
import 'package:resavation/utility/assets.dart';
import 'package:stacked/stacked.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MessagesViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kWhite,
          automaticallyImplyLeading: false,
          title: Text(
            'Messages',
            style: AppStyle.kBodyBold.copyWith(color: kBlack),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Icon(
                Icons.search,
                color: kBlack,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              verticalSpaceRegular,
              MessagesCard(
                onTap: model.showComingSoon,
                name: 'Adeyemo Stephen',
                image: AssetImage(Assets.profile_image3),
              ),
              verticalSpaceRegular,
              MessagesCard(
                name: 'Queen Ameh',
                image: AssetImage(Assets.profile_image2),
                onTap: (){
                  model.goToChatRoomView();
                },
              ),
              verticalSpaceRegular,
              MessagesCard(
                name: 'Adeyemo Stephen',
                image: AssetImage(Assets.profile_image),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => MessagesViewModel(),
    );
  }
}

class MessagesCard extends StatelessWidget {
  const MessagesCard({
    required this.name,
    required this.image,
    Key? key,
    this.onTap,
  }) : super(key: key);

  final String name;
  final AssetImage image;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 35, // Image radius
            backgroundImage: image,
          ),
        ),
        horizontalSpaceSmall,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Text(
                name,
                style: AppStyle.kBodyBold,
              ),
            ),
            Text(
              'Thank you so much',
              style: AppStyle.kBodySmallRegular,
            ),
          ],
        ),
        Spacer(),
        Column(
          children: [
            Text(
              '21 mins',
              style: AppStyle.kBodySmallRegular,
            ),
            Container(
              height: 18,
              width: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kPrimaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '1',
                  style: AppStyle.kBodySmallRegular11W400.copyWith(color: kWhite),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
