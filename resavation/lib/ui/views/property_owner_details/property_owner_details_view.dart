// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/dump_widgets/select_country.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_details/property_owner_details_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../shared/dump_widgets/resavation_app_bar.dart';

class PropertyOwnerDetailsView extends StatefulWidget {
  const PropertyOwnerDetailsView({
    Key? key,
  }) : super(key: key);

  @override
  State<PropertyOwnerDetailsView> createState() =>
      _PropertyOwnerDetailsViewState();
}

class _PropertyOwnerDetailsViewState extends State<PropertyOwnerDetailsView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerDetailsViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: ResavationAppBar(
            title: "Details",
            centerTitle: false,
            backEnabled: false,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Form(
              key: model.uploadFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  verticalSpaceSmall,
                  Text(
                    'Property Description',
                    style: AppStyle.kBodySmallRegular12W500,
                  ),
                  verticalSpaceTiny,
                  ResavationTextField(
                    hintText: '',
                    fillColors: Colors.white,
                    maxline: null,
                    textInputAction: TextInputAction.newline,
                    controller: model.propertyDescriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter property description';
                      }
                      return null;
                    },
                  ),
                  verticalSpaceSmall,
                  Text(
                    'Location',
                    style: AppStyle.kBodySmallRegular12W500,
                  ),
                  verticalSpaceTiny,
                  SelectCountry(
                    label: model.selectedCountry,
                    onSelected: model.onSelectCountryTap,
                  ),
                  verticalSpaceSmall,
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
                  verticalSpaceSmall,
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
                  verticalSpaceSmall,
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
                  verticalSpaceSmall,
                  Text(
                    'Surface Area',
                    style: AppStyle.kBodySmallRegular12W500,
                  ),
                  verticalSpaceTiny,
                  ResavationTextField(
                    hintText: 'Enter the surface area of this space',
                    fillColors: Colors.white,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    controller: model.surfaceAreaController,
                    validator: (value) {
                      final area = int.tryParse(value ?? '');
                      if (value == null || value.isEmpty) {
                        return 'Please enter surface area';
                      } else if (area == null) {
                        return 'Please enter a valid surfce area';
                      }
                      return null;
                    },
                  ),
            /*       verticalSpaceSmall,
                  Text(
                    'Generate your address on Google map',
                    style: AppStyle.kBodySmallRegular12W500,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ResavationElevatedButton(
                      child: Text("Go to Map"),
                      onPressed: () {
                        model.goToMapView();
                      },
                    ),
                  ), */
                  verticalSpaceMassive,
                ],
              ),
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ResavationElevatedButton(
                    child: Text("Back"),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                horizontalSpaceMedium,
                Expanded(
                  child: ResavationElevatedButton(
                      child: Text("Next"),
                      onPressed: () async {
                        if (model.uploadFormKey.currentState!.validate()) {
                          if (model.selectedCountry != 'Select Country') {
                            model.goToPropertyOwnerAddPhotosView();
                          } else {
                            ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                              const SnackBar(
                                content: Text('Please select your country'),
                              ),
                            );
                          }
                        }
                      }),
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
