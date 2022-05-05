// ignore_for_file: deprecated_member_use

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';

import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_payment/property_owner_payment_viewModel.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:stacked/stacked.dart';

class PropertyOwnerPaymentView extends StatefulWidget {
  const PropertyOwnerPaymentView({Key? key}) : super(key: key);

  @override
  State<PropertyOwnerPaymentView> createState() =>
      _PropertyOwnerPaymentViewState();
}

class _PropertyOwnerPaymentViewState extends State<PropertyOwnerPaymentView> {
  final uploadFormKey = GlobalKey<FormState>();

  get date => null;

  // var selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerPaymentViewModel>.reactive(
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
                        'Step 2',
                        style: AppStyle.kHeading0,
                      ),
                    ),
                    verticalSpaceMedium,
                    Text(
                      'Payment Type',
                      style: AppStyle.kBodySmallRegular12W500,
                    ),
                    verticalSpaceTiny,
                    // ResavationTextField(
                    //   hintText: 'Ease Subscription',
                    //   textInputAction: TextInputAction.next,
                    //   controller: model.propertySubscriptionController,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter property subscription';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    Text(
                      'Choose your ease subscription type',
                      style: AppStyle.kBodySmallRegular12,
                    ),
                    Text(
                      '(You can select more than one)',
                      style: AppStyle.kBodySmallRegular12,
                    ),
                    verticalSpaceTiny,
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                          hint: Text(
                            "Select Property ",
                            style: AppStyle.kBodyRegular,
                          ),
                          items: model.subscriptionType
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
                                //color: Colors.black26,
                                ),
                          )),
                    ),
                    verticalSpaceTiny,
                    Text(
                      'Availability Period',
                      style: AppStyle.kBodySmallRegular12W500,
                    ),
                    verticalSpaceRegular,
                    //               Text(
                    //   "${selectedDate.toString()}".split(' ')[0],
                    //   style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DateContainer(
                          label: 'From',
                          date: "${model.selectedDate.toLocal()}".split(' ')[0],
                          onPressed: () {
                            model.selecStarttDate(context);
                          },
                        ),
                        horizontalSpaceRegular,
                        DateContainer(
                          label: 'To',
                          date: "${model.selectedDate.toLocal()}".split(' ')[0],
                          onPressed: () {
                            model.selectEndDate(context);
                          },
                        ),
                      ],
                    ),
                    verticalSpaceMedium,
                    Text(
                      'Space Price',
                      style: AppStyle.kBodySmallRegular12W500,
                    ),
                    verticalSpaceTiny,
                    Text(
                      'What is the monthly rent of this unit?',
                      style: AppStyle.kBodySmallRegular12,
                    ),
                    verticalSpaceTiny,
                    ResavationTextField(
                      hintText: '# 100,000',
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        model.incrementPrice(input: value);
                      },
                      // controller: model.propertymonthlyPriceController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter property subscription';
                        }
                        return null;
                      },
                    ),
                    verticalSpaceTiny,
                    Text(
                      'What is the quarterlet rent of this unit?',
                      style: AppStyle.kBodySmallRegular12,
                    ),
                    verticalSpaceTiny,
                    ResavationTextField(
                      hintText: '# 300,000',
                      textInputAction: TextInputAction.next,
                      controller: model.propertyquaterlylPriceController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter property subscription';
                        }
                        return null;
                      },
                    ),
                    verticalSpaceTiny,
                    Text(
                      'What is the biannual rent of this unit?',
                      style: AppStyle.kBodySmallRegular12,
                    ),
                    verticalSpaceTiny,
                    ResavationTextField(
                      hintText: '# 600,000',
                      textInputAction: TextInputAction.next,
                      controller: model.propertybiannualPriceController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter property subscription';
                        }
                        return null;
                      },
                    ),
                    verticalSpaceTiny,
                    verticalSpaceTiny,
                    Text(
                      'What is the annual rent of this unit?',
                      style: AppStyle.kBodySmallRegular12,
                    ),
                    verticalSpaceTiny,
                    ResavationTextField(
                      hintText: '# 600,000',
                      textInputAction: TextInputAction.next,
                      controller: model.propertyannualPriceController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter property subscription';
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
                                model.goToPropertyOwnerAmenitiesView();

                                print(model.selectedValue1);
                                print(model.isServiced);
                                print(model.selectedDate);
                                print(model.propertyannualPriceController);
                                print(model.propertybiannualPriceController);
                                print(model.propertyquaterlylPriceController);
                                print(model.propertymonthlyPriceController);
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
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerPaymentViewModel(),
    );
  }
}

class Date {}

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

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("My title"),
    content: Text("This is my message."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void pickDate(BuildContext context) {
  var alertdialog = Dialog(
      child: Container(
    padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
    ),
    width: double.infinity,
    height: 420,
    child: Center(
      child: Column(
        children: [
          CalendarDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2025),
            onDateChanged: (DateTime) {
              String date = DateTime.toString();
              print("The picked date is $date");
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  child: Text(
                    'Cancel',
                    style: AppStyle.kBodySmallRegular12W500,
                  ),
                  color: kWhite,
                  textColor: kPrimaryColor,
                  onPressed: () {},
                ),
                horizontalSpaceTiny,
                FlatButton(
                  child: Text(
                    'Ok',
                    style: AppStyle.kBodySmallRegular12W500,
                  ),
                  color: kWhite,
                  textColor: kPrimaryColor,
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    ),
  ));

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertdialog;
      });
}
