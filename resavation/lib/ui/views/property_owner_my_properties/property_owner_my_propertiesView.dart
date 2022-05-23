// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';

import 'package:resavation/ui/views/property_owner_my_properties/property_owner_my_propertiesViewModel.dart';

import 'package:stacked/stacked.dart';

import '../../../utility/assets.dart';
import '../../shared/dump_widgets/resavation_button.dart';

class PropertyOwnerMyPropertyView extends StatelessWidget {
  const PropertyOwnerMyPropertyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerMyPropertyViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceMedium,
                Row(
                  children: [
                    Text(
                      'My Properties',
                      style: AppStyle.kBodyBold,
                    ),
                    Spacer(),
                    ResavationButton(
                      buttonColor: kWhite,
                      width: 80,
                      height: 25,
                      title: 'Add',
                      titleColor: kBlack,
                      borderColor: kBlack,
                      onTap: () {
                        model.goToPropertyOwnerHomePageView();
                      },
                    ),
                  ],
                ),
                verticalSpaceMedium,
                AppointmentView(),
                AppointmentView(),
                AppointmentView(),
                AppointmentView(),
                Spacer(),
                buildButtons(context, model),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerMyPropertyViewModel(),
    );
  }
}

class AppointmentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //const maxLines = 5;
    var model;
    var image;
    return Container(
      padding: EdgeInsets.all(3.0),
      width: MediaQuery.of(context).size.width,
      height: 95.0,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6), //or 15.0
                child: Image.asset(
                  Assets.listingImage,
                  // width: 60,
                  // height: 60,
                ),
              ),
            ),
            horizontalSpaceRegular,
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Eleko Estate',
                style: AppStyle.kSubHeadingW600,
              ),
              verticalSpaceTiny,
              Row(
                children: [
                  car("2"),
                  horizontalSpaceTiny,
                  sink("2"),
                  horizontalSpaceTiny,
                  land("2040 sqft")
                ],
              ),
              verticalSpaceTiny,
              Row(
                children: [
                  Text(
                    'Status',
                    style: AppStyle.kBodySmallRegular12,
                  ),
                  horizontalSpaceMedium,
                  Container(
                    padding: EdgeInsets.all(3),
                    color: Color.fromARGB(255, 238, 235, 235),
                    child: Text(
                      'Rented',
                      style: AppStyle.kBodySmallRegular12,
                    ),
                  ),
                ],
              ),
            ])
          ],
        ),
      ),
    );
  }
}

Widget car(
  String title,
) {
  return Container(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Icon(
        Icons.car_rental,
        size: 20,
        color: kGray,
      ),
      Text(
        title,
        style: TextStyle(
          color: kGray,
          fontSize: 15,
        ),
      ),
    ],
  ));
}

Widget sink(
  String title,
) {
  return Container(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Icon(
        Icons.bathroom,
        size: 20,
        color: kGray,
      ),
      Text(
        title,
        style: TextStyle(
          color: kGray,
          fontSize: 15,
        ),
      ),
    ],
  ));
}

Widget land(
  String title,
) {
  return Container(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Icon(
        Icons.square_foot_rounded,
        size: 20,
        color: kGray,
      ),
      Text(
        title,
        style: TextStyle(
          color: kGray,
          fontSize: 15,
        ),
      ),
    ],
  ));
}

Row buildButtons(BuildContext context, PropertyOwnerMyPropertyViewModel model) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      FlatButton(
        child: Text(
          'Back',
          style: AppStyle.kBodyRegularBlack14W500,
        ),
        color: kWhite,
        textColor: kBlack,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      Spacer(),
      FlatButton(
        child: Text(
          'Next',
          style: AppStyle.kBodyRegular,
        ),
        color: kPrimaryColor,
        textColor: Colors.white,
        onPressed: () {},

        // },
      ),
    ],
  );
}
