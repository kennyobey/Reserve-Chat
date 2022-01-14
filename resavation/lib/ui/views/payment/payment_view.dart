import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
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
        body: Center(
          child: Text(
            'Data Picker',
            style: AppStyle.kHeading1,
          ),
        ),
      ),
      viewModelBuilder: () => PaymentViewModel(),
    );
  }
}
