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
                        value: 1,
                        groupValue: _radioValue1,
                        onChanged: _handleRadioValueChange1,
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
                        value: 2,
                        groupValue: _radioValue1,
                        onChanged: _handleRadioValueChange1,
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
                        value: 3,
                        groupValue: _radioValue1,
                        onChanged: _handleRadioValueChange1,
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
                        value: 4,
                        groupValue: _radioValue1,
                        onChanged: _handleRadioValueChange1,
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
                        value: 5,
                        groupValue: _radioValue1,
                        onChanged: _handleRadioValueChange1,
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
                        value: 6,
                        groupValue: _radioValue1,
                        onChanged: _handleRadioValueChange1,
                      ),
                    ],
                  ),

                  //Number of Bathroom and Bedroom
                  SwitchListTile(
                    value: model.notificationSwitchValue,
                    onChanged: model.onNotificationSwitchChanged,
                    title: Text(
                      'Number of Bathrooms',
                      style: AppStyle.kBodyRegular,
                    ),
                  ),
                  SwitchListTile(
                    value: model.appNotificationSwitchValue,
                    onChanged: model.onAppNotificationSwitchValue,
                    title: Text(
                      'Number of Bedrooms',
                      style: AppStyle.kBodyRegular,
                    ),
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
                          model.goToPropertyOwnerVerificationView();
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
