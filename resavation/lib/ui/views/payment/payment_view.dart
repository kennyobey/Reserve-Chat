import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/payment/payment_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          appBar: ResavationAppBar(
            title: "Payment Details",
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 15,
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CreditCardWidget(
                          width: 200,
                          isHolderNameVisible: true,
                          obscureCardNumber: false,
                          cardHolderName: model.cardName,
                          expiryDate: model.expiryDate,
                          cardNumber: model.cardNumber,
                          onCreditCardWidgetChange: (CreditCardBrand) {},
                          showBackView: false,
                          cvvCode: model.cvvCode,
                        ),
                        ResavationTextField(
                          textInputAction: TextInputAction.next,
                          labelText: 'Cardholder name',
                          onChanged: model.onCardNameChanged,
                        ),
                        verticalSpaceMedium,
                        ResavationTextField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          labelText: 'Card number',
                        ),
                        verticalSpaceMedium,
                        Row(
                          children: [
                            Expanded(
                              child: ResavationTextField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.datetime,
                                labelText: 'Expiration date',
                              ),
                            ),
                            horizontalSpaceMedium,
                            Expanded(
                              child: ResavationTextField(
                                keyboardType: TextInputType.number,
                                labelText: 'Security code',
                              ),
                            ),
                          ],
                        ),
                        verticalSpaceMedium,
                        Row(
                          children: [
                            Checkbox(
                              value: model.isChecked,
                              onChanged: model.onCheckedChanged,
                            ),
                            Text(
                              'Save to card',
                              style: AppStyle.kBodyBold,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpaceMedium,
                ResavationButton(
                  title: 'Pay  \$ 115,000',
                  onTap: model.goToConfirmationView,
                )
              ],
            ),
          )),
      viewModelBuilder: () => PaymentViewModel(),
    );
  }
}
