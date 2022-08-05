import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:resavation/model/saved_property/saved_property.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/string_helper.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_homepage/property_owner_homepageViewModel.dart';
import 'package:resavation/ui/views/property_owner_homepage/widget/property_owner_booked_properties.dart';
import 'package:resavation/ui/views/property_owner_homepage/widget/property_owner_properties.dart';

import 'package:stacked/stacked.dart';

import '../../shared/dump_widgets/list_space_button.dart';
import '../../shared/dump_widgets/resavation_image.dart';
import '../messages/messages_view.dart';
import '../messages/messages_viewmodel.dart';

class PropertyOwnerHomePageView extends StatefulWidget {
  const PropertyOwnerHomePageView({Key? key}) : super(key: key);

  @override
  State<PropertyOwnerHomePageView> createState() =>
      _PropertyOwnerHomePageViewState();
}

class _PropertyOwnerHomePageViewState extends State<PropertyOwnerHomePageView> {
  Future<bool?> showListSpaceDialog(BuildContext context) async {
    Dialog dialog = Dialog(
      backgroundColor: Colors.black,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      elevation: 5,
      child: Material(
          child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Property Upload',
              style: AppStyle.kBodyRegularBlack16W600,
            ),
            verticalSpaceTiny,
            Text(
              'Do you want to list a new property or continue from your previously saved property?',
              textAlign: TextAlign.start,
              style: AppStyle.kBodyRegularBlack14,
            ),
            verticalSpaceMedium,
            SizedBox(
              width: double.infinity,
              child: ResavationElevatedButton(
                child: Text(
                  'Start New Listing',
                ),
                color: Colors.grey,
                foregroundColor: kBlack,
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ),
            verticalSpaceTiny,
            SizedBox(
              width: double.infinity,
              child: ResavationElevatedButton(
                color: Colors.grey,
                foregroundColor: kBlack,
                child: Text('Resume Previous Listing'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ),
          ],
        ),
      )),
    );

    final isRestoring = await showGeneralDialog<bool>(
      context: context,
      barrierLabel: "Property Upload",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => dialog,
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      ),
    );
    return isRestoring;
  }

  Future<SavedProperty> showLoadingData(
      BuildContext context, PropertyOwnerHomePageViewModel model) async {
    Dialog dialog = Dialog(
      backgroundColor: Colors.black,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      elevation: 5,
      child: Material(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.blue,
                valueColor: AlwaysStoppedAnimation(kWhite),
              ),
            ),
            verticalSpaceMedium,
            Text(
              'Data Setup',
              style: AppStyle.kBodyRegularBlack16W600,
            ),
            verticalSpaceTiny,
            Text(
              'Please be patient while we set up your data.',
              textAlign: TextAlign.center,
              style: AppStyle.kBodyRegularBlack14,
            ),
          ],
        ),
      )),
    );

    showGeneralDialog(
      context: context,
      barrierLabel: "Property Restore",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => dialog,
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      ),
    );

    try {
      final SavedProperty savedProperty = await model.restoreSavedProperty();
      Navigator.of(context).pop();
      return savedProperty;
    } catch (exception) {
      Navigator.of(context).pop();
      return Future.error(
        exception.toString(),
      );
    }
  }

  Widget buildSpaceListing(PropertyOwnerHomePageViewModel model) {
    return Container(
      padding: EdgeInsets.all(15.0),
      decoration: new BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/images/Group 59.png"),
        ),
      ),
      width: double.infinity,
      height: 135.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpaceTiny,
          Text(
            "Connecting you to the best tenant all over the world",
            style: TextStyle(color: kWhite),
          ),
          verticalSpaceSmall,
          ListSpaceResavationElevatedButton(
            child: Text("List your space"),
            onPressed: () async {
              try {
                final savedProperty = await showLoadingData(context, model);

                if (savedProperty.propertyStatus != null) {
                  final isRestoring = await showListSpaceDialog(context);
                  if (isRestoring != null && isRestoring) {
                    model.goToPropertyOwnerSpaceTypeView(savedProperty);
                  } else {
                    model.goToPropertyOwnerSpaceTypeView(null);
                  }
                } else {
                  model.goToPropertyOwnerSpaceTypeView(null);
                }
              } catch (exception) {
                model.goToPropertyOwnerSpaceTypeView(null);
              }
            },
            //  borderColor: kp,
          ),
        ],
      ),
    );
  }

  Widget buildBadge(PropertyOwnerHomePageViewModel model) {
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

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerHomePageViewModel>.reactive(
      builder: (context, model, child) => FocusDetector(
        onFocusGained: () {
          model.getNewData();
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Center(
              child: GestureDetector(
                onTap: model.goToProfileDetails,
                child: Container(
                  height: 40,
                  width: 40,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(40)),
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
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSpaceListing(model),
                verticalSpaceMedium,
                PropertyOwnerProperties(),
                verticalSpaceMedium,
                PropertyOwnerBookedProperties(),
                verticalSpaceMedium,
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerHomePageViewModel(),
    );
  }
}
