import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textspan.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/rest_password/reset_password_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  List<Widget> buildEmailField(ResetPasswordViewModel model) {
    return [
      Text(
        'Email',
        style: AppStyle.kBodyRegularBlack14,
      ),
      ResavationTextField(
        textInputAction: TextInputAction.next,
        controller: model.emailFieldController,
        keyboardType: TextInputType.emailAddress,
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

  List<Widget> buildOTPField(ResetPasswordViewModel model) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return [
      Pinput(
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        submittedPinTheme: submittedPinTheme,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        controller: model.otpFieldController,
        /* validator: (s) {
        return s == '2222' ? null : 'Pin is incorrect';
      },*/
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: true,
        // onCompleted: (pin) => print(pin),
      ),
      verticalSpaceSmall,
    ];
  }

  List<Widget> buildPasswordField(ResetPasswordViewModel model) {
    return [
      Text(
        'Password',
        style: AppStyle.kBodyRegularBlack14,
      ),
      ResavationTextField(
        textInputAction: TextInputAction.next,
        controller: model.passwordFieldController,
        validator: (value) {
          model.userTypeService.confirmPass = value.toString();
          if (value!.isEmpty) {
            return "Please enter password";
          } else if (value.length < 8) {
            return "Password must be at least 8 characters long";
          } else {
            return null;
          }
        },
        obscureText: true,
        hintText: 'password',
      ),
      verticalSpaceSmall,
    ];
  }

  List<Widget> buildVerifyPasswordField(ResetPasswordViewModel model) {
    return [
      Text(
        'Verify Password',
        style: AppStyle.kBodyRegularBlack14,
      ),
      ResavationTextField(
        obscureText: true,
        hintText: 'Verify password',
        textInputAction: TextInputAction.done,
        controller: model.verifyPasswordFieldController,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please re-enter password";
          } else if (value.length < 8) {
            return "Password must be at least 8 characters long";
          } else if (value != model.userTypeService.confirmPass) {
            return "Password mismatch";
          } else {
            return null;
          }
        },
      ),
      verticalSpaceSmall,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResetPasswordViewModel>.reactive(
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          if (model.pagePosition != 0) {
            model.onPageChanged(model.pagePosition - 1);
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: BackButton(
              color: Colors.black,
            ),
            title: Text(
              'Reset Password',
              style: AppStyle.kHeading0,
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PageView(
                  controller: model.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    buildStage1Widget(model, context),
                    buildStage2Widget(model, context),
                    buildStage3Widget(model, context),
                  ],
                ),
              ),
              verticalSpaceMedium,
              buildBottomWidget(context, model),
              verticalSpaceMedium,
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
      viewModelBuilder: () => ResetPasswordViewModel(),
    );
  }

  Widget buildBottomWidget(BuildContext context, ResetPasswordViewModel model) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: AnimatedSwitcher(
        child: buildIndicators(model.pagePosition),
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeIn,
      ),
    );
  }

  Widget buildIndicators(int currentIndex) {
    List<int> indexes = [0, 1, 2];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indexes
          .map((index) => AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                margin: const EdgeInsets.only(right: 5),
                height: 8,
                width: (currentIndex == index) ? 50 : 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: (currentIndex == index)
                      ? Colors.blue
                      : Colors.black.withOpacity(0.2),
                ),
              ))
          .toList(),
    );
  }

  Widget buildStage1Widget(ResetPasswordViewModel model, BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Form(
        key: model.stage1FormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpaceMedium,
            Align(
              alignment: Alignment.center,
              child: Text(
                "Enter the e-mail address associated with the account. We’ll e-mail a code to reset your password.",
                style: AppStyle.kBodyRegularBlack14,
                textAlign: TextAlign.center,
              ),
            ),
            verticalSpaceMedium,
            ...buildEmailField(model),
            verticalSpaceMedium,
            ResavationButton(
              title: 'Send OTP',
              isLoadingEnabled: model.isStage1Loading,
              width: MediaQuery.of(context).size.width,
              onTap: () async {
                final isValid = model.stage1FormKey.currentState?.validate();
                if ((isValid ?? false) == false || model.isStage1Loading) {
                  return;
                }
                try {
                  await model.sendOTP();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('An OTP has been sent to your mail')),
                  );
                  model.onPageChanged(1);
                } catch (exception) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(exception.toString())),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStage2Widget(ResetPasswordViewModel model, BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          verticalSpaceMedium,
          Align(
            alignment: Alignment.center,
            child: Text(
              "Enter the OTP that was sent to your account.",
              style: AppStyle.kBodyRegularBlack14,
              textAlign: TextAlign.center,
            ),
          ),
          verticalSpaceLarge,
          ...buildOTPField(model),
          verticalSpaceLarge,
          ResavationButton(
            title: 'Proceed',
            width: MediaQuery.of(context).size.width,
            onTap: () async {
              //todo navigate to the next screen . add a will pop scope to page
              model.onPageChanged(2);
            },
          ),
        ],
      ),
    );
  }

  Widget buildStage3Widget(ResetPasswordViewModel model, BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Form(
        key: model.stage3FormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpaceMedium,
            Align(
              alignment: Alignment.center,
              child: Text(
                "Enter the new password for your account",
                style: AppStyle.kBodyRegularBlack14,
                textAlign: TextAlign.center,
              ),
            ),
            verticalSpaceMedium,
            ...buildPasswordField(model),
            ...buildVerifyPasswordField(model),
            verticalSpaceMedium,
            ResavationButton(
              title: 'Reset Password',
              isLoadingEnabled: model.isStage2Loading,
              width: MediaQuery.of(context).size.width,
              onTap: () async {
                final isValid = model.stage3FormKey.currentState?.validate();
                if ((isValid ?? false) == false) {
                  return;
                }
                try {
                  await model.sendResetPasswordLink();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Password reset successful, please proceed to login')),
                  );
                  model.goToLogin();
                } catch (exception) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(exception.toString())),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

/*  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          'Reset Password',
          style: AppStyle.kHeading0,
        ),
      ),
      body: ViewModelBuilder<ResetPasswordViewModel>.reactive(
        builder: (context, model, child) =>  SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: model.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceMedium,
                Text(
                  "Enter the e-mail address associated with the account. We’ll e-mail a link to reset your password.",
                  style: AppStyle.kBodyRegularBlack14,
                  textAlign: TextAlign.center,
                ),
                verticalSpaceMedium,
                ...buildEmailField(model),
                ...buildPasswordField(model),
                ...buildVerifyPasswordField(model),
                ...buildOTPField(model),
                verticalSpaceMedium,
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () async {
                      final emailStatus = model.verifyEmail();
                      if (emailStatus != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(emailStatus)),
                        );
                        return;
                      }
                      try {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Processing request, please wait')),
                        );
                        await model.sendOTP();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                              Text('An OTP has been sent to your mail')),
                        );
                      } catch (exception) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(exception.toString())),
                        );
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 1.0, color: kPrimaryColor),
                    ),
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        'Send OTP',
                        style: AppStyle.kBodyRegularBlack14.copyWith(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                verticalSpaceSmall,
                ResavationButton(
                  title: 'Send Reset Link',
                  width: MediaQuery.of(context).size.width,
                  onTap: () async {
                    final isValid = model.formKey.currentState?.validate();
                    if ((isValid ?? false) == false) {
                      return;
                    }

                    try {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Processing request, please wait')),
                      );
                      await model.sendResetPasswordLink();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Password reset successful, please proceed to login')),
                      );
                      model.goToLogin();
                    } catch (exception) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(exception.toString())),
                      );
                    }
                  },
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
        viewModelBuilder: () => ResetPasswordViewModel(),
      ),
    );

  }*/
}
