// ignore_for_file: deprecated_member_use

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
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
  Column buildErrorBody() {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        Text(
          'Error occurred!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'An error occurred while fetching data, please try again later',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const Spacer(),
      ],
    );
  }

  Center buildLoadingWidget() {
    return const Center(
      child: SizedBox(
        height: 40,
        width: 40,
        child: CircularProgressIndicator.adaptive(
          backgroundColor: Colors.blue,
          valueColor: AlwaysStoppedAnimation(kWhite),
        ),
      ),
    );
  }

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
          body: model.isLoading
              ? buildLoadingWidget()
              : model.hasErrorOnData
                  ? buildErrorBody()
                  : buildBody(model),
          bottomSheet: buildBottomSheet(context, model),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerDetailsViewModel(),
    );
  }

  Padding buildBottomSheet(
      BuildContext context, PropertyOwnerDetailsViewModel model) {
    return Padding(
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
          model.isLoading || model.hasErrorOnData
              ? SizedBox()
              : horizontalSpaceMedium,
          model.isLoading || model.hasErrorOnData
              ? SizedBox()
              : Expanded(
                  child: ResavationElevatedButton(
                      child: Text("Next"),
                      onPressed: () async {
                        if (model.selectedState != null) {
                          if (model.uploadFormKey.currentState!.validate()) {
                            model.goToPropertyOwnerAddPhotosView();
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please pick your state'),
                            ),
                          );
                        }
                      }),
                )
        ],
      ),
    );
  }

  SingleChildScrollView buildBody(PropertyOwnerDetailsViewModel model) {
    return SingleChildScrollView(
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
                final area = double.tryParse(value ?? '');
                if (value == null || value.isEmpty) {
                  return 'Please enter surface area';
                } else if (area == null) {
                  return 'Please enter a valid surfce area';
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
              'State',
              style: AppStyle.kBodySmallRegular12W500,
            ),
            verticalSpaceTiny,
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                hint: Text(
                  "Select State",
                  style: AppStyle.kBodyRegular,
                ),
                items: model.states
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: AppStyle.kBodyRegular,
                        ),
                      ),
                    )
                    .toList(),
                value: model.selectedState,
                onChanged: (value) {
                  model.onStateChanged(value);
                },
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                ),
                buttonWidth: double.infinity,
                buttonPadding: EdgeInsets.only(left: 18, right: 20),
                buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.black26,
                  ),
                ),
              ),
            ),
            /*  ResavationTextField(
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
                ), */
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
    );
  }
}
