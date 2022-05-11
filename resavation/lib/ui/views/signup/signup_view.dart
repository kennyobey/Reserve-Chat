import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/signup/signup_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  List<Widget> buildLastNameField(SignUpViewModel model) {
    return [
      Text(
        'Last Name',
        style: AppStyle.kBodyRegularBlack14,
      ),
      ResavationTextField(
        hintText: 'Ameh',
        textInputAction: TextInputAction.next,
        controller: model.lastNameFieldController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your Lastname';
          }
          return null;
        },
      ),
      verticalSpaceSmall,
    ];
  }

  List<Widget> buildFirstNameField(SignUpViewModel model) {
    return [
      Text(
        'First Name',
        style: AppStyle.kBodyRegularBlack14,
      ),
      ResavationTextField(
        textInputAction: TextInputAction.next,
        controller: model.firstNameFieldController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your Firstname';
          }
          return null;
        },
        hintText: 'Queen',
      ),
      verticalSpaceSmall,
    ];
  }

  List<Widget> buildEmailField(SignUpViewModel model) {
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

  List<Widget> buildPasswordField(SignUpViewModel model) {
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

  List<Widget> buildVerifyPasswordField(SignUpViewModel model) {
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
            return "Password must be atleast 8 characters long";
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

  List<Widget> buildAccountType(SignUpViewModel model) {
    return [
      Text(
        'Account Type',
        style: AppStyle.kBodyRegularBlack14W500,
      ),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: kGray, width: 0.5),
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Radio(
              value: "PROPERTY_OWNER",
              groupValue: model.userType,
              onChanged: (value) {
                model.onRadioChanged(value.toString());
                model.updateUserType();
              },
            ),
            Text(
              "Property Owner",
              style: AppStyle.kBodyRegularBlack14,
            ),
            const Spacer(),
            Radio(
              value: "TENANT",
              groupValue: model.userType,
              onChanged: (value) {
                model.onRadioChanged(value.toString());
                model.updateUserType();
              },
            ),
            Text(
              "Tenant",
              style: AppStyle.kBodyRegularBlack14,
            )
          ],
        ),
      ),
      verticalSpaceSmall,
    ];
  }

  List<Widget> buildTermsAndCondition(SignUpViewModel model) {
    return [
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
                    text: 'I agree to the ',
                    style: AppStyle.kBodyRegularBlack14),
                TextSpan(
                  text: 'Terms & Condition',
                  style: AppStyle.kBodyRegularBlack14.copyWith(
                    color: kPrimaryColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('terms and condition clicked')));
                    },
                ),
              ]),
              style: AppStyle.kBodyRegularBlack14,
            ),
          ),
        ],
      ),
      verticalSpaceSmall,
    ];
  }

  List<Widget> buildSignUpButton(SignUpViewModel model) {
    return [
      ResavationButton(
          width: double.infinity,
          title: 'Sign Up',
          isLoadingEnabled: model.isLoading,
          onTap: () async {
            final isValid = model.registrationFormKey.currentState?.validate();
            if ((isValid ?? false) == false || model.isLoading) {
              return;
            }
            if (!model.checkValue) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        'Please accept the application\'s terms and conditions. ')),
              );
              return;
            }

            try {
              await model.sendDetailsToServer();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        'Registration successful, kindly login to your account')),
              );
              model.goToLoginView();
            } catch (exception) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(exception.toString())),
              );
            }
          }),
      verticalSpaceMedium,
    ];
  }

  List<Widget> buildSignInButton(SignUpViewModel model) {
    return [
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
                text: 'Sign In',
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: BackButton(
            color: Colors.black,
          ),
          title: Text(
            'Sign Up',
            style: AppStyle.kHeading0,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: model.registrationFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceMedium,
                ...buildLastNameField(model),
                ...buildFirstNameField(model),
                ...buildEmailField(model),
                ...buildPasswordField(model),
                ...buildVerifyPasswordField(model),
                ...buildAccountType(model),
                ...buildTermsAndCondition(model),
                ...buildSignUpButton(model),
                ...buildSignInButton(model),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SignUpViewModel(),
    );
  }
}
