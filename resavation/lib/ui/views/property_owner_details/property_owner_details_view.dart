// ignore_for_file: deprecated_member_use

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/dump_widgets/select_country.dart';
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
          backgroundColor: Colors.white,
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
                    style: AppStyle.kHeading0,
                  ),
                  verticalSpaceRegular,
                  Text(
                    'Property Name',
                    style: AppStyle.kBodySmallRegular12W500,
                  ),
                  verticalSpaceTiny,
                  ResavationTextField(
                    hintText: '',
                    fillColors: Colors.white,
                  ),
                  Text(
                    'Property Description',
                    style: AppStyle.kBodySmallRegular12W500,
                  ),
                  verticalSpaceTiny,
                  _buildTextField(''),
                  Text(
                    'Location',
                    style: AppStyle.kBodySmallRegular12W500,
                  ),
                  verticalSpaceTiny,
                  SelectCountry(
                    label: model.selectedCountry,
                    onSelected: model.onSelectCountryTap(Country.worldWide),
                  ),
                  verticalSpaceTiny,
                  ResavationTextField(
                    hintText: 'State',
                    fillColors: Colors.white,
                  ),
                  verticalSpaceTiny,
                  ResavationTextField(
                    hintText: 'City',
                    fillColors: Colors.white,
                  ),
                  verticalSpaceTiny,
                  ResavationTextField(
                    hintText: 'Enter the address of this space',
                    fillColors: Colors.white,
                  ),
                  Text(
                    'Generate your address on Google map',
                    style: AppStyle.kBodySmallRegular12W500,
                  ),
                  ResavationElevatedButton(
                    child: Text("Go to Map"),
                    onPressed: () {
                      model.goToMapView();
                    },
                  ),
                  verticalSpaceLarge,
                ],
              ),
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
                  onPressed: () => model.goToPropertyOwnerAddPhotosView(),
                )
              ],
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
