// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';

import 'package:resavation/ui/views/property_owner_homepage/property_owner_homepageViewModel.dart';

import 'package:resavation/utility/assets.dart';

import 'package:stacked/stacked.dart';

class PropertyOwnerHomePageView extends StatelessWidget {
  const PropertyOwnerHomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerHomePageViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            child: CircleAvatar(
                              radius: 20, // Image radius
                              backgroundImage: AssetImage(Assets.profile_image),
                            ),
                          ),
                          horizontalSpaceSmall,
                          Text(
                            'Welcome Steven',
                            style: AppStyle.kBodyRegularBlack14W600,
                          ),
                          Spacer(),
                          Icon(Icons.notifications_outlined),
                        ],
                      ),
                      verticalSpaceMedium,
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: kGray),
                          borderRadius: new BorderRadius.circular(5.0),
                          color: kBlack,
                        ),
                        width: 345,
                        height: 125.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSpaceTiny,
                            Text(
                              "Connecting you to the best tenant in the world",
                              style: TextStyle(color: kWhite),
                            ),
                            verticalSpaceSmall,
                            ResavationButton(
                              width: 153,
                              height: 40,
                              onTap: () {
                                model.goToPropertyOwnerSpaceTypeView();
                              },
                              title: 'List Your Space',
                              titleColor: kWhite,
                              buttonColor: kPrimaryColor,
                              //  borderColor: kp,
                            ),
                          ],
                        ),
                      ),
                      verticalSpaceMedium,
                      Text(
                        "Tenants request",
                        style: AppStyle.kBodyBold,
                      ),
                      verticalSpaceTiny,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Text(
                              "Details",
                              style: AppStyle.kBodyRegular,
                            ),
                            Spacer(),
                            Text(
                              "File",
                              style: AppStyle.kBodyRegular,
                            ),
                            Spacer(),
                            Text(
                              "Actions",
                              style: AppStyle.kBodyRegular,
                            ),
                          ],
                        ),
                      ),
                      verticalSpaceRegular,
                      _ListingCard(),
                      verticalSpaceTiny,
                      _ListingCard(),
                      verticalSpaceTiny,
                      _ListingCard(),
                    ],
                  ),
                ),
                Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      child: Text(
                        'Back',
                        style: AppStyle.kBodyRegular,
                      ),
                      color: kWhite,
                      textColor: kBlack,
                      onPressed: () {},
                    ),
                    Spacer(),
                    FlatButton(
                      child: Text(
                        'Next',
                        style: AppStyle.kBodyRegular,
                      ),
                      color: kPrimaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        model.goToPropertyOwnerAppointmentPageoneView();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerHomePageViewModel(),
    );
  }
}

Widget _blackcontainer(String label) {
  //const maxLines = 5;
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      border: Border.all(color: kGray),
      borderRadius: new BorderRadius.circular(5.0),
      color: kBlack,
    ),
    width: 345,
    height: 125.0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpaceTiny,
        Text(
          "Connecting you to the best tenant in the world",
          style: TextStyle(color: kWhite),
        ),
        verticalSpaceSmall,
        ResavationButton(
          width: 153,
          height: 40,
          onTap: () {
            var model;
            model.goToPropertyOwnerSpaceTypeView();
          },
          title: 'List Your Space',
          titleColor: kWhite,
          buttonColor: kPrimaryColor,
          //  borderColor: kp,
        ),
      ],
    ),
  );
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
      margin: EdgeInsets.symmetric(horizontal: 0),
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

Widget _ListingCard() {
  const maxLines = 5;
  return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(color: kGray),
        borderRadius: new BorderRadius.circular(5.0),
      ),
      width: 360,
      height: maxLines * 17.0,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ListTile(
          leading: Icon(Icons.camera_rear, size: 20, color: Colors.black),
          title: Text(
            "Adeyemo Stephen",
            style: AppStyle.kBodyBold,
          ),
          subtitle: Text("SeedBuilderHub"),
          trailing: Container(
            width: 80,
            height: 30,
            child: FlatButton(
              child: Text(
                'Accept',
                style: TextStyle(fontSize: 12.0),
              ),
              color: Colors.blueAccent,
              textColor: Colors.white,
              onPressed: () {},
            ),
          ),
        )
      ]));
}
