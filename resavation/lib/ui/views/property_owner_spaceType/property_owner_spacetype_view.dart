// ignore_for_file: deprecated_member_use

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_radio_button.dart';

import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_spaceType/property_owner_spacetype_viewmodel.dart';

import 'package:stacked/stacked.dart';

class PropertyOwnerSpaceTypeView extends StatelessWidget {
  PropertyOwnerSpaceTypeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerSpaceTypeViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 15,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Space Type',
                      style: AppStyle.kHeading4,
                    ),
                  ),
                  verticalSpaceMedium,
                  Text(
                    'Tell us about your property',
                    style: AppStyle.kBodyRegular,
                  ),
                  verticalSpaceMedium,
                  Text(
                    'Narrow down your space type',
                    style: AppStyle.kBodyRegular,
                  ),
                  verticalSpaceMedium,
                  Text(
                    'Is your space serviced',
                    style: AppStyle.kBodyRegular,
                  ),

                  // is your space serviced Yes/No
                  ResavationRadioButton(
                    title: 'Yes',
                    radioValue: "Yes",
                    groupValue: model.isServiced,
                    onChanged: (String? radioValue) {
                      model.onSpaceServicedRadioChange(radioValue.toString());
                    },
                  ),
                  ResavationRadioButton(
                    title: 'No',
                    radioValue: "No",
                    groupValue: model.isServiced,
                    onChanged: (String? radioValue) {
                      model.onSpaceServicedRadioChange(radioValue.toString());
                    },
                  ),
                  verticalSpaceSmall,
                  Text(
                    'Is your space furnished',
                    style: AppStyle.kBodyRegular,
                  ),

                  // Is your space furnished Yes/No
                  ResavationRadioButton(
                    title: 'Yes',
                    radioValue: "Yes",
                    groupValue: model.isFurnished,
                    onChanged: (String? radioValue) {
                      model.onSpaceFurnishedRadioChange(radioValue.toString());
                    },
                  ),
                  ResavationRadioButton(
                    title: 'No',
                    radioValue: "No",
                    groupValue: model.isFurnished,
                    onChanged: (String? radioValue) {
                      model.onSpaceFurnishedRadioChange(radioValue.toString());
                    },
                  ),
                  verticalSpaceSmall,
                  Text(
                    'Listing Options',
                    style: AppStyle.kBodyRegular,
                  ),
                  verticalSpaceTiny,
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                        hint: Text(
                          "Select Property ",
                          style: AppStyle.kBodyRegular,
                        ),
                        items: model.items
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: AppStyle.kBodyRegular,
                                  ),
                                ))
                            .toList(),
                        value: model.selectedValue,
                        onChanged: (value) {
                          model.onSelectedValueChange(value);
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                        ),
                        buttonWidth: 330,
                        buttonPadding: EdgeInsets.only(left: 18, right: 20),
                        buttonDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                        )),
                  ),
                  verticalSpaceSmall,
                  Text(
                    'Do you leave in this space',
                    style: AppStyle.kBodyRegular,
                  ),

                  // do you leave in this space Yes/No
                  ResavationRadioButton(
                    title: 'Yes',
                    radioValue: "Yes",
                    groupValue: model.leaveHere,
                    onChanged: (String? radioValue) {
                      model.onLeaveHereRadioChange(radioValue.toString());
                    },
                  ),
                  verticalSpaceSmall,
                  ResavationRadioButton(
                    title: 'No',
                    radioValue: "No",
                    groupValue: model.leaveHere,
                    onChanged: (String? radioValue) {
                      model.onLeaveHereRadioChange(radioValue.toString());
                    },
                  ),
                  verticalSpaceSmall,
                  //Select the number of bedrooms
                  AmenitiesSelection(
                    title: "Number Of bedrooms",
                    value: model.numberOfBedrooms,
                    onPositiveTap: () => model.onPositiveBedRoomTap(),
                    onNegativeTap: () => model.onNegativeBedRoomTap(),
                  ),
                  verticalSpaceSmall,
                  //Select the number of bathrooms
                  AmenitiesSelection(
                    title: "Number of bathrooms",
                    value: model.numberOfBathrooms,
                    onPositiveTap: () => model.onPositiveBathRoomTap(),
                    onNegativeTap: () => model.onNegativeBathRoomTap(),
                  ),
                  verticalSpaceSmall,
                  //Select the number of car slots
                  AmenitiesSelection(
                    title: "Number of car slots",
                    value: model.numberOfCarSlot,
                    onPositiveTap: () => model.onPositiveCarSlotTap(),
                    onNegativeTap: () => model.onNegativeCarSlotTap(),
                  ),
                  verticalSpaceLarge,

                  Row(
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
                        onPressed: () {
                          model.goToPropertyOwnerDetailsView();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // bottomSheet: Row(
          //   children: [
          //     ResavationButton(
          //       buttonColor: kWhite,
          //       width: 50,
          //       height: 47,
          //       title: 'Back',
          //       titleColor: kBlack,
          //       onTap: () {
          //         model.goToPropertyOwnerHomePageView();
          //       },
          //     ),
          //     Spacer(),
          //     ResavationButton(
          //       width: 50,
          //       height: 47,
          //       title: 'Continue',
          //       onTap: () {
          //         model.goToPropertyOwnerDetailsView();
          //       },
          //     ),
          //   ],
          // ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerSpaceTypeViewModel(),
    );
  }
}

class AmenitiesSelection extends StatelessWidget {
  const AmenitiesSelection(
      {Key? key,
      this.title,
      this.onNegativeTap,
      this.onPositiveTap,
      this.value})
      : super(key: key);
  final String? title;
  final int? value;
  final Function()? onNegativeTap;
  final Function()? onPositiveTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title!,
          style: AppStyle.kBodySmallRegular12,
        ),
        Row(
          children: [
            IncrementAmenities(
              icon: Icons.remove,
              onTap: onNegativeTap,
            ),
            Text(value.toString()),
            IncrementAmenities(
              icon: Icons.add,
              onTap: onPositiveTap,
            ),
          ],
        )
      ],
    );
  }
}

// widget used to increase/decrease the amenities value
class IncrementAmenities extends StatelessWidget {
  const IncrementAmenities({Key? key, this.icon, this.onTap}) : super(key: key);

  final IconData? icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: kGray),
              borderRadius: BorderRadius.circular(10.0)),
          child: Icon(
            icon,
            color: kGray,
            size: 12,
          ),
        ),
      ),
    );
  }
}
