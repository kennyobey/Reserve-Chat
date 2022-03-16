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
                  'Your Appointment',
                  style: AppStyle.kBodyBold,
                ),
                verticalSpaceMedium,
                Row(
                  children: [
                    _Upcoming(""),
                  ],
                ),
                verticalSpaceMedium,
                Column(
                  children: [
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
    decoration: BoxDecoration(
      border: Border.all(color: kGray),
    ),
    width: 60,
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
          "Take a Selfe",
          style: AppStyle.kBodyBold,
        ),
      ],
    ),
  );
}

Widget _Upcoming(String label) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
        border: Border.all(color: kGray),
        borderRadius: BorderRadius.all(Radius.circular(5))),
    width: 340,
    height: 70.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Center(child: Text("Hello")),
        ),
        Spacer(),
        Container(
          width: 130,
          height: 70,
          color: kBlack,
          child: Center(
            child: Text(
              "Hello",
              style: TextStyle(color: kWhite),
            ),
          ),
        ),
      ],
    ),
  );
}
