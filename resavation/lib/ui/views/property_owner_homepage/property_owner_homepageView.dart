// ignore_for_file: deprecated_member_use

import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:resavation/model/saved_property/saved_property.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_homepage/property_owner_homepageViewModel.dart';
import 'package:resavation/utility/assets.dart';
import 'package:stacked/stacked.dart';

import '../../shared/dump_widgets/list_space_button.dart';
import '../../shared/dump_widgets/resavation_image.dart';

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
                child: Text('Start New Listing'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ),
            verticalSpaceTiny,
            SizedBox(
              width: double.infinity,
              child: ResavationElevatedButton(
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

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerHomePageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Center(
            child: GestureDetector(
              onTap: model.goToPropertyOwnerIdentificationVerificationView,
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
          title: Text(
            'Welcome ${model.userData.firstName.toUpperCase()}',
            style: AppStyle.kBodyRegularBlack14W600,
          ),
          actions: [
            IconButton(
              onPressed: () {
                model.goToMessage();
              },
              icon: Icon(
                Icons.notifications_none_outlined,
                color: Colors.black,
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
              const Divider(),
              verticalSpaceTiny,
              Text(
                "Tenants request",
                style: AppStyle.kBodyRegularBlack14W500,
              ),
              verticalSpaceTiny,
              const Divider(),
              verticalSpaceTiny,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Text(
                      "Details",
                      style: AppStyle.kBodyRegularBlack14,
                    ),
                    Spacer(),
                    Text(
                      "File",
                      style: AppStyle.kBodyRegularBlack14,
                    ),
                    Spacer(),
                    Text(
                      "Actions",
                      style: AppStyle.kBodyRegularBlack14,
                    ),
                  ],
                ),
              ),
              verticalSpaceRegular,
              ListingCard(
                onTap: () {
                  model.getBookedProperty();
                },
              ),
              verticalSpaceTiny,
              ListingCard(
                onTap: () {
                  model.UserProfilePageView();
                },
              ),
              verticalSpaceTiny,
              ListingCard(
                onTap: () {
                  model.UserProfilePageView();
                },
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerHomePageViewModel(),
    );
  }
}

class ResavationListSpace extends StatelessWidget {
  const ResavationListSpace({
    Key? key,
    this.onTap,
    required this.title,
    this.titleColor = kWhite,
    this.buttonColor = kPrimaryColor,
    this.height,
    this.width,
    this.borderColor = kPrimaryColor,
    this.icon,
    this.fontSize,
  }) : super(key: key);
  final void Function()? onTap;
  final String title;
  final Color titleColor;
  final Color buttonColor;
  final double? height;
  final double? width;
  final Color borderColor;
  final IconData? icon;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
          onPrimary: Colors.white,
          shadowColor: Colors.greenAccent,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          //minimumSize: Size(100, 40), //////// HERE
        ),
        onPressed: () {},
        child: Text(
          'List your space',
          style: AppStyle.kBodyRegular,
        ),
      ),
    );
  }
}

class ListingCard extends StatelessWidget {
  ListingCard({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: kGray),
          borderRadius: new BorderRadius.circular(5.0),
        ),
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          // minVerticalPadding: 0,
          leading: Container(
            height: 75,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6), //or 15.0
              child: GestureDetector(
                child: Image.asset(
                  Assets.profile_image4,
                  fit: BoxFit.fill,
                  //width: 80,
                  height: 80,
                ),
                onTap: onTap,
              ),
            ),
          ),
          title: Text(
            "Adeyemo Stphen",
            style: AppStyle.kBodySmallRegular11W500,
          ),
          subtitle: Text(
            "SeedBuilderHub",
            style: AppStyle.kBodySmallRegular10W400,
          ),
          trailing: Container(
            width: 80,
            height: 30,
            child: FlatButton(
              child: Text(
                'View',
                style: TextStyle(fontSize: 12.0),
              ),
              color: Colors.blueAccent,
              textColor: Colors.white,
              onPressed: () {
                bookApartment(context);
              },
            ),
          ),
        )

        //  Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       ])
        );
  }

  void bookApartment(BuildContext context) {
    var alertdialog = Dialog(
      child: Container(
        width: MediaQuery.of(context).size.height * 0.45,
        height: 150,
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),

        decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(15.0),
        ),
        // width: double.infinity,
        //height: 240,
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        // color: Colors.red,
                        height: 90,
                        width: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12), //or 15.0
                          child: Image.asset(
                            Assets.profile_image4,
                            fit: BoxFit.contain,
                            // width: 80,
                            // height: 80,
                          ),
                        ),
                      ),
                    ],
                  ),
                  horizontalSpaceSmall,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Queen Ameh",
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                      verticalSpaceTiny,
                      Text(
                        "Apartment",
                        style: AppStyle.kBodySmallRegular12W500,
                      ),
                      horizontalSpaceSmall,
                      Text(
                        "Requested",
                        style: AppStyle.kBodySmallRegular12W500,
                      ),
                    ],
                  ),
                  horizontalSpaceSmall,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Exit",
                            style: AppStyle.kBodySmallRegular10W400,
                          ),
                        ],
                      ),
                      verticalSpaceTiny,
                      Text(
                        "SeedBuilders",
                        style: AppStyle.kBodySmallRegular12W500,
                      ),
                      horizontalSpaceSmall,
                      Text(
                        "Jan 10, 2022",
                        style: AppStyle.kBodySmallRegular12W500,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    child: Text(
                      'Cancel',
                      style: AppStyle.kBodyRegularBlack14W500
                          .copyWith(color: kRed),
                    ),
                    color: kWhite,
                    textColor: kRed,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  horizontalSpaceSmall,
                  FlatButton(
                    child: Text(
                      'Accept',
                      style: AppStyle.kBodyRegular,
                    ),
                    color: kPrimaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      //model.goToPropertyOwnerAmenitiesView();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertdialog;
        });
  }
}
