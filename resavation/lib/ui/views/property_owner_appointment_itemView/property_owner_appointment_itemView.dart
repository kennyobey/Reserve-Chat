// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_appointment_itemView/property_owner_appointment_itemViewModel.dart';

import 'package:resavation/utility/assets.dart';

import 'package:stacked/stacked.dart';

class PropertyOwnerAppointmentItemView extends StatelessWidget {
  const PropertyOwnerAppointmentItemView({Key? key, required String pageName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerAppointmentItemViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpaceMedium,
                      _blackcontainer(""),
                      verticalSpaceMedium,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerAppointmentItemViewModel(),
    );
  }
}

Widget _blackcontainer(String label) {
  //const maxLines = 5;
  var model;
  var image;
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      border: Border.all(color: kGray),
      borderRadius: new BorderRadius.circular(5.0),
      //color: kBlack,
    ),
    width: 345,
    height: 150.0,
    child: Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6), //or 15.0
              child: Image.asset(
                Assets.profile_image4,
                width: 60,
                height: 60,
              ),
            ),
          ),
          // ResavationImage(
          //   image: image,
          // ),
          // Icon(Icons.receipt_sharp, size: 100, color: Colors.black),
          Spacer(),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Adeyemo Stephen',
              style: AppStyle.kBodyRegular,
            ),
            Text(
              'No 1, Eleko Estate .....',
              style: AppStyle.kBodyRegular.copyWith(color: kGray),
            ),
            Text(
              'Inspection: Virtual',
              style: AppStyle.kBodyRegular,
            ),
            FlatButton(
              height: 5,
              child: Text(
                'Next',
                style: AppStyle.kBodyRegular,
              ),
              color: kPrimaryColor,
              textColor: Colors.white,
              onPressed: () {},
            ),
          ])
        ],
      ),
    ),
  );
}
