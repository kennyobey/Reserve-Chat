import 'package:flutter/material.dart';
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
  List<Widget> buildEmailField(LogInViewModel model) {
    return [
      Text(
        'Email',
        style: AppStyle.kBodyRegularBlack14,
      ),
      ResavationTextField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        controller: model.emailController,
        validator: (value) {
          bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@+[a-zA-Z0-9]+\.[a-zA-Z]")
              .hasMatch(value ?? "");

          if (value == null || value.isEmpty) {
            return 'Please provide your email.';
          } else if (!emailValid) {
            return 'Please enter a valid email';
          }
          return null;
        },
        hintText: 'yourname@gmail.com',
      ),
      verticalSpaceSmall,
    ];
  }

  List<Widget> buildPasswordField(LogInViewModel model) {
    return [
      Text(
        'Password',
        style: AppStyle.kBodyRegularBlack14,
      ),
      ResavationTextField(
          textInputAction: TextInputAction.done,
          obscureText: true,
          controller: model.passwordController,
          hintText: 'password',
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter password";
            } else if (value.length < 8) {
              return "Password must be at least 8 characters long";
            } else {
              return null;
            }
          }),
      verticalSpaceMedium,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LogInViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: BackButton(
            color: Colors.black,
          ),
          title: Text(
            'Log In',
            style: AppStyle.kHeading0,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: model.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceMedium,
                ...buildEmailField(model),
                ...buildPasswordField(model),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(),
                    TextButton(
                      onPressed: model.goToResetPasswordView,
                      child: Text(
                        'Forgot Password?',
                        style: AppStyle.kBodySmallRegular.copyWith(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpaceSmall,
                ResavationButton(
                  title: 'Log In',
                  isLoadingEnabled: model.isLoading,
                  width: MediaQuery.of(context).size.width,
                  onTap: () async {
                    final isValid = model.loginFormKey.currentState?.validate();
                    if ((isValid ?? false) == false || model.isLoading) {
                      return;
                    }

                    try {
                      final bool isUserVerified =
                          await model.onLoginButtonTap();
                      if (isUserVerified) {
                        model.goToMainView();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Account not verifed, please verify your account'),
                          ),
                        );
                        model.goToVerifyAccount();
                      }
                    } catch (exception) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(exception.toString()),
                        ),
                      );
                    }
                  },
                ),
                verticalSpaceLarge,
                ResavationTextSpan(
                  leading: "Don't have an account? ",
                  trailing: 'Sign up',
                  onTap: model.goToSignUpView,
                ),
                verticalSpaceMedium,
                buildTermsAndConditions(context),
                verticalSpaceMedium,
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => LogInViewModel(),
    );
  }

  Widget buildTermsAndConditions(BuildContext context) {
    final bodyText2 =
        Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14);
    return InkWell(
      onTap: () async {
        /*    try {
          const url = "https://boxin.ng/BOXIN%20PRIVACY%20POLICY.pdf";
          await launchUrlString(url);
        } catch (_) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  'Error occurred in opening T&C, please send a message to support@boxin.ng')));
        } */
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Terms',
              style: bodyText2.copyWith(
                color: kPrimaryColor,
              ),
            ),
            Text(' and ', style: bodyText2),
            Text(
              'Conditions',
              style: bodyText2.copyWith(
                color: kPrimaryColor,
              ),
            ),
            Text(' of use', style: bodyText2),
          ],
        ),
      ),
    );
  }
}
