import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';

import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/verify_user_account/verify_user_account_viewmodel.dart';

import 'package:stacked/stacked.dart';

import '../../shared/spacing.dart';

class VerifyUserAccount extends StatefulWidget {
  final String email;
  const VerifyUserAccount({Key? key, required this.email}) : super(key: key);

  @override
  _VerifyUserAccountState createState() => _VerifyUserAccountState();
}

class _VerifyUserAccountState extends State<VerifyUserAccount> {
  List<Widget> buildOTPField(VerifyUserAccountViewModel model) {
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
    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: Colors.red),
      ),
    );

    return [
      Pinput(
        defaultPinTheme: defaultPinTheme,
        errorPinTheme: errorPinTheme,
        focusedPinTheme: focusedPinTheme,
        submittedPinTheme: submittedPinTheme,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        controller: model.otpFieldController,
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: true,
        validator: (s) {
          if (s == null || s.isEmpty) {
            return "Please enter the pin you recieved";
          } else if (s.trim().length < 4) {
            return "Please enter the complete pin";
          }
          return null;
        },
      ),
      verticalSpaceSmall,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerifyUserAccountViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Form(
              key: model.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/icons/email.svg',
                    height: 250,
                    width: 250,
                    fit: BoxFit.contain,
                  ),
                  verticalSpaceMedium,
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Please enter the OTP that was sent to your account.",
                      style: AppStyle.kBodyRegularBlack15W500,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  verticalSpaceLarge,
                  ...buildOTPField(model),
                  verticalSpaceLarge,
                  ResavationButton(
                    title: 'Verify OTP',
                    isLoadingEnabled: model.isLoadingEnabled,
                    width: MediaQuery.of(context).size.width,
                    onTap: () async {
                      final isValid = model.formKey.currentState?.validate();
                      if ((isValid ?? false) == false ||
                          model.isLoadingEnabled) {
                        return;
                      }
                      try {
                        await model.verifyOTP(widget.email);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Your account has been verified, please proceed to Login ",
                            ),
                          ),
                        );
                        model.goToLoginView();
                      } catch (exception) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              exception.toString(),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => VerifyUserAccountViewModel(),
    );
  }
}
