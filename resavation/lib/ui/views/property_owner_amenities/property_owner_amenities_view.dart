// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_amenities/property_owner_amenities_viewModel.dart';
import 'package:stacked/stacked.dart';

class PropertyOwnerAmenitiesView extends StatelessWidget {
  PropertyOwnerAmenitiesView({Key? key}) : super(key: key);

  MaterialPropertyResolver<Color?>? get getColor => null;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerAmenitiesViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Amenities and House Rules',
                    style: AppStyle.kBodyBold,
                  ),
                ),
                verticalSpaceMedium,
                Text(
                  'Amenities',
                  style: AppStyle.kBodyBold,
                ),
                verticalSpaceTiny,
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              value: model.checkValue1,
                              onChanged: model.onCheckChanged1,
                            ),
                            Text(
                              "Wifi",
                              style: AppStyle.kBodySmallRegular,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              value: model.checkValue2,
                              onChanged: model.onCheckChanged2,
                            ),
                            Text(
                              "Washing Machine",
                              style: AppStyle.kBodySmallRegular,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              value: model.checkValue3,
                              onChanged: model.onCheckChanged3,
                            ),
                            Text(
                              "Air Conditioning",
                              style: AppStyle.kBodySmallRegular,
                            ),
                          ],
                        ),
                      ],
                    ),
                    horizontalSpaceRegular,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              value: model.checkValue4,
                              onChanged: model.onCheckChanged4,
                            ),
                            Text(
                              "TV",
                              style: AppStyle.kBodySmallRegular,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              value: model.checkValue5,
                              onChanged: model.onCheckChanged5,
                            ),
                            Text(
                              "Hair Dryer",
                              style: AppStyle.kBodySmallRegular,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              value: model.checkValue6,
                              onChanged: model.onCheckChanged6,
                            ),
                            Text(
                              "Fire Alarm",
                              style: AppStyle.kBodySmallRegular,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  'House Rule',
                  style: AppStyle.kBodyBold,
                ),
                verticalSpaceTiny,
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              value: model.checkValue7,
                              onChanged: model.onCheckChanged7,
                            ),
                            Text(
                              "No Smoking",
                              style: AppStyle.kBodySmallRegular,
                            ),
                            horizontalSpaceLarge,
                            Checkbox(
                              checkColor: Colors.white,
                              value: model.checkValue8,
                              onChanged: model.onCheckChanged8,
                            ),
                            Text(
                              "No Pet",
                              style: AppStyle.kBodySmallRegular,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              value: model.checkValue9,
                              onChanged: model.onCheckChanged9,
                            ),
                            Text(
                              "No House party",
                              style: AppStyle.kBodySmallRegular,
                            ),
                          ],
                        ),
                      ],
                    ),
                    horizontalSpaceRegular,
                  ],
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
                        model.goToPropertyOwnerIdentificationView();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerAmenitiesViewModel(),
    );
  }
}
