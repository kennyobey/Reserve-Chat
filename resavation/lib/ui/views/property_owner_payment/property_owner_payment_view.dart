// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';

import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_payment/property_owner_payment_viewModel.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:stacked/stacked.dart';

class PropertyOwnerPaymentView extends StatelessWidget {
  const PropertyOwnerPaymentView({Key? key}) : super(key: key);

  get context => null;

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
                  ResavationTextField(
                    hintText: 'Ease Subscription',
                  ),
                  Text(
                    'Choose your ease subscription type',
                    style: AppStyle.kBodySmallRegular12,
                  ),
                  Text(
                    '(You can select more than one)',
                    style: AppStyle.kBodySmallRegular12,
                  ),
                  verticalSpaceTiny,
                  ResavationTextField(
                    hintText: 'Select',
                  ),
                  verticalSpaceTiny,
                  Text(
                    'Avalability Period',
                    style: AppStyle.kBodySmallRegular12W500,
                  ),
                  verticalSpaceTiny,
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(color: kGray),
                            borderRadius: BorderRadius.circular(5)),
                        width: 160,
                        height: 65,
                        child: FlatButton(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "From",
                                  style: AppStyle.kBodyRegularBlack14Poppins
                                      .copyWith(color: kGray),
                                ),
                                Spacer(),
                                Text("Jan 1 2021",
                                    style: AppStyle.kBodySmallRegular12
                                        .copyWith(color: kBlack)),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            onPressed: () {
                              model.goToPropertyOwnerDatePickerView();
                            }),
                      ),
                      Spacer(),
                      Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(color: kGray),
                              borderRadius: BorderRadius.circular(5)),
                          width: 160,
                          height: 65,
                          child: FlatButton(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "To",
                                    style: AppStyle.kBodyRegularBlack14Poppins
                                        .copyWith(color: kGray),
                                  ),
                                  Spacer(),
                                  Text("Jan 1 2022",
                                      style: AppStyle.kBodySmallRegular12
                                          .copyWith(color: kBlack)),
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              onPressed: () {
                                model.goToPropertyOwnerDatePickerView();
                              })),
                    ],
                  ),
                  verticalSpaceTiny,
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
                  ),
                  verticalSpaceTiny,
                  Text(
                    'What is the quarterlet rent of this unit?',
                    style: AppStyle.kBodySmallRegular12,
                  ),
                  verticalSpaceTiny,
                  ResavationTextField(
                    hintText: '# 300,000',
                  ),
                  verticalSpaceTiny,
                  Text(
                    'What is the biannual rent of this unit?',
                    style: AppStyle.kBodySmallRegular12,
                  ),
                  verticalSpaceTiny,
                  ResavationTextField(
                    hintText: '# 600,000',
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
                          model.goToPropertyOwnerDatePickerView();
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
                        onPressed: () {
                          model.goToPropertyOwnerAmenitiesView();
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
      viewModelBuilder: () => PropertyOwnerPaymentViewModel(),
    );
  }

  void _onSelectionChanged(
      DateRangePickerSelectionChangedArgs dateRangePickerSelectionChangedArgs) {
    print(dateRangePickerSelectionChangedArgs.value);
  }

  Future OpenDialogue() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Dailoge"),
          content: Text("My name"),
        ),
      );
}

Widget _buildTextField(String label1, String labe2) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        border: Border.all(color: kGray),
        borderRadius: BorderRadius.circular(5)),
    width: 160,
    height: 60,
    child: FlatButton(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label1,
              style: TextStyle(color: kGray),
            ),
            Spacer(),
            Text(labe2, style: AppStyle.kBodyRegular.copyWith(color: kBlack)),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        onPressed: () {}),
  );
}

_displayDialog(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('TextField AlertDemo'),
          content: Container(
            margin: EdgeInsets.all(25),
            child: FlatButton(
              child: SfDateRangePicker(
                backgroundColor: kWhite,
                toggleDaySelection: true,
                view: DateRangePickerView.year,
                // onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.single,
                initialSelectedRange: PickerDateRange(
                    DateTime.now().subtract(const Duration(days: 4)),
                    DateTime.now().add(const Duration(days: 3))),
              ),
              color: Colors.blueAccent,
              textColor: Colors.white,
              onPressed: () {},
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
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
