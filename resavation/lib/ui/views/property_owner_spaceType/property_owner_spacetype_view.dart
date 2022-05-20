// ignore_for_file: deprecated_member_use

// import 'dart:js';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_spaceType/property_owner_spacetype_viewmodel.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
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

  List<dynamic> Categories = [];
  List<dynamic> subCategoriesMaster = [];
  List<dynamic> subCategories = [];

  String? CategoriesID;
  String? subCategoriesID;

  @override
  void initState() {
    super.initState;
    this.Categories.add({"id": 1, "name": "Residential"});
    this.Categories.add({"id": 2, "name": "Commercial"});
    this.Categories.add({"id": 3, "name": "Industrial"});
    this.Categories.add({"id": 4, "name": "Retail"});

    this.subCategoriesMaster = [
      // Residential
      {"ID": 1, "Name": "Duplex", "parentID": 1},
      {"ID": 2, "Name": "Detached huse", "parentID": 1},
      {"ID": 3, "Name": "Terraced House", "parentID": 1},
      {"ID": 4, "Name": "Pent House", "parentID": 1},
      {"ID": 5, "Name": "Apartment", "parentID": 1},
      {"ID": 6, "Name": "Bungalow", "parentID": 1},
      {"ID": 7, "Name": "Mansion", "parentID": 1},
      //Commercial
      {"ID": 1, "Name": "Co-working space", "parentID": 2},
      {"ID": 2, "Name": "Private Office", "parentID": 2},
      //Industrial
      {"ID": 1, "Name": "Warehouse", "parentID": 3},
      {"ID": 2, "Name": "Factory", "parentID": 3},
      //Retial
      {"ID": 1, "Name": "Building", "parentID": 4},
      {"ID": 2, "Name": "Shop", "parentID": 4},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerSpaceTypeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: ResavationAppBar(title: "Space Type"),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            bottom: 15,
            top: 15,
          ),
          child: Form(
            key: uploadFormKey,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tell us about your property',
                    style: AppStyle.kBodyRegular,
                  ),
                  verticalSpaceSmall,
                  ...buildPropertyStatus(model),
                  verticalSpaceSmall,

                  ...buildPropertyCategory(context),
                  verticalSpaceSmall,
                  // ...buildPropertyType1(context),
                  ...buildPropertyType(model),

                  verticalSpaceMedium,
                  Text(
                    'Narrow down your space type',
                    style: AppStyle.kBodyRegular,
                  ),
                  verticalSpaceMedium,
                  ...buildSpaceServiced(model),
                  verticalSpaceSmall,
                  ...buildSpaceFurnished(model),
                  verticalSpaceSmall,
                  ...buildListingOptions(model),

                  verticalSpaceSmall,
                  ...buildLiveInSpace(model),
                  verticalSpaceSmall,
                  buildNumberOfBedrooms(model),
                  verticalSpaceSmall,
                  //Select the number of bathrooms
                  buildNumberOfBathrooms(model),
                  verticalSpaceSmall,
                  //Select the number of car slots
                  buildNumberOfCarSlots(model),
                  verticalSpaceLarge,
                  buildButtons(context, model),
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
      viewModelBuilder: () => PropertyOwnerSpaceTypeViewModel(),
    );
  }

  Row buildButtons(
      BuildContext context, PropertyOwnerSpaceTypeViewModel model) {
    return Row(
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
              print('nos of bathroom ${model.numberOfBathrooms}');
              print('selected value ${model.selectedProperty}');
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
    );
  }

  AmenitiesSelection buildNumberOfCarSlots(
      PropertyOwnerSpaceTypeViewModel model) {
    return AmenitiesSelection(
      title: "Number of car slots",
      value: model.numberOfCarSlot,
      onPositiveTap: () => model.onPositiveCarSlotTap(),
      onNegativeTap: () => model.onNegativeCarSlotTap(),
    );
  }

  AmenitiesSelection buildNumberOfBathrooms(
      PropertyOwnerSpaceTypeViewModel model) {
    return AmenitiesSelection(
      title: "Number of bathrooms",
      value: model.numberOfBathrooms,
      onPositiveTap: () => model.onPositiveBathRoomTap(),
      onNegativeTap: () => model.onNegativeBathRoomTap(),
    );
  }

  AmenitiesSelection buildNumberOfBedrooms(
      PropertyOwnerSpaceTypeViewModel model) {
    return AmenitiesSelection(
      title: "Number Of bedrooms",
      value: model.numberOfBedrooms,
      onPositiveTap: () => model.onPositiveBedRoomTap(),
      onNegativeTap: () => model.onNegativeBedRoomTap(),
    );
  }

  List<Widget> buildLiveInSpace(PropertyOwnerSpaceTypeViewModel model) {
    return [
      Text(
        'Do you leave in this space',
        style: AppStyle.kBodyRegular,
      ),
      FilterListTile(
        onChanged: model.setLiveInSpace,
      ),
    ];
  }

  List<Widget> buildPropertyStatus(PropertyOwnerSpaceTypeViewModel model) {
    return [
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
            value: model.propertyStatusValue,
            onChanged: (value) {
              model.onPropertyStatusValueChange(value);
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
            )),
      ),
    ];
  }

  List<Widget> buildListingOptions(PropertyOwnerSpaceTypeViewModel model) {
    return [
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
            value: model.listingOptionValue,
            onChanged: (value) {
              model.onListingOptionValueChange(value);
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
            )),
      ),
    ];
  }

  List<Widget> buildSpaceFurnished(PropertyOwnerSpaceTypeViewModel model) {
    return [
      Text(
        'Is your space furnished',
        style: AppStyle.kBodyRegular,
      ),
      FilterListTile(
        onChanged: model.setSpaceFurnished,
      ),
    ];
  }

  List<Widget> buildSpaceServiced(PropertyOwnerSpaceTypeViewModel model) {
    return [
      Text(
        'Is your space serviced',
        style: AppStyle.kBodyRegular,
      ),
      FilterListTile(onChanged: model.setSpaceServiced),
    ];
  }

  List<Widget> buildPropertyType(PropertyOwnerSpaceTypeViewModel model) {
    return [
      Text(
        'Property Type',
        style: AppStyle.kBodyRegular,
      ),
      verticalSpaceTiny,
      DropdownButtonHideUnderline(
        child: DropdownButton2(
            hint: Text(
              "Select Property",
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
            value: model.selectedProperty,
            onChanged: (value) {
              model.onSelectedPropertyChange(value);
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
            )),
      ),
    ];
  }

  List<Widget> buildPropertyCategory(BuildContext context) {
    return [
      Text(
        'Property Category',
        style: AppStyle.kBodyRegular,
      ),
      verticalSpaceTiny,
      Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: FormHelper.dropDownWidget(
            context, "Property category", this.CategoriesID, this.Categories,
            (onChangeVal) {
              this.CategoriesID = onChangeVal;
              print("SelectedCtegories $onChangeVal");

              this.subCategories = this
                  .subCategoriesMaster
                  .where(
                    (subCategoriesItem) =>
                        subCategoriesItem["parentID"].toString() ==
                        onChangeVal.toString(),
                  )
                  .toList();

              this.subCategoriesID = null;
            },
            (onValidateVal) {
              if (onValidateVal == null) {
                return "Please Select Category";
              }
            },
            borderColor: kGray,
            borderRadius: 5,
            // optionLabel: "name",
            // optionValue: "id"
          )),
      Text(
        'Property Type',
        style: AppStyle.kBodyRegular,
      ),
      verticalSpaceTiny,
      Container(
        width: MediaQuery.of(context).size.width,
        child: FormHelper.dropDownWidget(context, "Select Property Type ",
            this.subCategoriesID, this.subCategories, (onChangeVal) {
          this.subCategoriesID = onChangeVal;
          print("Selected  Property Types $onChangeVal");
        }, (onValidateVal) {
          if (onValidateVal == null) {
            return "Please Select Property Type";
          }
        },
            borderColor: kGray,
            borderRadius: 5,
            optionLabel: "Name",
            optionValue: "ID"),
      )
    ];
  }

  // List<Widget> buildPropertyType1(BuildContext context) {
  //   return [
  //     Text(
  //       'Property Type',
  //       style: AppStyle.kBodyRegular,
  //     ),
  //     verticalSpaceTiny,
  //     Container(
  //       width: MediaQuery.of(context).size.width,
  //       child: FormHelper.dropDownWidget(context, "Select Property Type ",
  //           this.subCategoriesID, this.subCategories, (onChangeVal) {
  //         this.subCategoriesID = onChangeVal;
  //         print("Selected  Property Types $onChangeVal");
  //       }, (onValidateVal) {
  //         if (onValidateVal == null) {
  //           return "Please Select Property Type";
  //         }
  //       },
  //           borderColor: kGray,
  //           borderRadius: 5,
  //           optionLabel: "Name",
  //           optionValue: "ID"),
  //     )
  //   ];
  // }
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
  final Function(bool?) onChanged;

  const FilterListTile({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<FilterListTile> createState() => _FilterListTileState();
}

class _FilterListTileState extends State<FilterListTile> {
  bool? _groupValue;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _focusNodes = Iterable<int>.generate(2).map((e) => FocusNode()).toList();

    _focusNodes[0].requestFocus();
  }

  Widget buildRadio(String title, bool value, FocusNode focusNode) {
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
            Radio<bool>(
                groupValue: _groupValue,
                value: value,
                onChanged: (bool? value) {
                  widget.onChanged(value);
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
        buildRadio('Yes', true, _focusNodes[0]),
        buildRadio('No', false, _focusNodes[1]),
      ],
    );
  }
}
