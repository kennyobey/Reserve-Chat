import 'package:flutter/material.dart';

import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';

import 'package:resavation/ui/views/property_owner_step2/property_owner_step_1_3_viewmodel.dart';

import 'package:stacked/stacked.dart';

class PropertyOwnerStep_1_3View extends StatelessWidget {
  const PropertyOwnerStep_1_3View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerStep_1_3ViewModel>.reactive(
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
                    style: AppStyle.kBodyRegular,
                  ),
                  verticalSpaceRegular,
                  Text(
                    'Property Name',
                    style: AppStyle.kBodyRegular,
                  ),
                  verticalSpaceTiny,
                  ResavationTextField(
                    hintText: '',
                  ),
                  Text(
                    'property Description',
                    style: AppStyle.kBodyRegular,
                  ),
                  _buildTextField(''),
                  Text(
                    'Location',
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
                    hintText: 'Enter the address of this space',
                  ),
                  Text(
                    'Generate your address on google map',
                    style: AppStyle.kBodyRegular,
                  ),
                  _buildTextField("Click to generate map")
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerStep_1_3ViewModel(),
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
