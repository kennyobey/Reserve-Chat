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
        hintText: 'queenameh@gmail.com',
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
                    InkWell(
                      splashColor: Colors.transparent,
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
                verticalSpaceMedium,
                ResavationButton(
                  title: 'Log In',
                  isLoadingEnabled: model.isLoading,
                  width: MediaQuery.of(context).size.width,
                  onTap: () async {
                    // final isValid = model.loginFormKey.currentState?.validate();
                    // if ((isValid ?? false) == false || model.isLoading) {
                    //   return;
                    // }

                    try {
                      // await model.onLoginButtonTap();
                      model.goToMainView();
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
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => LogInViewModel(),
    );
  }
}
