// ignore_for_file: deprecated_member_use

import 'package:country_picker/country_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';

import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textspan.dart';
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
                    style: AppStyle.kBodyRegularBlack14W500,
                  ),
                  verticalSpaceRegular,
                  Text(
                    'Property Name',
                    style: AppStyle.kBodySmallRegular12W500,
                  ),
                  verticalSpaceTiny,
                  ResavationTextField(
                    hintText: '',
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

                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                          border:  Border.all(color: kBlack54, width: 1.0)
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 42,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(model.selectedCountry),
                            Icon(Icons.keyboard_arrow_down_sharp)
                          ],
                        ),
                      )
                    ),
                    onTap: (){
                      showCountryPicker(
                        context: context,
                        showPhoneCode: true, // optional. Shows phone code before the country name.
                        onSelect: (Country country) {
                          model.onSelectCountryTap(country);
                        },
                      );
                    },
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
                    'Generate your address on Google map',
                    style: AppStyle.kBodySmallRegular12W500,
                  ),
                  ResavationElevatedButton(
                    child: Text("Go to Map"),
                    onPressed: (){
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
                  onPressed: ()=> Navigator.pop(context),

                ),
                ResavationElevatedButton(
                  child: Text("Next"),
                  onPressed: ()=> model.goToPropertyOwnerAddPhotosView(),

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
