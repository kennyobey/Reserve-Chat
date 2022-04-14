// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';
//import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/dump_widgets/select_country.dart';
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
                verticalSpaceMedium,
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
                    Expanded(child: _buildTextFieldDay('')),
                    horizontalSpaceTiny,
                    Expanded(child: _buildTextFieldMonth('')),
                    horizontalSpaceTiny,
                    Expanded(child: _buildTextFieldYear('')),
                  ],
                ),
                verticalSpaceSmall,
                Text(
                  'Complete your address',
                  style: AppStyle.kBodyRegular,
                ),
                verticalSpaceTiny,
                SelectCountry(
                  label: model.selectedCountry,
                  onSelected: model.onSelectCountryTap(Country.worldWide),
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
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ResavationElevatedButton(
                  child: Text("Back"),
                  onPressed: () => Navigator.pop(context),
                ),
                ResavationElevatedButton(
                  child: Text("Next"),
                  onPressed: () => model.goToPropertyOwnerVerificationView(),
                )
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
