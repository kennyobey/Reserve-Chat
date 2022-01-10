import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/dump_widgets/signup_text.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/login/login_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

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
                    style: AppStyle.kHeading1,
                  ),
                  verticalSpaceLarge,
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
                  verticalSpaceMedium,
                  Row(
                    children: [
                      Checkbox(
                        activeColor: kPrimaryColor,
                        value: model.checkValue,
                        onChanged: model.onCheckChanged,
                      ),
                      Text(
                        'Remember me',
                        style: AppStyle.kBodyRegular,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: model.goToResetPasswordView,
                        child: Text(
                          'Forget Password?',
                          style: AppStyle.kBodyBold.copyWith(
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpaceLarge,
                  ResavationButton(
                    title: 'Log In',
                    onTap: model.goToMainView,
                  ),
                  verticalSpaceMassive,
                  SignUpText(
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
