// ignore_for_file: deprecated_member_use

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/dump_widgets/select_country.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_details/property_owner_details_viewmodel.dart';
import 'package:resavation/ui/views/property_owner_spaceType/property_owner_spacetype_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PropertyOwnerDetailsView extends StatefulWidget {
  const PropertyOwnerDetailsView({
    Key? key,
    required PropertyOwnerUploadModel propertyOwnerUploadModel,
  }) : super(key: key);

  @override
  State<PropertyOwnerDetailsView> createState() =>
      _PropertyOwnerDetailsViewState();
}

class _PropertyOwnerDetailsViewState extends State<PropertyOwnerDetailsView> {
  final uploadFormKey = GlobalKey<FormState>();
  final PropertyOwnerUploadModel propertyOwnerUploadModel =
      PropertyOwnerUploadModel();

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
              child: Form(
                key: uploadFormKey,
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
                      textInputAction: TextInputAction.next,
                      controller: model.propertyNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter property name';
                        }
                        return null;
                      },
                    ),
                    Text(
                      'Property Description',
                      style: AppStyle.kBodySmallRegular12W500,
                    ),
                    verticalSpaceTiny,
                    ResavationTextField(
                      hintText: '',
                      fillColors: Colors.white,
                      maxline: 5,
                      textInputAction: TextInputAction.next,
                      controller: model.propertyDescriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter property description';
                        }
                        return null;
                      },
                    ),
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
                    Text(
                      'State',
                      style: AppStyle.kBodySmallRegular12W500,
                    ),
                    verticalSpaceTiny,
                    ResavationTextField(
                      hintText: 'State',
                      fillColors: Colors.white,
                      textInputAction: TextInputAction.next,
                      controller: model.propertyStateController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter state';
                        }
                        return null;
                      },
                    ),
                    verticalSpaceTiny,
                    Text(
                      'City',
                      style: AppStyle.kBodySmallRegular12W500,
                    ),
                    verticalSpaceTiny,
                    ResavationTextField(
                      hintText: 'City',
                      fillColors: Colors.white,
                      textInputAction: TextInputAction.next,
                      controller: model.propertyCityController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter city';
                        }
                        return null;
                      },
                    ),
                    verticalSpaceTiny,
                    Text(
                      'Address',
                      style: AppStyle.kBodySmallRegular12W500,
                    ),
                    verticalSpaceTiny,
                    ResavationTextField(
                      hintText: 'Enter the address of this space',
                      fillColors: Colors.white,
                      textInputAction: TextInputAction.next,
                      controller: model.propertyAddressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter property address';
                        }
                        return null;
                      },
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
                    onPressed: () async {
                      if (uploadFormKey.currentState!.validate()) {
                        print(model.propertyNameController.text);

                        model.goToPropertyOwnerAddPhotosView();
                      } else {
                        // model.upoloadPropertyToServer();
                      }
                    }
                    //=> model.goToPropertyOwnerAddPhotosView(),
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
