// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';

import 'package:resavation/ui/views/property_owner_verification/property_owner_verificationViewModel.dart';

import 'package:stacked/stacked.dart';

class PropertyOwnerVerificationView extends StatelessWidget {
  const PropertyOwnerVerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerVerificationViewModel>.reactive(
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
                  style: AppStyle.kBodyRegularW500,
                ),
                Text(
                  'Verification',
                  style: AppStyle.kBodyRegularW500,
                ),
                verticalSpaceMedium,
                Text(
                  'Submit Documents',
                  style: AppStyle.kBodyRegularBlack14W500,
                ),
                verticalSpaceMedium,
                Text(
                  'Kindly Submit the documents below to process your application',
                  style: AppStyle.kBodySmallRegular12,
                ),
                verticalSpaceMedium,
                Column(
                  children: [
                    _buildTextField(''),
                    verticalSpaceMedium,
                    _buildTextField2(''),
                  ],
                ),
                Spacer(),
                ResavationButton(
                  width: MediaQuery.of(context).size.width,
                  title: 'Continue',
                  onTap: () {
                    model.goToPropertyOwnerMainView();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerVerificationViewModel(),
    );
  }
}

Widget _buildTextField(String label) {
  const maxLines = 5;
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(border: Border.all(color: kGray)),
    width: 360,
    height: maxLines * 14.0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Step 1",
          style:  AppStyle.kBodySmallRegular12.copyWith(color: kGray),
        ),
        Text(
          "Choose Document",
          style: AppStyle.kBodySmallRegular12W500,
        ),
      ],
    ),
  );
}

Widget _buildTextField2(String label) {
  const maxLines = 5;
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(border: Border.all(color: kGray)),
    width: 360,
    height: maxLines * 14.0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Step 2",
          style: AppStyle.kBodySmallRegular12.copyWith(color: kGray),
        ),
        Text(
          "Take a Selfie",
          style: AppStyle.kBodySmallRegular12W500,
        ),
      ],
    ),
  );
}

Widget _buildmaterial() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: kPrimaryColor,
        onPrimary: Colors.white,
        shadowColor: Colors.greenAccent,
        elevation: 0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        minimumSize: Size(100, 40), //////// HERE
      ),
      onPressed: () {},
      child: Text(
        'Continue',
        style: AppStyle.kBodyRegularBlack14W500,
      ),
    ),
  );
}
