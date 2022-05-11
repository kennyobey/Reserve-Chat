// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_amenities/property_owner_amenities_viewModel.dart';
import 'package:resavation/ui/views/property_owner_amenities/widgets/amenities_item_widget.dart';
import 'package:stacked/stacked.dart';

class PropertyOwnerAmenitiesView extends StatefulWidget {
  PropertyOwnerAmenitiesView({Key? key}) : super(key: key);

  @override
  State<PropertyOwnerAmenitiesView> createState() =>
      _PropertyOwnerAmenitiesViewState();
}

class _PropertyOwnerAmenitiesViewState
    extends State<PropertyOwnerAmenitiesView> {
  MaterialPropertyResolver<Color?>? get getColor => null;

  final uploadFormKey = GlobalKey<FormState>();
  List<String>? amenities;
  List<String>? rules;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerAmenitiesViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 15,
            ),
            child: Form(
              key: uploadFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Amenities and House Rules',
                      style: AppStyle.kBodyBold,
                    ),
                  ),
                  verticalSpaceMedium,
                  Text(
                    'Amenities',
                    style: AppStyle.kBodyBold,
                  ),
                  verticalSpaceTiny,
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AmenitiesItem(
                            label: "Wifi",
                            checkboxValue: model.hasWifi,
                            onChanged: model.onHasWifiChange,
                          ),
                          AmenitiesItem(
                            label: "Washing Machine",
                            checkboxValue: model.hasMachine,
                            onChanged: (value) {
                              setState(() {
                                // value = model.onCheckChanged2;
                                print('Machine: ${value}');
                              });
                            },
                          ),
                          AmenitiesItem(
                            label: "Air Conditioning",
                            checkboxValue: model.hasAC,
                            onChanged: model.onCheckChanged3,
                          ),
                        ],
                      ),
                      horizontalSpaceRegular,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AmenitiesItem(
                            label: "TV",
                            checkboxValue: model.hasTV,
                            onChanged: model.onCheckChanged4,
                          ),
                          AmenitiesItem(
                            label: "Hair Dryer",
                            checkboxValue: model.hasHairDryer,
                            onChanged: model.onCheckChanged5,
                          ),
                          AmenitiesItem(
                            label: "Fire Alarm",
                            checkboxValue: model.hasFireAlarm,
                            onChanged: model.onCheckChanged6,
                          ),
                        ],
                      ),
                    ],
                  ),
                  verticalSpaceTiny,
                  Text(
                    'House Rule',
                    style: AppStyle.kBodyBold,
                  ),
                  verticalSpaceTiny,
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              AmenitiesItem(
                                label: "No Smoking",
                                checkboxValue: model.smoking,
                                onChanged: model.onCheckChanged7,
                              ),
                              horizontalSpaceLarge,
                              AmenitiesItem(
                                label: "No Pets",
                                checkboxValue: model.pets,
                                onChanged: model.onCheckChanged8,
                              ),
                            ],
                          ),
                          AmenitiesItem(
                            label: "No House Party",
                            checkboxValue: model.houseParty,
                            onChanged: model.onCheckChanged9,
                          ),
                        ],
                      ),
                      horizontalSpaceRegular,
                    ],
                  ),
                  Spacer(),
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
                              model.goToPropertyOwnerIdentificationView();

                              print(" TV is ${model.hasTV}");
                            } else {
                              model.upoloadPropertyToServer(amenities, rules);
                            }
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // bottomSheet: Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 14),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       ResavationElevatedButton(
          //         child: Text(
          //           "Back",
          //           style: AppStyle.kBodyRegular,
          //         ),
          //         onPressed: () {
          //           Navigator.pop(context);
          //         },
          //       ),
          //       ResavationElevatedButton(
          //         child: Text(
          //           "Next",
          //           style: AppStyle.kBodyRegular,
          //         ),
          //         onPressed: () {
          //           model.goToPropertyOwnerIdentificationView();
          //         },
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerAmenitiesViewModel(),
    );
  }
}
