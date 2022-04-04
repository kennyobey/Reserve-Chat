// ignore_for_file: deprecated_member_use

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';

import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_spaceType/property_owner_spacetype_viewmodel.dart';

import 'package:stacked/stacked.dart';

class PropertyOwnerSpaceTypeView extends StatelessWidget {
  PropertyOwnerSpaceTypeView({Key? key}) : super(key: key);

  get _radioValue1 => 1;

  get _handleRadioValueChange1 => null;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerSpaceTypeViewModel>.reactive(
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
                      'Space Type',
                      style: AppStyle.kBodyRegularW500,
                    ),
                  ),
                  verticalSpaceMedium,
                  Text(
                    'Tell us about your property',
                    style: AppStyle.kBodyRegularBlack14W500,
                  ),
                  verticalSpaceMedium,
                  Text(
                    'Property Type',
                    style: AppStyle.kBodyRegularBlack14,
                  ),
                  verticalSpaceSmall,
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                        hint: Text(
                          "Select Property ",
                          style: AppStyle.kBodyRegular,
                        ),
                        items: model.items
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: AppStyle.kBodyRegular,
                                  ),
                                ))
                            .toList(),
                        value: model.selectedValue,
                        onChanged: (value) {
                          model.onSelectedValueChange(value);
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                        ),
                        buttonWidth: 330,
                        buttonPadding:
                            const EdgeInsets.only(left: 18, right: 20),
                        buttonDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                        )),
                  ),
                  verticalSpaceMedium,
                  Text(
                    'Narrow down your space type',
                    style: AppStyle.kBodySmallRegular12W500,
                  ),
                  verticalSpaceMedium,
                  Text(
                    'Is your space serviced',
                    style: AppStyle.kBodyRegularBlack14,
                  ),
                  Row(
                    children: [
                      Text(
                        'Yes',
                        style: AppStyle.kBodyRegular,
                      ),
                      Spacer(),
                      Radio(
                        value: 1,
                        groupValue: _radioValue1,
                        onChanged: _handleRadioValueChange1,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'No',
                        style: AppStyle.kBodyRegular,
                      ),
                      Spacer(),
                      Radio(
                        value: 2,
                        groupValue: _radioValue1,
                        onChanged: _handleRadioValueChange1,
                      ),
                    ],
                  ),
                  verticalSpaceSmall,
                  Text(
                    'Is your space furnished',
                    style: AppStyle.kBodyRegularBlack14,
                  ),
                  Row(
                    children: [
                      Text(
                        'Yes',
                        style: AppStyle.kBodyRegular,
                      ),
                      Spacer(),
                      Radio(
                        value: 3,
                        groupValue: _radioValue1,
                        onChanged: _handleRadioValueChange1,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'No',
                        style: AppStyle.kBodyRegular,
                      ),
                      Spacer(),
                      Radio(
                        value: 4,
                        groupValue: _radioValue1,
                        onChanged: _handleRadioValueChange1,
                      ),
                    ],
                  ),
                  verticalSpaceSmall,
                  Text(
                    'Listing Options',
                    style: AppStyle.kBodySmallRegular12W500,
                  ),
                  verticalSpaceTiny,

                  verticalSpaceTiny,
                  ResavationTextField(
                    hintText: 'Choose your listing option',
                  ),
                  Text(
                    'Do you leave in this space',
                    style: AppStyle.kBodySmallRegular12W500,
                  ),
                  Row(
                    children: [
                      Text(
                        'Yes',
                        style: AppStyle.kBodyRegular,
                      ),
                      Spacer(),
                      Radio(
                        value: 5,
                        groupValue: _radioValue1,
                        onChanged: _handleRadioValueChange1,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'No',
                        style: AppStyle.kBodyRegular,
                      ),
                      Spacer(),
                      Radio(
                        value: 6,
                        groupValue: _radioValue1,
                        onChanged: _handleRadioValueChange1,
                      ),
                    ],
                  ),

                  //Select the number of bedrooms
                  AmenitiesSelection(
                    title: "Number Of bedrooms",
                    value: model.numberOfBedrooms,
                    onPositiveTap: ()=> model.onPositiveBedRoomTap(),
                    onNegativeTap: ()=> model.onNegativeBedRoomTap(),
                  ),

                  //Select the number of bathrooms
                  AmenitiesSelection(
                    title: "Number of bathrooms",
                    value: model.numberOfBathrooms,
                    onPositiveTap: ()=> model.onPositiveBathRoomTap(),
                    onNegativeTap: ()=> model.onNegativeBathRoomTap(),

                  ),

                  //Select the number of car slots
                  AmenitiesSelection(
                    title: "Number of car slots",
                    value: model.numberOfCarSlot,
                    onPositiveTap: ()=> model.onPositiveCarSlotTap(),
                    onNegativeTap: ()=> model.onNegativeCarSlotTap(),
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlatButton(
                        child: Text(
                          'Next',
                          style: AppStyle.kBodyRegular,
                        ),
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          model.goToPropertyOwnerDetailsView();
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
      viewModelBuilder: () => PropertyOwnerSpaceTypeViewModel(),
    );
  }
}

class AmenitiesSelection extends ViewModelWidget<PropertyOwnerSpaceTypeViewModel> {
  const AmenitiesSelection({
    Key? key, this.title, this.onNegativeTap, this.onPositiveTap, this.value
  }) : super(key: key);
  final String? title;
  final int? value;
  final Function()? onNegativeTap;
  final Function()? onPositiveTap;

  @override
  Widget build(BuildContext context, model) {
    return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title!, style: AppStyle.kBodySmallRegular12,),
                    Row(
                      children: [
                        IncrementAmenities(
                          icon: Icons.remove,
                          onTap: onNegativeTap,
                        ),
                        Text(value.toString()),
                        IncrementAmenities(
                          icon: Icons.add,
                          onTap: onPositiveTap,
                        ),
                      ],
                    )
                  ],
                );
  }
}

// widget used to increase/decrease the amenities value
class IncrementAmenities extends StatelessWidget {
  const IncrementAmenities({
    Key? key, this.icon, this.onTap
  }) : super(key: key);

  final IconData? icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: kInactiveColor ),
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: Icon(icon,
            color: kInactiveColor,
            size: 12,
          ),
        ),
      ),
    );
  }
}
