import 'package:flutter/material.dart';
import 'package:resavation/model/login_model.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textspan.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/login/login_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LogInView extends StatefulWidget {
  const LogInView({Key? key}) : super(key: key);

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  late LoginModel logIn;

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
                    controller: model.emailController,
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
                    controller: model.passwordController,
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
                    onTap: () async {
                      final String email = model.emailController.text;
                      final String password = model.passwordController.text;

                      LoginModel login = await model.loginUser(email, password);
                      //model.goToMainView();

                      @override
                      void initState() {
                        logIn = login;
                        super.initState();
                      }
                    },
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
