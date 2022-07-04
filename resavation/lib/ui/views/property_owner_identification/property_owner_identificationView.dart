// ignore_for_file: deprecated_member_use

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';

import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';

import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/dump_widgets/select_country.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';

import 'package:resavation/ui/views/property_owner_identification/property_owner_identificationViewModel.dart';
import 'package:country_picker/country_picker.dart';
import 'package:country_code_picker/country_code_picker.dart';

import 'package:stacked/stacked.dart';

class PropertyOwnerIdentificationView extends StatefulWidget {
  const PropertyOwnerIdentificationView({Key? key}) : super(key: key);

  @override
  State<PropertyOwnerIdentificationView> createState() =>
      _PropertyOwnerIdentificationViewState();
}

class _PropertyOwnerIdentificationViewState
    extends State<PropertyOwnerIdentificationView> {
  final uploadFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerIdentificationViewModel>.reactive(
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
                    verticalSpaceMedium,
                    Center(
                      child: Text(
                        'Identification',
                        style: AppStyle.kBodyRegularBlack14W500,
                      ),
                    ),
                    verticalSpaceMedium,
                    Text(
                      'Personal Details',
                      style: AppStyle.kBodyRegularBlack14W500,
                    ),
                    verticalSpaceSmall,
                    Text(
                      'Complete your personal information',
                      style: AppStyle.kBodySmallRegular12W500,
                    ),
                    verticalSpaceTiny,
                    ResavationTextField(
                      hintText: 'First Name',
                      fillColors: Colors.white,
                      maxline: 5,
                      textInputAction: TextInputAction.next,
                      controller: model.userFirstNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    verticalSpaceTiny,
                    ResavationTextField(
                      hintText: 'Last Name',
                      fillColors: Colors.white,
                      maxline: 5,
                      textInputAction: TextInputAction.next,
                      controller: model.userLastNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Container(
                          height: 55,
                          width: 200,
                          decoration: BoxDecoration(
                              border: Border.all(color: kGray),
                              borderRadius: BorderRadius.circular(3.0)),
                          child: Row(
                            children: [
                              CountryCodePicker(
                                initialSelection: "US",
                                showCountryOnly: false,
                                showFlag: true,
                                showDropDownButton: true,
                                showOnlyCountryWhenClosed: false,
                                favorite: ['+234', 'NIG'],
                                enabled: true,
                                showFlagMain: true,
                                hideMainText: false,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          child: Text(
                            "Verify Now",
                            style: AppStyle.kBodySmallRegular12
                                .copyWith(color: kPrimaryColor),
                          ),
                        ),
                      ],
                    ),
                    verticalSpaceTiny,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Date of Birth',
                          style: AppStyle.kBodySmallRegular12,
                        ),
                      ],
                    ),
                    verticalSpaceTiny,
                    Row(
                      children: [
                        Container(
                          width: 200,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                                hint: Text(
                                  "Gender",
                                  style: AppStyle.kBodyRegular,
                                ),
                                items: model.gender
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: AppStyle.kBodyRegular,
                                          ),
                                        ))
                                    .toList(),
                                value: model.selectedGender,
                                onChanged: (value) {
                                  model.onSelectedValueChange1(value);
                                },
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                ),
                                buttonWidth: 330,
                                buttonPadding:
                                    EdgeInsets.only(left: 18, right: 20),
                                buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      //color: Colors.black26,
                                      ),
                                )),
                          ),
                        ),
                        horizontalSpaceTiny,
                        DateContainer(
                          label: 'Date Of Birth',
                          date: "${model.selectedDate}".split(' ')[0],
                          onPressed: () {
                            model.selecStarttDate(context);
                          },
                        ),

                        // _buildTextField(''),
                        // horizontalSpaceMedium,
                        // Expanded(child: _buildTextFieldDay('')),
                        // horizontalSpaceTiny,
                        // Expanded(child: _buildTextFieldMonth('')),
                        // horizontalSpaceTiny,
                        // Expanded(child: _buildTextFieldYear('')),
                      ],
                    ),
                    verticalSpaceSmall,
                    Text(
                      'Complete your address',
                      style: AppStyle.kBodyRegular,
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
                      maxline: 5,
                      textInputAction: TextInputAction.next,
                      controller: model.userStateController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your state';
                        }
                        return null;
                      },
                    ),
                    verticalSpaceTiny,
                    ResavationTextField(
                      hintText: 'City',
                      fillColors: Colors.white,
                      maxline: 5,
                      textInputAction: TextInputAction.next,
                      controller: model.userCityController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your city';
                        }
                        return null;
                      },
                    ),
                    verticalSpaceTiny,
                    ResavationTextField(
                      hintText: 'Enter the address of the space',
                      fillColors: Colors.white,
                      maxline: 5,
                      textInputAction: TextInputAction.next,
                      controller: model.userAddressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    verticalSpaceTiny,
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
                                model.goToPropertyOwnerVerificationView();
                                print(model.userFirstNameController);
                                print(model.userLastNameController);
                                print(model.selectedDate);
                                print(model.userDOBController);
                              } else {
                                model.upoloadPropertyToServer();
                              }
                            }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        // bottomSheet: Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 35.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       ResavationElevatedButton(
        //         child: Text("Back"),
        //         onPressed: () => Navigator.pop(context),
        //       ),
        //       ResavationElevatedButton(
        //         child: Text("Next"),
        //         onPressed: () => model.goToPropertyOwnerVerificationView(),
        //       )
        //     ],
        //   ),
        // ),
      ),
      viewModelBuilder: () => PropertyOwnerIdentificationViewModel(),
    );
  }
}

Widget _buildTextFieldYear(String label) {
  String? label;
  const maxLines = 5;
  return Container(
    width: 80,
    height: maxLines * 8.0,
    child: const TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: ("YYYY"),
        isDense: true, // Added this
        //contentPadding: EdgeInsets.all(8), // Added this
      ),
    ),
  );
}

class DateContainer extends StatelessWidget {
  const DateContainer({
    Key? key,
    required this.label,
    required this.date,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final String date;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.only(top: 2, left: 20),
          decoration: BoxDecoration(
              border: Border.all(color: kGray),
              borderRadius: BorderRadius.circular(5)),
          width: 138,
          height: 53,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppStyle.kBodyRegularBlack14.copyWith(color: kGray),
              ),
              Text(date,
                  style: AppStyle.kBodySmallRegular12.copyWith(color: kBlack)),
            ],
          ),
        ),
      ),
    );
  }
}
