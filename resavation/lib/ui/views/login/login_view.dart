import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textspan.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/login/login_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LogInView extends StatelessWidget {
  const LogInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LogInViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpaceMedium,
                  Text(
                    'Log In',
                    style: AppStyle.kHeading3,
                  ),
                  verticalSpaceLarge,
                  Text(
                    'Email',
                    style: AppStyle.kBodyRegularBlack14,
                  ),
                  ResavationTextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                    hintText: 'queenameh@gmail.com',
                  ),
                  verticalSpaceSmall,
                  Text(
                    'Password',
                    style: AppStyle.kBodyRegularBlack14,
                  ),
                  ResavationTextField(
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                    hintText: 'password',
                  ),
                  verticalSpaceMedium,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Checkbox(
                        activeColor: kPrimaryColor,
                        value: model.checkValue,
                        onChanged: model.onCheckChanged,
                      ),
                      Text(
                        'Remember me',
                        style: AppStyle.kBodyRegularBlack14,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: model.goToResetPasswordView,
                        child: Text(
                          'Forgot Password?',
                          style: AppStyle.kBodySmallRegular.copyWith(
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpaceLarge,
                  ResavationButton(
                    title: 'Log In',
                    width: MediaQuery.of(context).size.width,
                    onTap: model.goToMainView,
                  ),
                  verticalSpaceMassive,
                  ResavationTextSpan(
                    leading: "Don't have an account? ",
                    trailing: 'Sign up',
                    onTap: model.goToSignUpView,
                  ),
                  verticalSpaceMedium,
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => LogInViewModel(),
    );
  }
}
