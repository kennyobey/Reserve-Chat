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
                      style: AppStyle.kBodyBold,
                    ),
                  ),
                  verticalSpaceMedium,
                  Text(
                    'Payment Type',
                    style: AppStyle.kBodyBold,
                  ),
                  verticalSpaceTiny,
                  ResavationTextField(
                    hintText: 'Ease Subscription',
                  ),
                  Text(
                    'Choose your ease subscription type',
                    style: AppStyle.kBodyRegular,
                  ),
                  Text(
                    '(You can select more than one)',
                    style: AppStyle.kBodyRegular,
                  ),
                  verticalSpaceTiny,
                  ResavationTextField(
                    hintText: 'Select',
                  ),
                  verticalSpaceTiny,
                  Text(
                    'Avalability Period',
                    style: AppStyle.kBodyBold,
                  ),
                  verticalSpaceTiny,
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(25),
                        child: FlatButton(
                          child: SfDateRangePicker(
                            view: DateRangePickerView.month,
                            onSelectionChanged: _onSelectionChanged,
                            selectionMode: DateRangePickerSelectionMode.single,
                            initialSelectedRange: PickerDateRange(
                                DateTime.now()
                                    .subtract(const Duration(days: 4)),
                                DateTime.now().add(const Duration(days: 3))),
                          ),
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  verticalSpaceTiny,
                  Text(
                    'Space Price',
                    style: AppStyle.kBodyBold,
                  ),
                  verticalSpaceTiny,
                  Text(
                    'What is the monthly rent of this unit?',
                    style: AppStyle.kBodyRegular,
                  ),
                  verticalSpaceTiny,
                  ResavationTextField(
                    hintText: '# 100,000',
                  ),
                  verticalSpaceTiny,
                  Text(
                    'What is the quarterlet rent of this unit?',
                    style: AppStyle.kBodyRegular,
                  ),
                  verticalSpaceTiny,
                  ResavationTextField(
                    hintText: '# 300,000',
                  ),
                  verticalSpaceTiny,
                  Text(
                    'What is the biannual rent of this unit?',
                    style: AppStyle.kBodyRegular,
                  ),
                  verticalSpaceTiny,
                  ResavationTextField(
                    hintText: '# 600,000',
                  ),
                  verticalSpaceTiny,
                  verticalSpaceTiny,
                  Text(
                    'What is the annual rent of this unit?',
                    style: AppStyle.kBodyRegular,
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
                          style: AppStyle.kBodyRegular,
                        ),
                        color: kWhite,
                        textColor: kBlack,
                        onPressed: () {},
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
}

Widget _buildTextField(String label) {
  String? label;
  const maxLines = 5;
  return Container(
    width: 140,
    height: maxLines * 12.0,
    child: const TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: ("From"),
        isDense: true, // Added this
        //contentPadding: EdgeInsets.all(8), // Added this
      ),
    ),
  );
}
