import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/payment/payment_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: ResavationAppBar(
          title: "Payment Details",
        ),
        body: Column(
          children: [
            Center(
              child: Image.asset('resavation\assets\images\paymentcard.png'),
            ),
            verticalSpaceSmall,
            _buildTextField(
              "CardHolder Name",
            ),
            verticalSpaceTiny,
            _buildTextField("Card Number"),
            verticalSpaceTiny,
            Row(
              children: [
                _buildTextField('Expiry Date'),
                horizontalSpaceTiny,
                _buildTextField('Security Code'),
              ],
            )
          ],
        ),
      ),
      viewModelBuilder: () => PaymentViewModel(),
    );
  }
}

Widget _buildTextField(String labelText) {
  return Container(
    margin: EdgeInsets.all(12),
    child: TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        isDense: true,
        contentPadding: EdgeInsets.all(8),
      ),
    ),
  );
}
