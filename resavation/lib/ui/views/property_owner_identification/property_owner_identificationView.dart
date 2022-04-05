// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
//import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_details/property_owner_details_viewmodel.dart';
import 'package:resavation/ui/views/property_owner_identification/property_owner_identificationViewModel.dart';
import 'package:country_picker/country_picker.dart';

import 'package:stacked/stacked.dart';

class PropertyOwnerIdentificationView extends StatelessWidget {
  const PropertyOwnerIdentificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerIdentificationViewModel>.reactive(
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
                Center(
                  child: Text(
                    'Identification',
                    style: AppStyle.kBodyRegularBlack14W500,
                  ),
                ),
                verticalSpaceMedium,
                Text(
                  'Personal Details',
                  style: AppStyle.kBodyRegularBlack14W500,
                ),
                verticalSpaceSmall,
                Text(
                  'Complete your personal information',
                  style: AppStyle.kBodySmallRegular12W500,
                ),
                verticalSpaceTiny,
                ResavationTextField(
                  hintText: 'First Name',
                ),
                verticalSpaceTiny,
                ResavationTextField(
                  hintText: 'Last Name',
                ),
                verticalSpaceTiny,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Date of Birth',
                      style: AppStyle.kBodySmallRegular12,
                    ),
                  ],
                ),
                verticalSpaceTiny,
                Row(
                  children: [
                    _buildTextField(''),
                    horizontalSpaceMedium,
                    _buildTextFieldDay(''),
                    horizontalSpaceTiny,
                    _buildTextFieldMonth(''),
                    horizontalSpaceTiny,
                    _buildTextFieldYear(''),
                  ],
                ),
                verticalSpaceTiny,
                Text(
                  'Complete your address',
                  style: AppStyle.kBodyRegular,
                ),
                verticalSpaceTiny,
                ResavationTextField(
                  hintText: 'Country',
                ),
                verticalSpaceTiny,
                ResavationTextField(
                  hintText: 'State',
                ),
                verticalSpaceTiny,
                ResavationTextField(
                  hintText: 'City',
                ),
                verticalSpaceTiny,
                ResavationTextField(
                  hintText: 'Enter the address of the space',
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
      viewModelBuilder: () => PropertyOwnerIdentificationViewModel(),
    );
  }
}

Widget _buildTextField(String label) {
  String? label;
  const maxLines = 5;
  return Container(
    width: 100,
    height: maxLines * 8.0,
    child: const TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: ("Gender"),
        isDense: true, // Added this
        //contentPadding: EdgeInsets.all(8), // Added this
      ),
    ),
  );
}

Widget _buildTextFieldDay(String label) {
  String? label;
  const maxLines = 5;
  return Container(
    width: 60,
    height: maxLines * 8.0,
    child: const TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: ("DD"),
        isDense: true, // Added this
        //contentPadding: EdgeInsets.all(8), // Added this
      ),
    ),
  );
}

Widget _buildTextFieldMonth(String label) {
  String? label;
  const maxLines = 5;
  return Container(
    width: 60,
    height: maxLines * 8.0,
    child: const TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: ("MM"),
        isDense: true, // Added this
        //contentPadding: EdgeInsets.all(8), // Added this
      ),
    ),
  );
}

Widget _buildTextFieldYear(String label) {
  String? label;
  const maxLines = 5;
  return Container(
    width: 80,
    height: maxLines * 8.0,
    child: const TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: ("YYYY"),
        isDense: true, // Added this
        //contentPadding: EdgeInsets.all(8), // Added this
      ),
    ),
  );
}
