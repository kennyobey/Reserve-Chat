import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_elevated_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_searchbar.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/booking_submission/booking_submission_viewmodel.dart';
import 'package:resavation/ui/views/date_picker/date_picker_viewmodel.dart';
import 'package:stacked/stacked.dart';

class BookingSubmissionView extends StatelessWidget {
  final Property property;
  final ChoiceOfPayment choiceOfPayment;
  final DateTime startDate;

  const BookingSubmissionView({
    Key? key,
    required this.property,
    required this.startDate,
    required this.choiceOfPayment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookingSubmissionViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: ResavationAppBar(
          title: "Booking Details",
          centerTitle: false,
          backEnabled: true,
        ),
        body: buildBody(context, model),
      ),
      viewModelBuilder: () => BookingSubmissionViewModel(),
    );
  }

  Column buildBody(BuildContext context, BookingSubmissionViewModel model) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                verticalSpaceTiny,
                Text(
                  'Property Description',
                  style: AppStyle.kBodyRegularBlack16W600,
                ),
                verticalSpaceTiny,
                const Divider(),
                verticalSpaceTiny,
                buildDescription(),
                verticalSpaceMedium,
                buildCheckInDate(context),
                verticalSpaceMedium,
                buildCouponCode(),
                verticalSpaceMedium,
                const Divider(),
                verticalSpaceTiny,
                Text(
                  'Payment Summary',
                  style: AppStyle.kBodyRegularBlack16W600,
                ),
                verticalSpaceTiny,
                const Divider(),
                verticalSpaceMedium,
                buildTotal(),
                verticalSpaceMassive,
              ],
            ),
          ),
        ),
        verticalSpaceSmall,
        buildContinueButton(context, model),
        verticalSpaceSmall,
      ],
    );
  }

  Widget buildTotal() {
    final oCcy = NumberFormat("#,##0.00", "en_US");

    final subscription = property.subscription;
    double amount = 0;

    if (choiceOfPayment == ChoiceOfPayment.Monthly) {
      amount = subscription?.monthlyPrice ?? 0;
    } else if (choiceOfPayment == ChoiceOfPayment.Quartely) {
      amount = subscription?.quarterlyPrice ?? 0;
    } else if (choiceOfPayment == ChoiceOfPayment.Biannually) {
      amount = subscription?.biannualPrice ?? 0;
    } else if (choiceOfPayment == ChoiceOfPayment.Annually) {
      amount = subscription?.annualPrice ?? 0;
    }

    return PaymentDetails(
      title: 'Payment Amount',
      percentage: '${String.fromCharCode(8358)} ${oCcy.format(amount)}',
      isTotal: true,
    );
  }

  Widget buildCouponCode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        verticalSpaceTiny,
        Text(
          'Coupon Code',
          style: AppStyle.kBodyRegularBlack16W600,
        ),
        verticalSpaceTiny,
        Text(
          'If you have a coupon code, please input it below; the coupon will be applied to your current payment. ',
          style: AppStyle.kBodyRegularBlack14,
        ),
        verticalSpaceMedium,
        ResavationSearchBar(
          text: '',
          hintText: 'Coupon',
        ),
      ],
    );
  }

  String dateAsString(DateTime? dateTime) {
    return '${dateTime?.day ?? ''}/${dateTime?.month ?? ''}/${dateTime?.year ?? ''}';
  }

  Widget buildCheckInDate(BuildContext context) {
    final startDateAsString = dateAsString(startDate);
    return Column(
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
          'Please keep in mind that this is subject to change as the landowner(s) decide whether or not to approve your request.',
          style: AppStyle.kBodyRegularBlack14,
        ),
        verticalSpaceMedium,
        Row(
          children: [
            Text(
              'Selected Date: ',
              style: AppStyle.kBodyRegularBlack15W500,
            ),
            Spacer(),
            Text(
              '${startDateAsString}',
              style: AppStyle.kBodyRegularBlack14,
            ),
            horizontalSpaceSmall,
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.edit,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDescription() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: ResavationImage(
            image: property.propertyImages?[0].imageUrl ?? '',
          ),
          height: 120,
          width: 120,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        horizontalSpaceTiny,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                property.propertyName ?? '',
                style: AppStyle.kBodyRegularBlack15W500,
              ),
              verticalSpaceTiny,
              Text(
                'Address: ' + (property.address ?? ''),
                style: AppStyle.kBodySmallRegular,
              ),
              Text(
                'City: ' + (property.city ?? ''),
                style: AppStyle.kBodySmallRegular,
              ),
              Text(
                'Country: ' + (property.country ?? ''),
                style: AppStyle.kBodySmallRegular,
              ),
              Text(
                'Surface Area: ' + (property.surfaceArea?.toString() ?? ''),
                style: AppStyle.kBodySmallRegular,
              ),
              Text(
                'Payment Option: ' + (choiceOfPayment.name),
                style: AppStyle.kBodySmallRegular,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildContinueButton(
      BuildContext context, BookingSubmissionViewModel model) {
    return Container(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      width: double.infinity,
      child: ResavationElevatedButton(
        child: Text('Book Property'),
        onPressed: () async {
          final shouldBook = await showConfirmationDialog(context);
          if (shouldBook) {
            final wasSuceessful = await showUploadItemDialog(context, model);
            if (wasSuceessful) {
              showSucessDialog(context, model);
            }
          }
        },
      ),
    );
  }

  showSucessDialog(
      BuildContext context, BookingSubmissionViewModel model) async {
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
              'Property Booked',
              style: AppStyle.kBodyRegularBlack16W600,
            ),
            verticalSpaceTiny,
            Text(
              'The property has been successfully reserved; you will be contacted once the owners have confirmed it. ',
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
      barrierLabel: "Book Property Success",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => dialog,
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      ),
    );

    model.goToHomePage();
  }

  Future<bool> showUploadItemDialog(
      BuildContext context, BookingSubmissionViewModel model) async {
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
              'Property Booking',
              style: AppStyle.kBodyRegularBlack16W600,
            ),
            verticalSpaceTiny,
            Text(
              'Booking propery, please do not cancel this screen',
              textAlign: TextAlign.center,
              style: AppStyle.kBodyRegularBlack14,
            ),
          ],
        ),
      )),
    );

    showGeneralDialog(
      context: context,
      barrierLabel: "Book Property",
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
      await model.bookProperty(
        property: property,
        choiceOfPayment: choiceOfPayment,
        startDate: startDate,
      );

      Navigator.of(context).pop();

      return true;
    } catch (exception) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            exception.toString(),
          ),
        ),
      );
      return false;
    }
  }

  Future<bool> showConfirmationDialog(BuildContext context) async {
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
              'Book Proerty',
              style: AppStyle.kBodyRegularBlack16W600,
            ),
            verticalSpaceTiny,
            Text(
              'Do you wish to book this property for later payment? ',
              textAlign: TextAlign.start,
              style: AppStyle.kBodyRegularBlack14,
            ),
            verticalSpaceSmall,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            )
          ],
        ),
      )),
    );

    final shouldBook = await showGeneralDialog<bool>(
      context: context,
      barrierLabel: "Confirm book property",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => dialog,
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      ),
    );
    return shouldBook ?? false;
  }

  makePayment() {
    /*     String email = model.email;
          int price = 0;
          bool userPaid =
              await MakePayment(ctx: context, email: email, price: price)
                  .chargeCardAndMakePayment();
          if (userPaid) {
            model.goToConfirmationView();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Payment Failed')),
            );
          } */
  }
}

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({
    Key? key,
    required this.title,
    this.isTotal = false,
    required this.percentage,
  }) : super(key: key);

  final String title;
  final bool isTotal;
  final String percentage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Text(
            title,
            style: !isTotal
                ? AppStyle.kBodyRegularBlack15
                : AppStyle.kBodyRegularBlack15W500,
          ),
          Spacer(),
          Text(
            percentage,
            style: !isTotal
                ? AppStyle.kBodyRegularBlack15
                    .copyWith(color: kBlack.withOpacity(0.8))
                : AppStyle.kBodyRegularBlack15W500,
          ),
        ],
      ),
    );
  }
}
