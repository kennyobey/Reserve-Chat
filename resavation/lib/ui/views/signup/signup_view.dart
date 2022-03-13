import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:resavation/model/registration_model.dart';
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
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: model.registrationFormKey,
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
                    controller: model.lastNameFieldController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Lastname';
                      }
                      return null;
                    },
                  ),
                  verticalSpaceSmall,
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
                  Text(
                    'Email',
                    style: AppStyle.kBodyRegularBlack14,
                  ),
                  ResavationTextField(
                    textInputAction: TextInputAction.next,
                    controller: model.emailFieldController,
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
                    textInputAction: TextInputAction.next,
                    controller: model.passwordFieldController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
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
                    controller: model.verifyPasswordFieldController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter re-enter password';
                      }
                      return null;
                    },
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
                              onChanged: (value) {
                                model.onRadioChanged(value.toString());
                              },
                            ),
                            Text(
                              "Property Owner",
                              style: AppStyle.kBodyRegularBlack14,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: "Tenant",
                              groupValue: model.userType,
                              onChanged: (value) {
                                model.onRadioChanged(value.toString());
                              },
                            ),
                            Text(
                              "Tenant",
                              style: AppStyle.kBodyRegularBlack14,
                            )
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
                                text: 'I agree to the ',
                                style: AppStyle.kBodyRegularBlack14),
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
                  // Text(
                  //          "The user ${_registration.email}, ${_registration.firstname} is created successfully "),
                  ResavationButton(
                    width: MediaQuery.of(context).size.width,
                    title: 'Sign Up',
                    onTap: () async {
                      if (model.registrationFormKey.currentState!.validate()) {
                        final String email = model.emailFieldController.text;
                        final String firstname =
                            model.firstNameFieldController.text;
                        final String lastname =
                            model.lastNameFieldController.text;
                        final String password =
                            model.passwordFieldController.text;
                        final String verifyPassword =
                            model.verifyPasswordFieldController.text;
                        final bool termAndCondition = true;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Registration in progress')),
                        );

                        // waits for 3 seconds before proceeding to main view
                        model.timer = new Timer(const Duration(seconds: 3), () {
                          model.goToMainView();
                        });

                        RegistrationModel _registration =
                            await model.registerUser(email, firstname, lastname,
                                password, termAndCondition, verifyPassword);

                        print(_registration.lastname);
                      }
                    },
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
      ),
      viewModelBuilder: () => SignUpViewModel(),
    );
  }
}
