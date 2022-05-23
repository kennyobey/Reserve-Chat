// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_verification/property_verificationViewModel.dart';

import 'package:stacked/stacked.dart';

import '../property_owner_spaceType/property_owner_spacetype_viewmodel.dart';

class PropertyVerificationView extends StatefulWidget {
  const PropertyVerificationView({Key? key}) : super(key: key);

  @override
  State<PropertyVerificationView> createState() =>
      _PropertyVerificationViewState();
}

class _PropertyVerificationViewState extends State<PropertyVerificationView> {
  final PropertyOwnerUploadModel propertyOwnerUploadModel =
      PropertyOwnerUploadModel();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyVerificationViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceMedium,
                Text(
                  'Identity',
                  style: AppStyle.kBodyBold,
                ),
                Text(
                  ' Verification',
                  style: AppStyle.kBodyBold,
                ),
                verticalSpaceMedium,
                Text(
                  'Submit Documents',
                  style: AppStyle.kBodyRegular,
                ),
                verticalSpaceMedium,
                Text(
                  'Kindly Submit the documents below to process your application',
                  style: AppStyle.kBodySmallRegular,
                ),
                verticalSpaceMedium,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selected ID Number',
                      style: AppStyle.kBodyRegular,
                    ),
                    verticalSpaceSmall,
                    _buildTextField(''),
                    verticalSpaceMedium,
                    Text(
                      'Upload Document',
                      style: AppStyle.kBodyRegular,
                    ),
                    verticalSpaceSmall,
                    _buildTextField2(''),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    ResavationButton(
                      buttonColor: kWhite,
                      width: 145,
                      height: 47,
                      title: 'Back',
                      titleColor: kBlack,
                      onTap: () {
                        model.goToPropertyOwnerHomePageView();
                      },
                    ),
                    Spacer(),
                    ResavationButton(
                      width: 145,
                      height: 47,
                      title: 'Continue',
                      onTap: () {
                        model.goToPropertyOwnerHomePageView();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PropertyVerificationViewModel(),
    );
  }
}

Widget _buildTextField(String label) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
        border: Border.all(color: kGray),
        borderRadius: BorderRadius.circular(4)),
    width: 341,
    height: 45,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "A124525BH",
          style: AppStyle.kBodySmallRegular,
        ),
      ],
    ),
  );
}

Widget _buildTextField2(String label) {
  ;
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
        border: Border.all(color: kGray),
        borderRadius: BorderRadius.circular(3)),
    width: 360,
    height: 52,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: kGray),
              color: kBlack,
              borderRadius: BorderRadius.circular(3)),
          height: 30,
          width: 98,
          child: FlatButton(
            child: Text(
              'Choose file',
              style: AppStyle.kBodySmallRegular11W300.copyWith(color: kWhite),
            ),
            color: kChatTextColor,
            textColor: kBlack,
            onPressed: () {},
          ),
        ),
      ],
    ),
  );
}
