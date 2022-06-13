// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';

import 'package:resavation/ui/views/property_owner_verification/property_owner_verificationViewModel.dart';

import 'package:stacked/stacked.dart';

import '../../shared/dump_widgets/resavation_app_bar.dart';

class PropertyOwnerVerificationView extends StatefulWidget {
  const PropertyOwnerVerificationView({Key? key}) : super(key: key);

  @override
  State<PropertyOwnerVerificationView> createState() =>
      _PropertyOwnerVerificationViewState();
}

class _PropertyOwnerVerificationViewState
    extends State<PropertyOwnerVerificationView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerVerificationViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: ResavationAppBar(
          title: "Identity Verification",
          centerTitle: false,
          backEnabled: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Submit Documents',
                style: AppStyle.kBodyRegularBlack16W600,
              ),
              verticalSpaceTiny,
              Text(
                'Kindly Submit the documents below to process your application',
                style: AppStyle.kBodyRegularBlack14,
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
              SizedBox(
                width: double.infinity,
                child: ResavationElevatedButton(
                  child: Text('Continue'),
                  onPressed: () {
                    model.goToPropertyOwnerMainView();
                  },
                ),
              ),
              verticalSpaceMedium,
            ],
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerVerificationViewModel(),
    );
  }
}

Widget _buildTextField(String label) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
        border: Border.all(color: kGray),
        borderRadius: BorderRadius.circular(5)),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Step 1",
          style: AppStyle.kBodySmallRegular12,
        ),
        Text(
          "Choose Document",
          style: AppStyle.kBodyRegularBlack14W500,
        ),
      ],
    ),
  );
}

Widget _buildTextField2(String label) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
        border: Border.all(color: kGray),
        borderRadius: BorderRadius.circular(5)),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Step 2",
          style: AppStyle.kBodySmallRegular12,
        ),
        Text(
          "Take a Selfie",
          style: AppStyle.kBodyRegularBlack14W500,
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
