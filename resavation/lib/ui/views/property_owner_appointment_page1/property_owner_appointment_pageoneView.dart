// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_appointment_page1/property_owner_appointment_pageoneViewModel.dart';

import 'package:stacked/stacked.dart';

class PropertyOwnerAppointmentPageoneView extends StatelessWidget {
  const PropertyOwnerAppointmentPageoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerAppointmentPageoneViewModel>.reactive(
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
                  'Property',
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
                    model.goToPropertyOwnerHomePageView();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerAppointmentPageoneViewModel(),
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
          style: TextStyle(color: kGray),
        ),
        Text(
          "Choose Document",
          style: AppStyle.kBodyBold,
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
          style: TextStyle(color: kGray),
        ),
        Text(
          "Take a Selfe",
          style: AppStyle.kBodyBold,
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
        style: AppStyle.kBodyRegular,
      ),
    ),
  );
}
