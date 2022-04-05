// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';

import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_spaceType/property_owner_spacetype_viewmodel.dart';

import 'package:stacked/stacked.dart';

class PropertyOwnerSpaceTypeView extends StatelessWidget {
  PropertyOwnerSpaceTypeView({Key? key}) : super(key: key);

  get _radioValue1 => 1;

  get _handleRadioValueChange1 => null;

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
                      style: AppStyle.kHeading1,
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
                  Row(
                    children: [
                      Text(
                        'Yes',
                        style: AppStyle.kBodyRegular,
                      ),
                      Spacer(),
                      Radio(
                        value: "Serviced Yes",
                        groupValue: model.IsServiced,
                        onChanged: (value) {
                          model.onRadioChanged(value.toString());
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'No',
                        style: AppStyle.kBodyRegular,
                      ),
                      Spacer(),
                      Radio(
                        value: "No Serviced",
                        groupValue: model.IsServiced,
                        onChanged: (value) {
                          model.onRadioChanged(value.toString());
                        },
                      ),
                    ],
                  ),
                  verticalSpaceSmall,
                  Text(
                    'Is your space furnished',
                    style: AppStyle.kBodyRegular,
                  ),
                  Row(
                    children: [
                      Text(
                        'Yes',
                        style: AppStyle.kBodyRegular,
                      ),
                      Spacer(),
                      Radio(
                        value: "Furnished Yes",
                        groupValue: model.IsFurnished,
                        onChanged: (value) {
                          model.onRadioChanged2(value.toString());
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'No',
                        style: AppStyle.kBodyRegular,
                      ),
                      Spacer(),
                      Radio(
                        value: "Furnished No",
                        groupValue: model.IsFurnished,
                        onChanged: (value) {
                          model.onRadioChanged2(value.toString());
                        },
                      ),
                    ],
                  ),
                  verticalSpaceSmall,
                  Text(
                    'Listing Options',
                    style: AppStyle.kBodyRegular,
                  ),
                  verticalSpaceTiny,

                  verticalSpaceTiny,
                  ResavationTextField(
                    hintText: 'Choose your listing option',
                  ),
                  Text(
                    'Do you leave in this space',
                    style: AppStyle.kBodyRegular,
                  ),
                  Row(
                    children: [
                      Text(
                        'Yes',
                        style: AppStyle.kBodyRegular,
                      ),
                      Spacer(),
                      Radio(
                        value: "Property Owner Live in the space Yes",
                        groupValue: model.IsLiveSpace,
                        onChanged: (value) {
                          model.onRadioChanged3(value.toString());
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'No',
                        style: AppStyle.kBodyRegular,
                      ),
                      Spacer(),
                      Radio(
                        value: "Property Owner Live in the space No",
                        groupValue: model.IsLiveSpace,
                        onChanged: (value) {
                          model.onRadioChanged3(value.toString());
                        },
                      ),
                    ],
                  ),
                  verticalSpaceMedium,

                  //Number of Bathroom and Bedroom
                  Row(
                    children: [
                      Text(
                        'Number of Bedrooms',
                        style: AppStyle.kBodyRegular,
                      ),
                      Spacer(),
                      Icon(
                        Icons.exposure_minus_1,
                        color: kGray,
                        size: 20.0,
                      ),
                      Text(
                        '0',
                        style: AppStyle.kBodyRegular,
                      ),
                      Icon(
                        Icons.exposure_minus_1,
                        color: kGray,
                        size: 20.0,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Number of Bathrooms',
                        style: AppStyle.kBodyRegular,
                      ),
                      Spacer(),
                      Icon(
                        Icons.exposure_minus_1,
                        color: kGray,
                        size: 20.0,
                      ),
                      Text(
                        '0',
                        style: AppStyle.kBodyRegular,
                      ),
                      Icon(
                        Icons.exposure_minus_1,
                        color: kGray,
                        size: 20.0,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Number of Car park Slot',
                        style: AppStyle.kBodyRegular,
                      ),
                      Spacer(),
                      Icon(
                        Icons.exposure_minus_1,
                        color: kGray,
                        size: 20.0,
                      ),
                      Text(
                        '0',
                        style: AppStyle.kBodyRegular,
                      ),
                      Icon(
                        Icons.exposure_minus_1,
                        color: kGray,
                        size: 20.0,
                      ),
                    ],
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
        ),
      ),
      viewModelBuilder: () => PropertyOwnerSpaceTypeViewModel(),
    );
  }
}
