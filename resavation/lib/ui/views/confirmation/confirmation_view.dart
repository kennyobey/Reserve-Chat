import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/confirmation/confirmation_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ConfirmationView extends StatelessWidget {
  const ConfirmationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ConfirmationViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: ResavationAppBar(
          title: "Rent Successful",
        ),
        body: Center(
          child: Text(
            'Confirmation View',
            style: AppStyle.kHeading1,
          ),
        ),
      ),
      viewModelBuilder: () => ConfirmationViewModel(),
    );
  }
}
