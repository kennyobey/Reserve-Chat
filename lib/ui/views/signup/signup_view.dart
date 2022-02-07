import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/signup/signup_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceMedium,
                Text(
                  'Sign Up',
                  style: AppStyle.kHeading1,
                ),
                verticalSpaceLarge,
                Text(
                  'Last Name',
                  style: AppStyle.kBodyRegular,
                ),
                ResavationTextField(
                  hintText: 'Ameh',
                ),
                verticalSpaceSmall,
                Text(
                  'First Name',
                  style: AppStyle.kBodyRegular,
                ),
                ResavationTextField(
                  hintText: 'Queen',
                ),
                verticalSpaceSmall,
                Text(
                  'Email',
                  style: AppStyle.kBodyRegular,
                ),
                ResavationTextField(
                  hintText: 'queenameh@gmail.com',
                ),
                verticalSpaceSmall,
                Text(
                  'Password',
                  style: AppStyle.kBodyRegular,
                ),
                ResavationTextField(
                  obscureText: true,
                  hintText: 'password',
                ),
                verticalSpaceSmall,
                Text(
                  'Verity Password',
                  style: AppStyle.kBodyRegular,
                ),
                ResavationTextField(
                  obscureText: true,
                  hintText: 'Verify password',
                ),
                verticalSpaceSmall,
                Row(
                  children: [
                    Checkbox(
                      activeColor: kPrimaryColor,
                      value: model.checkValue,
                      onChanged: model.onCheckChanged,
                    ),
                    horizontalSpaceSmall,
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: 'I agree to the ',
                        ),
                        TextSpan(
                          text: 'Terms & Condition',
                          style: AppStyle.kBodyBold.copyWith(
                            color: kPrimaryColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              //TODO: add funtionality to T&C
                            },
                        ),
                      ]),
                      style: AppStyle.kBodyRegular,
                    ),
                  ],
                ),
                verticalSpaceMedium,
                ResavationButton(
                  title: 'Sign Up',
                  onTap: model.goToMainView,
                ),
                verticalSpaceLarge,
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already a user? ',
                        ),
                        TextSpan(
                          text: 'Sign in',
                          style: AppStyle.kBodyBold.copyWith(
                            color: kPrimaryColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              model.goToLoginView();
                            },
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: AppStyle.kBodyRegular,
                  ),
                ),
                verticalSpaceMedium,
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SignUpViewModel(),
    );
  }
}
