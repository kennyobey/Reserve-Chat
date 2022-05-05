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
                            checkboxValue: model.checkValue2,
                            onChanged: model.onCheckChanged2,
                          ),
                          AmenitiesItem(
                            label: "Air Conditioning",
                            checkboxValue: model.checkValue3,
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
                            checkboxValue: model.checkValue4,
                            onChanged: model.onCheckChanged4,
                          ),
                          AmenitiesItem(
                            label: "Hair Dryer",
                            checkboxValue: model.checkValue5,
                            onChanged: model.onCheckChanged5,
                          ),
                          AmenitiesItem(
                            label: "Fire Alarm",
                            checkboxValue: model.checkValue6,
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
                                checkboxValue: model.checkValue7,
                                onChanged: model.onCheckChanged7,
                              ),
                              horizontalSpaceLarge,
                              AmenitiesItem(
                                label: "No Pets",
                                checkboxValue: model.checkValue8,
                                onChanged: model.onCheckChanged8,
                              ),
                            ],
                          ),
                          AmenitiesItem(
                            label: "No House Party",
                            checkboxValue: model.checkValue9,
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

                              print(" one is ${model.checkValue2}");
                              print(" two is ${model.checkValue3}");
                              print(" three is ${model.checkValue4}");
                              print(" four is ${model.checkValue5}");
                              print("wifi is ${model.hasWifi}");
                              print(" two is ${model.checkValue7}");
                              print(" two is ${model.checkValue9}");
                            } else {
                              model.upoloadPropertyToServer();
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
