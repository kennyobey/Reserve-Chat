import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/shared/smart_widgets/find_your_location.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/string_helper.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/home/home_viewmodel.dart';
import 'package:resavation/ui/views/home/widget/home_user_booked_property.dart';
import 'package:resavation/ui/views/messages/messages_view.dart';
import 'package:resavation/ui/views/messages/messages_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'widget/home_top_categories.dart';
import 'widget/home_top_states.dart';
import 'widget/home_user_appointment.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => FocusDetector(
        onFocusGained: () {
          model.getNewData();
        },
        child: Scaffold(
          appBar: buildAppBar(model),
          body: buildBody(model),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  SingleChildScrollView buildBody(HomeViewModel model) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Find a\n',
              style: AppStyle.kHeading0.copyWith(
                  color: kBlack, height: 1.5, fontWeight: FontWeight.w400),
              children: [
                TextSpan(
                  text: 'Suitable Apartment',
                  style: AppStyle.kHeading2.copyWith(
                      color: kBlack, height: 1.5, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          verticalSpaceMedium,
          InkWell(
            onTap: () {
              model.setPositionAsSearch();
            },
            splashColor: Colors.transparent,
            child: AbsorbPointer(
              absorbing: true,
              child: FindYourLocation(
                onTap: () {},
                controller: null,
              ),
            ),
          ),
          verticalSpaceMedium,
          HomeTopCategories(),
          verticalSpaceMedium,
          HomeTopStates(),
          verticalSpaceMedium,
          HomeUserAppointment(),
          verticalSpaceMedium,
          HomeUserBookedProperty(),
          verticalSpaceMedium,
        ],
      ),
    );
  }

  AppBar buildAppBar(HomeViewModel model) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: Center(
        child: GestureDetector(
          onTap: model.goToUserProfileView,
          child: Container(
            height: 40,
            width: 40,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
            child: ResavationImage(
              image: model.userData.imageUrl,
            ),
          ),
        ),
      ),
      title: Row(
        children: [
          Text(
            'Welcome, ',
            style: AppStyle.kBodyRegularBlack14W500,
          ),
          Text(
            '${model.userData.firstName.toTitleCase()}!',
            style: AppStyle.kBodyRegularBlack14W600,
          ),
        ],
      ),
      actions: [
        Badge(
          badgeColor: Colors.transparent,
          position: BadgePosition.topStart(),
          elevation: 0,
          badgeContent: buildBadge(model),
          child: IconButton(
            onPressed: () {
              model.goToMessage();
            },
            icon: Icon(
              Icons.chat_outlined,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBadge(HomeViewModel model) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: MessagesViewModel.getChats(),
        builder: (ctx, asyncDataSnapshot) {
          if (asyncDataSnapshot.hasError) {
            return SizedBox();
          }
          if (asyncDataSnapshot.hasData) {
            final queryData = asyncDataSnapshot.data;
            final List<ChatModel> allChats = queryData?.docs
                    .map((documentSnapshot) =>
                        ChatModel.fromJson(documentSnapshot.data()))
                    .toList() ??
                [];
            if (allChats.isEmpty) {
              return SizedBox();
            } else {
              int totalCount = 0;
              allChats.forEach((chatModel) {
                totalCount +=
                    (chatModel.messageCount[model.getUserEmail] as int?) ?? 0;
              });
              if (totalCount == 0) {
                return SizedBox();
              } else {
                return Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.red,
                  ),
                  child: Text(
                    totalCount > 999 ? '999+' : totalCount.toString(),
                    style: AppStyle.kBodyRegularBlack14W500.copyWith(
                      color: kWhite,
                      fontSize: 12,
                    ),
                  ),
                );
              }
            }
          } else {
            return SizedBox();
          }
        });
  }
}
