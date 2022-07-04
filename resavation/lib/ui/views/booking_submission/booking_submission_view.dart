import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/services/core/paystack_payment.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_searchbar.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/booking_submission/booking_submission_viewmodel.dart';
import 'package:stacked/stacked.dart';

class BookingSubmissionView extends StatelessWidget {
  final Property property;
  final DateTime startDate;

  const BookingSubmissionView({
    Key? key,
    required this.property,
    required this.startDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ViewModelBuilder<BookingSubmissionViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: ResavationAppBar(
          title: "Booking Details",
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: [
                    buildDescription(),
                    verticalSpaceSmall,
                    Divider(),
                    verticalSpaceSmall,
                    buildItem2(context),
                    verticalSpaceSmall,
                    Divider(),
                    verticalSpaceSmall,
                    buildCouponCode(),
                    verticalSpaceSmall,
                    Divider(),
                    verticalSpaceSmall,
                    buildTotal(),
                  ],
                ),
              ),
            ),
            verticalSpaceSmall,
            buildContinueButton(width, context, model),
            verticalSpaceSmall,
          ],
        ),
      ),
      viewModelBuilder: () => BookingSubmissionViewModel(),
    );
  }

  Padding buildTotal() {
    final oCcy = NumberFormat("#,##0.00", "en_US");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          PaymentDetails(
            title: 'Discount',
            percentage: '0%',
          ),
          PaymentDetails(
              title: 'Subtotal',
              percentage:
                  '${String.fromCharCode(8358)} ${oCcy.format(property.spacePrice ?? 0)}'),
          PaymentDetails(
            title: 'Extra Price',
            percentage: '0',
          ),
          PaymentDetails(
            title: 'Tax',
            percentage: '0%',
          ),
          verticalSpaceSmall,
          PaymentDetails(
            title: 'Payment Amount',
            percentage:
                '${String.fromCharCode(8358)} ${oCcy.format(property.spacePrice ?? 0)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Padding buildCouponCode() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Coupon Code',
            style: AppStyle.kBodyRegularBlack15W500,
          ),
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: ResavationSearchBar(
                    text: '',
                  )),
              Expanded(
                  child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 48,
                  width: 40,
                  alignment: Alignment.center,
                  child: Text(
                    "APPLY",
                    style: AppStyle.kBodyRegularBlack14.copyWith(color: kWhite),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                    color: kPrimaryColor,
                  ),
                ),
              )),
            ],
          )
        ],
      ),
    );
  }

  String dateAsString(DateTime? dateTime) {
    return '${dateTime?.day ?? ''}/${dateTime?.month ?? ''}/${dateTime?.year ?? ''}';
  }

  Padding buildItem2(BuildContext context) {
    final DateTime? endDate = startDate.add(Duration(days: 365));

    final startDateAsString = dateAsString(startDate);
    final endDateAsString = dateAsString(endDate);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Name',
                style: AppStyle.kBodyRegularBlack15W500,
              ),
              Spacer(),
              Text(
                property.city ?? '',
                style: AppStyle.kBodyRegularBlack14,
              ),
            ],
          ),
          verticalSpaceTiny,
          Row(
            children: [
              Text(
                'Date',
                style: AppStyle.kBodyRegularBlack15W500,
              ),
              Spacer(),
              Text(
                '${startDateAsString} - ${endDateAsString}',
                style: AppStyle.kBodyRegularBlack14,
              ),
              horizontalSpaceSmall,
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Edit',
                  style: AppStyle.kBodyRegularBlack14
                      .copyWith(color: kPrimaryColor),
                ),
              ),
            ],
          ),
          verticalSpaceMedium,
          Container(
            alignment: Alignment.center,
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                color: kGray.withOpacity(0.15),
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              'Number of Day: 365',
              style: AppStyle.kBodyRegularBlack14,
            ),
          ),
        ],
      ),
    );
  }

  Padding buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  property.city ?? '',
                  style: AppStyle.kBodyRegularBlack15W500,
                ),
                verticalSpaceSmall,
                Text(
                  property.address ?? '',
                  style: AppStyle.kBodySmallRegular,
                ),
              ],
            ),
          ),
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
        ],
      ),
    );
  }

  ResavationButton buildContinueButton(
      double width, BuildContext context, BookingSubmissionViewModel model) {
    return ResavationButton(
      title: 'Continue',
      width: width - 20,
      onTap: () async {
        String email = model.email;
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
        }
      },
    );
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
