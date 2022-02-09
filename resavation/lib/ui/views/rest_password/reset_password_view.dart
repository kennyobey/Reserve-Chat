import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textspan.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/rest_password/reset_password_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResetPasswordViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceLarge,
                Center(
                  child: Text(
                    'Reset Password ',
                    style: AppStyle.kHeading1,
                  ),
                ),
                verticalSpaceMedium,
                Text(
                  "Enter the e-mail address associated with the account. We’ll e-mail a link to reset your password.",
                  style: AppStyle.kBodyRegular,
                ),
                verticalSpaceLarge,
                Text(
                  'Email',
                  style: AppStyle.kBodyRegular,
                ),
                ResavationTextField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  hintText: 'Email',
                ),
                verticalSpaceMedium,
                ResavationTextSpan(
                  leading: "Don't receive link? ",
                  trailing: 'Resend',
                  onTap: () {},
                ),
                verticalSpaceSmall,
                ResavationButton(
                  title: 'Send Reset Link',
                  onTap: model.goToLogin,
                ),
                verticalSpaceMassive,
                ResavationTextSpan(
                  leading: "Don't have an account? ",
                  trailing: 'Sign up',
                  onTap: model.goToSignUpView,
                ),
                verticalSpaceMassive,
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => ResetPasswordViewModel(),
    );
  }
}
