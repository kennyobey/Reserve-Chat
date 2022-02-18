// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';

import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_details/property_owner_details_viewmodel.dart';
import 'package:resavation/ui/views/property_owner_identification/property_owner_identificationViewModel.dart';

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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Identification',
                      style: AppStyle.kBodyBold,
                    ),
                  ),
                  verticalSpaceMedium,
                  Text(
                    'Personal Details',
                    style: AppStyle.kBodyBold,
                  ),
                  verticalSpaceSmall,
                  Text(
                    'Complete your personal information',
                    style: AppStyle.kBodyBold,
                  ),
                  verticalSpaceTiny,
                  ResavationTextField(
                    hintText: 'First Name',
                  ),
                  verticalSpaceTiny,
                  ResavationTextField(
                    hintText: 'Last Name',
                  ),
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
                  Text(
                    'Avalability Period',
                    style: AppStyle.kBodyBold,
                  ),
                  verticalSpaceTiny,
                  Row(
                    children: [
                      _buildTextField(''),
                      Spacer(),
                      _buildTextField(''),
                    ],
                  ),
                  verticalSpaceTiny,
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
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
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
    width: 140,
    height: maxLines * 12.0,
    child: const TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: ("From"),
        isDense: true, // Added this
        //contentPadding: EdgeInsets.all(8), // Added this
      ),
    ),
  );
}
