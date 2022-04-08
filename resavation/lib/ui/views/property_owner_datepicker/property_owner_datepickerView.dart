// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';

import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';

import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_datepicker/property_owner_datepickerViewModel.dart';

import 'package:stacked/stacked.dart';

class PropertyOwnerDatePickerView extends StatelessWidget {
  const PropertyOwnerDatePickerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerDatePickerViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            child: Column(
              children: [
                // SfDateRangePicker(
                //   backgroundColor: kWhite,
                //   toggleDaySelection: true,
                //   view: DateRangePickerView.year,
                //   // onSelectionChanged: _onSelectionChanged,
                //   selectionMode: DateRangePickerSelectionMode.single,
                //   initialSelectedRange: PickerDateRange(
                //       DateTime.now().subtract(const Duration(days: 4)),
                //       DateTime.now().add(const Duration(days: 3))),
                // ),
                CalendarDatePicker(
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2025),
                  onDateChanged: (DateTime) {
                    String date = DateTime.toString();
                    print("The picked date is $date");
                  },
                ),
                verticalSpaceRegular,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FlatButton(
                      child: Text(
                        'Cancel',
                        style: AppStyle.kBodyRegular,
                      ),
                      color: kPrimaryColor,
                      textColor: Colors.white,
                      onPressed: () {},
                    ),
                    Spacer(),
                    FlatButton(
                      child: Text(
                        'Ok',
                        style: AppStyle.kBodyRegular,
                      ),
                      color: kPrimaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        model.goToPropertyOwnerPaymentView();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerDatePickerViewModel(),
    );
  }
}
