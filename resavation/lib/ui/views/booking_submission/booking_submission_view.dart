import 'package:flutter/material.dart';
import 'package:resavation/services/core/paystack_payment.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/booking_submission/booking_submission_viewmodel.dart';
import 'package:stacked/stacked.dart';

class BookingSubmissionView extends StatelessWidget {
  const BookingSubmissionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookingSubmissionViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: ResavationAppBar(
          title: "Booking Details",
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  children: [
                    verticalSpaceMedium,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Eleko Estate',
                                style: AppStyle.kBodyBold,
                              ),
                              Text(
                                'Lekki, Lagos',
                                style: AppStyle.kBodyRegular,
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(shape: BoxShape.rectangle, color: kGray),
                          ),
                        ],
                      ),
                    ),
                    verticalSpaceMedium,
                    Divider(),
                    verticalSpaceMedium,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Name',
                                style: AppStyle.kBodyBold,
                              ),
                              Spacer(),
                              Text(
                                'Eleko Estate',
                                style: AppStyle.kBodyRegular,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Date',
                                style: AppStyle.kBodyBold,
                              ),
                              Spacer(),
                              Text(
                                '15/12/2021 - 15/12/2022',
                                style: AppStyle.kBodyRegular,
                              ),
                              horizontalSpaceSmall,
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Edit',
                                  style: AppStyle.kBodyRegular.copyWith(color: kPrimaryColor),
                                ),
                              ),
                            ],
                          ),
                          verticalSpaceMedium,
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(shape: BoxShape.rectangle, color: kGray),
                            child: Text(
                              'Number of Day: 365',
                              style: AppStyle.kBodyRegular,
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpaceMedium,
                    Divider(),
                    verticalSpaceMedium,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Coupon Code',
                            style: AppStyle.kBodyBold,
                          ),
                          Row(
                            children: [
                              Expanded(flex: 3, child: ResavationTextField()),
                              Expanded(
                                child: ResavationButton(
                                  title: 'APPLY',
                                  onTap: () {},
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    verticalSpaceMedium,
                    Divider(),
                    verticalSpaceMedium,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          PaymentDetails(
                            tiltle: 'Discount',
                            percentage: '10%',
                          ),
                          PaymentDetails(
                            tiltle: 'Subtotal',
                            percentage: '900,00',
                          ),
                          PaymentDetails(
                            tiltle: 'Extra Price',
                            percentage: '0',
                          ),
                          PaymentDetails(
                            tiltle: 'Tax',
                            percentage: '0%',
                          ),
                          verticalSpaceSmall,
                          PaymentDetails(
                            tiltle: 'Payment Amount',
                            percentage: '900,00',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            verticalSpaceMedium,
            ResavationButton(
              title: 'Continue',
              onTap: (){
                String email = "ogundipeibukun51@gmail.com";
                int price = 900;
                MakePayment(ctx: context, email: email, price: price)
                    .chargeCardAndMakePayment();
                model.goToConfirmationView();
              },
            ),
            verticalSpaceMedium,
          ],
        ),
      ),
      viewModelBuilder: () => BookingSubmissionViewModel(),
    );
  }
}

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({
    Key? key,
    required this.tiltle,
    required this.percentage,
  }) : super(key: key);

  final String tiltle;
  final String percentage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          tiltle,
          style: AppStyle.kBodyBold,
        ),
        Spacer(),
        Text(
          percentage,
          style: AppStyle.kBodyRegular,
        ),
      ],
    );
  }
}
