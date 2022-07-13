import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/date_picker/date_picker_viewmodel.dart';
import 'package:stacked/stacked.dart';

class DatePickerView extends StatelessWidget {
  final Property property;
  const DatePickerView({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DatePickerViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: ResavationAppBar(
            title: "Apply For Rent",
            centerTitle: false,
            backEnabled: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: model.isLoading
                ? buildLoadingWidget()
                : model.hasError
                    ? buildErrorBody(context)
                    : model.isNotValid
                        ? buildInvalidWidget(context)
                        : buildBody(model, context),
          ),
        );
      },
      viewModelBuilder: () => DatePickerViewModel(property),
    );
  }

  Widget buildLoadingWidget() {
    return Container(
      height: 500,
      width: double.infinity,
      alignment: Alignment.center,
      child: SizedBox(
        height: 40,
        width: 40,
        child: CircularProgressIndicator.adaptive(
          backgroundColor: Colors.blue,
          valueColor: AlwaysStoppedAnimation(kWhite),
        ),
      ),
    );
  }

  Widget buildErrorBody(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        Text(
          'Error occurred!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'An error occured with the data fetch, please try again later',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const Spacer(),
      ],
    );
  }

  Widget buildInvalidWidget(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bodyText1 = textTheme.bodyText1!
        .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
    final bodyText2 = textTheme.bodyText2!.copyWith(fontSize: 14);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        Text(
          'Property Unavailiable!',
          style: bodyText1,
        ),
        const SizedBox(
          height: 5,
          width: double.infinity,
        ),
        Text(
          'The current property is no longer available for payment; please contact the owner for further information on the chosen property.',
          textAlign: TextAlign.center,
          style: bodyText2,
        ),
        const Spacer(),
      ],
    );
  }

  Column buildBody(DatePickerViewModel model, BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                verticalSpaceTiny,
                Text(
                  'Check In Date',
                  style: AppStyle.kBodyRegularBlack16W600,
                ),
                verticalSpaceTiny,
                Text(
                  'Please select the date you would love to check in to this property',
                  style: AppStyle.kBodyRegularBlack14,
                ),
                verticalSpaceTiny,
                const Divider(),
                verticalSpaceSmall,
                CalendarDatePicker(
                  initialDate: model.startDate,
                  firstDate: model.startDate,
                  lastDate: model.endDate,
                  onDateChanged: model.setSelectedDate,
                ),
                verticalSpaceMedium,
                const Divider(),
                verticalSpaceTiny,
                Text(
                  'Payment Plan',
                  style: AppStyle.kBodyRegularBlack16W600,
                ),
                verticalSpaceTiny,
                Text(
                  'Please choose the payment plan you want to subscribe to; payment options vary depending on owner data.',
                  style: AppStyle.kBodyRegularBlack14,
                ),
                verticalSpaceTiny,
                const Divider(),
                verticalSpaceSmall,
                if (property.subscription?.monthlyPrice != null &&
                    property.subscription?.monthlyPrice != 0)
                  PaymentChoiceListTile(
                    title: 'Monthly',
                    value: ChoiceOfPayment.Monthly,
                    subTitle: 'Every month you pay',
                    amount: property.subscription?.monthlyPrice ?? 0,
                  ),
                if (property.subscription?.quarterlyPrice != null &&
                    property.subscription?.quarterlyPrice != 0)
                  PaymentChoiceListTile(
                    title: 'Quartely',
                    value: ChoiceOfPayment.Quartely,
                    subTitle: 'Every 4th month you pay',
                    amount: property.subscription?.quarterlyPrice ?? 0,
                  ),
                if (property.subscription?.biannualPrice != null &&
                    property.subscription?.biannualPrice != 0)
                  PaymentChoiceListTile(
                    title: 'Biannual',
                    value: ChoiceOfPayment.Biannually,
                    subTitle: 'Every half year you pay',
                    amount: property.subscription?.biannualPrice ?? 0,
                  ),
                if (property.subscription?.annualPrice != null &&
                    property.subscription?.annualPrice != 0)
                  PaymentChoiceListTile(
                    title: 'Annual',
                    value: ChoiceOfPayment.Annually,
                    subTitle: 'Every year you pay',
                    amount: property.subscription?.annualPrice ?? 0,
                  ),
              ],
            ),
          ),
        ),
        verticalSpaceSmall,
        SizedBox(
          width: double.infinity,
          child: ResavationElevatedButton(
            child: Text('Continue'),
            onPressed: () {
              if (model.selectedDate != null) {
                if (model.paymentChoice != null) {
                  model.goToBookingSubmissionView(property);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Kindly select your preferred payment option'),
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Please select the day you would love to check in to this building'),
                  ),
                );
              }
            },
          ),
        ),
      ],
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
  final double amount;
  final ChoiceOfPayment value;
  final String subTitle;

  @override
  Widget build(BuildContext context, model) {
    final oCcy = NumberFormat("#,##0.00", "en_US");

    return InkWell(
      onTap: () => model.onPaymentChoiceChanged(value),
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
          groupValue: model.paymentChoice,
          value: value,
          onChanged: (_) => model.onPaymentChoiceChanged(value),
        ),
      ),
    );
  }
}
