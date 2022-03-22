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
                  style: AppStyle.kHeading0,
                ),
                verticalSpaceLarge,
                Text(
                  'Last Name',
                  style: AppStyle.kBodyRegularBlack14,
                ),
                ResavationTextField(
                  hintText: 'Ameh',
                  textInputAction: TextInputAction.next,
                ),
                verticalSpaceSmall,
                Text(
                  'First Name',
                  style: AppStyle.kBodyRegularBlack14,
                ),
                ResavationTextField(
                  textInputAction: TextInputAction.next,
                  hintText: 'Queen',
                ),
                verticalSpaceSmall,
                Text(
                  'Email',
                  style: AppStyle.kBodyRegularBlack14,
                ),
                ResavationTextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'queenameh@gmail.com',
                ),
                verticalSpaceSmall,
                Text(
                  'Password',
                  style: AppStyle.kBodyRegularBlack14,
                ),
                ResavationTextField(
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  hintText: 'password',
                ),
                verticalSpaceSmall,
                Text(
                  'Verify Password',
                  style: AppStyle.kBodyRegularBlack14,
                ),
                ResavationTextField(
                  obscureText: true,
                  hintText: 'Verify password',
                  textInputAction: TextInputAction.done,
                ),
                verticalSpaceSmall,
                Text(
                  'Account type',
                  style: AppStyle.kBodyRegularBlack14,
                ),
                Container(
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: "Property Owner",
                            groupValue: model.userType,
                            onChanged: (value){
                              model.onRadioChanged(value.toString());
                            },
                          ),
                          Text("Property Owner", style: AppStyle.kBodyRegularBlack14,)
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: "Tenant",
                            groupValue: model.userType,
                            onChanged: (value){
                              model.onRadioChanged(value.toString());
                            },
                          ),
                          Text("Tenant", style: AppStyle.kBodyRegularBlack14,)
                        ],
                      ),

                    ],
                  ),
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
                    Expanded(
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: 'I agree to the ', style: AppStyle.kBodyRegularBlack14
                          ),
                          TextSpan(
                            text: 'Terms & Condition',
                            style: AppStyle.kBodyRegularBlack14.copyWith(
                              color: kPrimaryColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                //TODO: add funtionality to T&C
                              },
                          ),
                        ]),
                        style: AppStyle.kBodyRegularBlack14,
                      ),
                    ),
                  ],
                ),
                verticalSpaceMedium,
                ResavationButton(
                  width: MediaQuery.of(context).size.width,
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
                          style: AppStyle.kBodyRegularBlack14,
                        ),
                        TextSpan(
                          text: 'sign in',
                          style: AppStyle.kBodyRegularBlack14.copyWith(
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
