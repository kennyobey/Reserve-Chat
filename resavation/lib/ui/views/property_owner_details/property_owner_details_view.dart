// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';

import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_details/property_owner_details_viewmodel.dart';

import 'package:stacked/stacked.dart';

class PropertyOwnerDetailsView extends StatelessWidget {
  const PropertyOwnerDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerDetailsViewModel>.reactive(
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
                  verticalSpaceMedium,
                  Text(
                    'Details',
                    style: AppStyle.kBodyBold,
                  ),
                  verticalSpaceRegular,
                  Text(
                    'Property Name',
                    style: AppStyle.kBodyBold,
                  ),
                  verticalSpaceTiny,
                  ResavationTextField(
                    hintText: '',
                  ),
                  Text(
                    'property Description',
                    style: AppStyle.kBodyBold,
                  ),
                  _buildTextField(''),
                  Text(
                    'Location',
                    style: AppStyle.kBodyBold,
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
                    hintText: 'Enter the address of this space',
                  ),
                  Text(
                    'Generate your address on google map',
                    style: AppStyle.kBodyRegular,
                  ),
                  _buildTextField("Click to generate map"),
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
                          model.goToPropertyOwnerPaymentView();
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
      viewModelBuilder: () => PropertyOwnerDetailsViewModel(),
    );
  }
}

Widget _buildTextField(String label) {
  const maxLines = 5;
  return Container(
    // margin: const EdgeInsets.symmetric(vertical: 0),
    height: maxLines * 30.0,
    child: const TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "",
        isDense: true, // Added this
        //contentPadding: EdgeInsets.all(8), // Added this
      ),
    ),
  );
}
