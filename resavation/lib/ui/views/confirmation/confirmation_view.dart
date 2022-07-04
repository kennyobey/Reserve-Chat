import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_app_bar.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/spacing.dart';
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Congratulations',
                style: AppStyle.kHeading1,
              ),
              verticalSpaceSmall,
              Text(
                'You have successfully rented your apartment',
                style: AppStyle.kBodySmallRegular,
              ),
              verticalSpaceMedium,
              ResavationButton(
                title: 'Back to home',
                onTap: model.goToMainView,
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => ConfirmationViewModel(),
    );
  }
}
