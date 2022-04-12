import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/date_picker/date_picker_viewmodel.dart';
import 'package:stacked/stacked.dart';

class DatePickerView extends StatelessWidget {
  const DatePickerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DatePickerViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: ResavationAppBar(
          title: "Apply for rent",
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 15,
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
                        'Check in date',
                        style: AppStyle.kBodyBold,
                      ),
                      verticalSpaceMedium,
                      CalendarDatePicker(
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2025),
                        onDateChanged: (_) {},
                      ),
                      verticalSpaceMedium,
                      Text(
                        'Choose payment',
                        style: AppStyle.kBodyRegularBlack14,
                      ),
                      PaymentChoiceListTile(
                        title: 'Monthly',
                        value: ChoiceOfPayment.Monthly,
                        subTitle: 'Every month you pay',
                        trailing: '\$ 10,000',
                      ),
                      PaymentChoiceListTile(
                        title: 'Annual',
                        value: ChoiceOfPayment.Annual,
                        subTitle: 'Every year you pay',
                        trailing: '\$ 120,000',
                      ),

                    ],
                  ),
                ),
              ),

              ResavationButton(
                title: 'Continue',
                onTap: model.goToBookingSubmissiontView,
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => DatePickerViewModel(),
    );
  }
}

class PaymentChoiceListTile extends ViewModelWidget<DatePickerViewModel> {
  const PaymentChoiceListTile({
    required this.trailing,
    required this.subTitle,
    required this.title,
    required this.value,
  });

  final String title;
  final String trailing;
  final ChoiceOfPayment value;
  final String subTitle;

  @override
  Widget build(BuildContext context, Model) {
    return InkWell(
      onTap: () => Model.onPaymentChoiceChanged(value),
      splashColor: kGray,
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: Text(
                title,
                style: AppStyle.kBodyRegularBlack15,
              ),
              subtitle: Text(subTitle, style: AppStyle.kBodySmallRegular,),
              leading: Radio<ChoiceOfPayment>(
                groupValue: Model.paymentChoice,
                value: value,
                onChanged: Model.onPaymentChoiceChanged,
              ),
            ),
          ),
          horizontalSpaceMedium,
          Text(
            trailing,
            style: AppStyle.kBodyRegularBlack15,
          ),
        ],
      ),
    );
  }
}
