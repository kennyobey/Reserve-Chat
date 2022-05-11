import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/date_picker/date_picker_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../model/property_model.dart';

class DatePickerView extends StatelessWidget {
  final Property? property;
  const DatePickerView({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DatePickerViewModel>.reactive(
      builder: (context, model, child) {
        final dateTime = DateTime.now();
        return Scaffold(
          appBar: ResavationAppBar(
            title: "Apply For Rent",
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              bottom: 10.0,
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpaceMedium,
                        Text(
                          'Please select the date you want to check in.',
                          style: AppStyle.kBodyBold,
                        ),
                        verticalSpaceMedium,
                        CalendarDatePicker(
                          initialDate: dateTime,
                          firstDate: dateTime,
                          lastDate: DateTime(dateTime.year + 1),
                          onDateChanged: model.setSelectedDate,
                        ),
                        verticalSpaceMedium,
                        Text(
                          'Choose payment',
                          style: AppStyle.kBodyRegularBlack15,
                        ),
                        PaymentChoiceListTile(
                          title: 'Monthly',
                          value: ChoiceOfPayment.Monthly,
                          subTitle: 'Every month you pay',
                          amount: 12000,
                        ),
                        PaymentChoiceListTile(
                          title: 'Annual',
                          value: ChoiceOfPayment.Annual,
                          subTitle: 'Every year you pay',
                          amount: property?.amountPerYear ?? 0,
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpaceSmall,
                ResavationButton(
                  title: 'Continue',
                  width: double.infinity,
                  onTap: () => model.goToBookingSubmissionView(property),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => DatePickerViewModel(),
    );
  }
}

class PaymentChoiceListTile extends ViewModelWidget<DatePickerViewModel> {
  const PaymentChoiceListTile({
    required this.amount,
    required this.subTitle,
    required this.title,
    required this.value,
  });

  final String title;
  final int amount;
  final ChoiceOfPayment value;
  final String subTitle;

  @override
  Widget build(BuildContext context, Model) {
    final oCcy = NumberFormat("#,##0.00", "en_US");
    return InkWell(
      onTap: () => Model.onPaymentChoiceChanged(value),
      splashColor: kGray,
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        title: Text(
          title,
          style: AppStyle.kBodyRegularBlack15,
        ),
        trailing: Text(
          '${String.fromCharCode(8358)}${oCcy.format(amount)}',
          style: AppStyle.kBodyRegularBlack15,
        ),
        subtitle: Text(
          subTitle,
          style: AppStyle.kBodySmallRegular,
        ),
        leading: Radio<ChoiceOfPayment>(
          groupValue: Model.paymentChoice,
          value: value,
          onChanged: Model.onPaymentChoiceChanged,
        ),
      ),
    );
  }
}
