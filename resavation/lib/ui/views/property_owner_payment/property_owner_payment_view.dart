import 'package:flutter/material.dart';
import 'package:resavation/app/app.router.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/property_owner_payment/property_owner_payment_viewModel.dart';
import 'package:resavation/ui/views/property_owner_payment/subscription.dart';
import 'package:stacked/stacked.dart';

import '../../shared/colors.dart';
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
  Future<bool> showSaveConfirmationDialog() async {
    Dialog dialog = Dialog(
      backgroundColor: Colors.black,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      elevation: 5,
      child: Material(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Save property',
              style: AppStyle.kBodyRegularBlack16W600,
            ),
            verticalSpaceTiny,
            Text(
              'Do you wish to store your property for later editing? Your progress will be recovered when you upload again.',
              textAlign: TextAlign.start,
              style: AppStyle.kBodyRegularBlack14,
            ),
            verticalSpaceSmall,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    'Yes',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'No',
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );

    final shouldShow = await showGeneralDialog<bool>(
      context: context,
      barrierLabel: "Save property confirmation",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => dialog,
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      ),
    );
    if (shouldShow == null) {
      return false;
    } else {
      return shouldShow;
    }
  }

  showSavePropertyDialog(PropertyOwnerPaymentViewModel model) async {
    Dialog dialog = Dialog(
      backgroundColor: Colors.black,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      elevation: 5,
      child: Material(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.blue,
                valueColor: AlwaysStoppedAnimation(kWhite),
              ),
            ),
            verticalSpaceMedium,
            Text(
              'Saving Property',
              style: AppStyle.kBodyRegularBlack16W600,
            ),
            verticalSpaceTiny,
            Text(
              'Saving property, please do not cancel until success',
              textAlign: TextAlign.center,
              style: AppStyle.kBodyRegularBlack14,
            ),
          ],
        ),
      )),
    );

    showGeneralDialog(
      context: context,
      barrierLabel: "Saving Property",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => dialog,
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      ),
    );

    try {
      await model.saveStage4Data();

      Navigator.of(context).pop();
      showSucessDialog(model);
    } catch (exception) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while saving your data'),
        ),
      );
    }
  }

  showSucessDialog(PropertyOwnerPaymentViewModel model) async {
    Dialog dialog = Dialog(
      backgroundColor: Colors.black,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      elevation: 5,
      child: Material(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Property Saved',
              style: AppStyle.kBodyRegularBlack16W600,
            ),
            verticalSpaceTiny,
            Text(
              'Your property has been successfully saved and will be shown on your next property listing.',
              textAlign: TextAlign.start,
              style: AppStyle.kBodyRegularBlack14,
            ),
            verticalSpaceSmall,
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Okay',
                ),
              ),
            ),
          ],
        ),
      )),
    );

    await showGeneralDialog(
      context: context,
      barrierLabel: "Upload Property Success",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => dialog,
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      ),
    );

    model.uploadTypeService.clearStage1();
    model.navigationService.clearStackAndShow(Routes.mainView);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PropertyOwnerPaymentViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: ResavationAppBar(
          title: "Step 4",
          centerTitle: false,
          backEnabled: false,
          actions: [
            IconButton(
                onPressed: () async {
                  if (model.selectedSubscriptions.isNotEmpty) {
                    if (model.displayPrice != null &&
                        model.displayPrice!.isNotEmpty) {
                      if (model.isVerified()) {
                        if (model.startDate.millisecondsSinceEpoch <
                            model.endDate.millisecondsSinceEpoch) {
                          bool shouldSave = await showSaveConfirmationDialog();
                          if (shouldSave) {
                            showSavePropertyDialog(model);
                          }
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
                            content:
                                Text('Kindly enter the price for each plan '),
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
                        content: Text('Please select your subscription plan'),
                      ),
                    );
                  }
                },
                icon: Icon(
                  Icons.save_rounded,
                  color: kPrimaryColor,
                ))
          ],
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
