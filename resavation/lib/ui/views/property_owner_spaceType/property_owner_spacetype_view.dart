// ignore_for_file: deprecated_member_use

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';

import 'package:resavation/ui/shared/dump_widgets/resavation_radio_button.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_spaceType/property_owner_spacetype_viewmodel.dart';

import 'package:stacked/stacked.dart';

class PropertyOwnerSpaceTypeView extends StatefulWidget {
  PropertyOwnerSpaceTypeView({Key? key}) : super(key: key);

  @override
  State<PropertyOwnerSpaceTypeView> createState() =>
      _PropertyOwnerSpaceTypeViewState();
}

class _PropertyOwnerSpaceTypeViewState
    extends State<PropertyOwnerSpaceTypeView> {
  final uploadFormKey = GlobalKey<FormState>();

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
              child: Form(
                key: uploadFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Space Type',
                        style: AppStyle.kHeading0,
                      ),
                    ),
                    verticalSpaceMedium,
                    Text(
                      'Tell us about your property',
                      style: AppStyle.kBodyRegular,
                    ),
                    verticalSpaceMedium,
                    Text(
                      'Property Type',
                      style: AppStyle.kBodyRegular,
                    ),
                    verticalSpaceTiny,
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                          hint: Text(
                            "Select Property ",
                            style: AppStyle.kBodyRegular,
                          ),
                          items: model.spaceType
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: AppStyle.kBodyRegular,
                                    ),
                                  ))
                              .toList(),
                          value: model.selectedValue1,
                          onChanged: (value) {
                            model.onSelectedValueChange1(value);
                          },
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                          ),
                          buttonWidth: 330,
                          buttonPadding: EdgeInsets.only(left: 18, right: 20),
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
                      style: AppStyle.kBodyRegular,
                    ),
                    verticalSpaceMedium,
                    Text(
                      'Is your space serviced',
                      style: AppStyle.kBodyRegular,
                    ),

                    // is your space serviced Yes/No
                    // ResavationRadioButton(
                    //   title: 'Yes',
                    //   radioValue: model.isServiced,
                    //   groupValue: model.isServiced,
                    //   onChanged: (radioValue) {
                    //     model.onSpaceServicedRadioChange(true);
                    //   },
                    // ),
                    // ResavationRadioButton(
                    //   title: 'No',
                    //   radioValue: model.isServiced,
                    //   groupValue: model.isServiced,
                    //   onChanged: (radioValue) {
                    //     model.onSpaceServicedRadioChange(false);
                    //   },
                    // ),
                    //
                    FilterListTile(),
                    verticalSpaceSmall,
                    Text(
                      'Is your space furnished',
                      style: AppStyle.kBodyRegular,
                    ),

                    // Is your space furnished Yes/No
                    // ResavationRadioButton(
                    //   title: 'Yes',
                    //   radioValue: "Yes",
                    //   groupValue: model.isFurnished,
                    //   onChanged: (String? radioValue) {
                    //     model
                    //         .onSpaceFurnishedRadioChange(radioValue.toString());
                    //   },
                    // ),
                    // ResavationRadioButton(
                    //   title: 'No',
                    //   radioValue: "No",
                    //   groupValue: model.isFurnished,
                    //   onChanged: (String? radioValue) {
                    //     model
                    //         .onSpaceFurnishedRadioChange(radioValue.toString());
                    //   },
                    // ),

                    FilterListTile(),
                    verticalSpaceSmall,
                    Text(
                      'Listing Options',
                      style: AppStyle.kBodyRegular,
                    ),
                    verticalSpaceTiny,
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                          hint: Text(
                            "Select Listing Option",
                            style: AppStyle.kBodyRegular,
                          ),
                          items: model.listingOption
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: AppStyle.kBodyRegular,
                                    ),
                                  ))
                              .toList(),
                          value: model.selectedValue2,
                          onChanged: (value) {
                            model.onSelectedValueChange2(value);
                          },
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                          ),
                          buttonWidth: 330,
                          buttonPadding: EdgeInsets.only(left: 18, right: 20),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.black26,
                            ),
                          )),
                    ),

                    verticalSpaceSmall,
                    Text(
                      'Property Status',
                      style: AppStyle.kBodyRegular,
                    ),
                    verticalSpaceTiny,
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                          hint: Text(
                            "Select Property Status",
                            style: AppStyle.kBodyRegular,
                          ),
                          items: model.propertyStatus
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: AppStyle.kBodyRegular,
                                    ),
                                  ))
                              .toList(),
                          value: model.selectedValue3,
                          onChanged: (value) {
                            model.onSelectedValueChange3(value);
                          },
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                          ),
                          buttonWidth: 330,
                          buttonPadding: EdgeInsets.only(left: 18, right: 20),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.black26,
                            ),
                          )),
                    ),
                    verticalSpaceSmall,
                    Text(
                      'Do you leave in this space',
                      style: AppStyle.kBodyRegular,
                    ),

                    // do you leave in this space Yes/No
                    // ResavationRadioButton(
                    //   title: 'Yes',
                    //   radioValue: "Yes",
                    //   groupValue: model.leaveHere,
                    //   onChanged: (String? radioValue) {
                    //     model.onLeaveHereRadioChange(radioValue.toString());
                    //   },
                    // ),

                    // ResavationRadioButton(
                    //   title: 'No',
                    //   radioValue: "No",
                    //   groupValue: model.leaveHere,
                    //   onChanged: (String? radioValue) {
                    //     model.onLeaveHereRadioChange(radioValue.toString());
                    //   },
                    // ),

                    FilterListTile(),
                    verticalSpaceSmall,
                    //Select the number of bedrooms
                    AmenitiesSelection(
                      title: "Number Of bedrooms",
                      value: model.numberOfBedrooms,
                      onPositiveTap: () => model.onPositiveBedRoomTap(),
                      onNegativeTap: () => model.onNegativeBedRoomTap(),
                    ),
                    verticalSpaceSmall,
                    //Select the number of bathrooms
                    AmenitiesSelection(
                      title: "Number of bathrooms",
                      value: model.numberOfBathrooms,
                      onPositiveTap: () => model.onPositiveBathRoomTap(),
                      onNegativeTap: () => model.onNegativeBathRoomTap(),
                    ),
                    verticalSpaceSmall,
                    //Select the number of car slots
                    AmenitiesSelection(
                      title: "Number of car slots",
                      value: model.numberOfCarSlot,
                      onPositiveTap: () => model.onPositiveCarSlotTap(),
                      onNegativeTap: () => model.onNegativeCarSlotTap(),
                    ),
                    verticalSpaceLarge,

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                          child: Text(
                            'Back',
                            style: AppStyle.kBodyRegularBlack14W500,
                          ),
                          color: kWhite,
                          textColor: kBlack,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Spacer(),
                        FlatButton(
                          child: Text(
                            'Next',
                            style: AppStyle.kBodyRegular,
                          ),
                          color: kPrimaryColor,
                          textColor: Colors.white,
                          onPressed: () async {
                            if (uploadFormKey.currentState!.validate()) {
                              model.goToPropertyOwnerDetailsView();

                              print('furnish ${model.isFurnished}');
                              print('serviced ${model.isServiced}');
                              print('live here ${model.leaveHere}');
                              print(
                                  'nos of bathroom ${model.numberOfBathrooms}');
                              print('selected value ${model.selectedValue1}');
                              print('nos of bedroom ${model.numberOfBedrooms}');
                              print('no of car lot ${model.numberOfCarSlot}');
                            } else {
                              model.upoloadPropertyToServer();
                            }
                          },
                          //           onPressed: ()async {
                          //     if (uploadFormKey.currentState!.validate()) {
                          //               // model.goToPropertyOwnerDetailsView();
                          //   // Navigator to the next page.
                          //   Navigator.of(context).push(
                          //     MaterialPageRoute(

                          //         // Builder for the nextpage class's constructor.
                          //         builder: (context) => PropertyOwnerDetailsView(

                          //               // Data as arguments to send to next page.
                          //               name: _name.text,
                          //               email: _email.text,
                          //               phoneno: _phoneno.text,
                          //             ),),
                          //   );
                          // },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // bottomSheet: Row(
          //   children: [
          //     ResavationButton(
          //       buttonColor: kWhite,
          //       width: 50,
          //       height: 47,
          //       title: 'Back',
          //       titleColor: kBlack,
          //       onTap: () {
          //         model.goToPropertyOwnerHomePageView();
          //       },
          //     ),
          //     Spacer(),
          //     ResavationButton(
          //       width: 50,
          //       height: 47,
          //       title: 'Continue',
          //       onTap: () {
          //         model.goToPropertyOwnerDetailsView();
          //       },
          //     ),
          //   ],
          // ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerSpaceTypeViewModel(),
    );
  }
}

class AmenitiesSelection extends StatelessWidget {
  const AmenitiesSelection(
      {Key? key,
      this.title,
      this.onNegativeTap,
      this.onPositiveTap,
      this.value})
      : super(key: key);
  final String? title;
  final int? value;
  final Function()? onNegativeTap;
  final Function()? onPositiveTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title!,
          style: AppStyle.kBodySmallRegular12,
        ),
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
  const IncrementAmenities({Key? key, this.icon, this.onTap}) : super(key: key);

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
              border: Border.all(color: kGray),
              borderRadius: BorderRadius.circular(10.0)),
          child: Icon(
            icon,
            color: kGray,
            size: 12,
          ),
        ),
      ),
    );
  }
}

class FilterListTile extends StatefulWidget {
  const FilterListTile({Key? key, e}) : super(key: key);

  @override
  State<FilterListTile> createState() => _FilterListTileState();
}

class _FilterListTileState extends State<FilterListTile> {
  int? _groupValue;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    _focusNodes = Iterable<int>.generate(2).map((e) => FocusNode()).toList();

    _focusNodes[0].requestFocus();
  }

  Widget buildRadio(String title, int value, FocusNode focusNode) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: kBlack,
                fontSize: 13,
              ),
            ),
            Radio<int>(
                groupValue: _groupValue,
                value: value,
                onChanged: (int? value) {
                  setState(() {
                    _groupValue = value;
                  });
                },
                hoverColor: kWhite,
                activeColor: kPrimaryColor,
                focusColor: kPrimaryColor,
                splashRadius: 25,
                toggleable: true,
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                focusNode: focusNode),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildRadio('Yes', 1, _focusNodes[0]),
        buildRadio('No', 2, _focusNodes[1]),
      ],
    );
  }
}
