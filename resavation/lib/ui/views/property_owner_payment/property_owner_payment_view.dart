import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_payment/property_owner_payment_viewModel.dart';
import 'package:resavation/ui/views/property_owner_payment/subscription.dart';
import 'package:stacked/stacked.dart';

import '../../shared/dump_widgets/resavation_app_bar.dart';
import '../../shared/dump_widgets/resavation_elevated_button.dart';

class DateContainer extends StatelessWidget {
  final String label;

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Function(DateTime) onPressed;
  const DateContainer({
    Key? key,
    required this.label,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        verticalSpaceSmall,
        Text(
          label,
          style: AppStyle.kBodyRegularBlack15W500,
        ),
        verticalSpaceSmall,
        const Divider(),
        verticalSpaceSmall,
        CalendarDatePicker(
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
          onDateChanged: onPressed,
        ),
      ],
    );
  }
}

class PropertyOwnerPaymentView extends StatefulWidget {
  PropertyOwnerPaymentView({Key? key}) : super(key: key);

  @override
  State<PropertyOwnerPaymentView> createState() =>
      _PropertyOwnerPaymentViewState();
}

class _PropertyOwnerPaymentViewState extends State<PropertyOwnerPaymentView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerPaymentViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: ResavationAppBar(
          title: "Step 2",
          centerTitle: false,
          backEnabled: false,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ResavationElevatedButton(
                  child: Text("Back"),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              horizontalSpaceMedium,
              Expanded(
                child: ResavationElevatedButton(
                    child: Text("Next"),
                    onPressed: () {
                      if (model.selectedSubscriptions.isNotEmpty) {
                        if (model.displayPrice != null &&
                            model.displayPrice!.isNotEmpty) {
                          if (model.isVerified()) {
                            if (model.startDate.millisecondsSinceEpoch <
                                model.endDate.millisecondsSinceEpoch) {
                              model.goToPropertyOwnerAmenitiesView();
                            } else {
                              ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Kindly select a valid availability period'),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Kindly enter the price for each plan '),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                            const SnackBar(
                              content: Text('Please select your display price'),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                          const SnackBar(
                            content:
                                Text('Please select your subscription plan'),
                          ),
                        );
                      }
                    }
                    //=> model.goToPropertyOwnerAddPhotosView(),
                    ),
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Type',
                  style: AppStyle.kBodyRegularBlack16W600,
                ),
                verticalSpaceTiny,
                Text(
                  'Choose your ease subscription type (You can select more than one) ',
                  style: AppStyle.kBodyRegularBlack14,
                ),
                verticalSpaceTiny,
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () async {
                    final subscriptions = await showDialog<List<String>>(
                          context: context,
                          builder: (_) => MultiSelectDialog(
                            question: Text('Select Your Subcription Plan(s)'),
                            answers: model.subscriptionType,
                            previousAnswers: model.selectedSubscriptions,
                          ),
                        ) ??
                        [];
                    model.setSelectedSubscriptions(subscriptions);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        top: 10, left: 8, right: 8, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(children: [
                      Expanded(
                        child: Text(model.getTitle(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: true,
                            textAlign: TextAlign.start),
                      ),
                      Icon(
                        Icons.arrow_drop_down_rounded,
                        color: Colors.grey,
                      ),
                    ]),
                  ),
                ),
                verticalSpaceSmall,
                if (model.selectedSubscriptions.isNotEmpty)
                  ...buildSpacePrice(model),
                verticalSpaceMedium,
                /*       const Divider(),
                verticalSpaceSmall,
                Text(
                  'Availability Period',
                  style: AppStyle.kBodyRegularBlack14W500,
                ),
                verticalSpaceSmall,
                const Divider(),
                verticalSpaceSmall, */

                DateContainer(
                  label: 'Availability Period (Start)',
                  initialDate: model.startDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(model.startDate.year + 5),
                  onPressed: model.selectStartDate,
                ),
                verticalSpaceSmall,
                DateContainer(
                  label: 'Availability Period (End)',
                  initialDate: model.startDate,
                  firstDate: model.startDate,
                  lastDate: DateTime(model.startDate.year + 5),
                  onPressed: model.selectEndDate,
                ),
                verticalSpaceSmall,
                const Divider(),
                verticalSpaceMassive,
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PropertyOwnerPaymentViewModel(),
    );
  }

  List<Widget> buildAnnualFIeld(PropertyOwnerPaymentViewModel model) {
    return [
      Text(
        'What is the annual rent of this unit?',
        style: AppStyle.kBodySmallRegular12W500,
      ),
      verticalSpaceTiny,
      ResavationTextField(
        onlyNumbers: true,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        controller: model.propertyannualPriceController,
      ),
    ];
  }

  List<Widget> buildBiannualField(PropertyOwnerPaymentViewModel model) {
    return [
      Text(
        'What is the biannual rent of this unit?',
        style: AppStyle.kBodySmallRegular12W500,
      ),
      verticalSpaceTiny,
      ResavationTextField(
        onlyNumbers: true,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        controller: model.propertybiannualPriceController,
      ),
      verticalSpaceTiny,
    ];
  }

  List<Widget> buildMonthlyField(PropertyOwnerPaymentViewModel model) {
    return [
      Text(
        'What is the monthly rent of this unit?',
        style: AppStyle.kBodySmallRegular12W500,
      ),
      verticalSpaceTiny,
      ResavationTextField(
        onlyNumbers: true,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        controller: model.propertymonthlyPriceController,
      ),
      verticalSpaceTiny,
    ];
  }

  List<Widget> buildQuartely(PropertyOwnerPaymentViewModel model) {
    return [
      Text(
        'What is the quarterlet rent of this unit?',
        style: AppStyle.kBodySmallRegular12W500,
      ),
      verticalSpaceTiny,
      ResavationTextField(
        onlyNumbers: true,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        controller: model.propertyquaterlylPriceController,
      ),
      verticalSpaceTiny,
    ];
  }

  List<Widget> buildSpacePrice(PropertyOwnerPaymentViewModel model) {
    return [
      Text(
        'Space Price',
        style: AppStyle.kBodyRegularBlack14W500,
      ),
      verticalSpaceSmall,
      const Divider(),
      verticalSpaceSmall,
      if (model.selectedSubscriptions.contains('Monthly'))
        ...buildMonthlyField(model),
      if (model.selectedSubscriptions.contains('Quarterly'))
        ...buildQuartely(model),
      if (model.selectedSubscriptions.contains('Biannually'))
        ...buildBiannualField(model),
      if (model.selectedSubscriptions.contains('Annually'))
        ...buildAnnualFIeld(model),
      const Divider(),
      verticalSpaceSmall,
      Text(
        "Display Price",
        style: AppStyle.kBodyRegularBlack15W500,
      ),
      verticalSpaceSmall,
      const Divider(),
      verticalSpaceSmall,
      Text(
        'Please choose one of the subscription costs as your preferred pricing; this price will be shown to the user first. ',
        style: AppStyle.kBodyRegularBlack14,
      ),
      verticalSpaceTiny,
      InkWell(
        splashColor: Colors.transparent,
        onTap: () async {
          final price = await showDialog<String?>(
                context: context,
                builder: (_) => SingleSelectDialog(
                  question: Text('Select Display Price'),
                  initialAnswer: model.displayPrice,
                  choices: model.selectedSubscriptions,
                ),
              ) ??
              [];
          model.setDisplayPrice(price);
        },
        child: Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(children: [
            Expanded(
              child: Text(
                  model.displayPrice == null || model.displayPrice!.isEmpty
                      ? 'Select Display Price'
                      : model.displayPrice!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: true,
                  textAlign: TextAlign.start),
            ),
            Icon(
              Icons.arrow_drop_down_rounded,
              color: Colors.grey,
            ),
          ]),
        ),
      ),
    ];
  }
}
