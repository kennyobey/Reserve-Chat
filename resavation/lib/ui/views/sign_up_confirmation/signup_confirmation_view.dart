import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_button.dart';

import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/sign_up_confirmation/signup_confirmation_viewmodel.dart';

import 'package:stacked/stacked.dart';

class SignUpConfirmationView extends StatefulWidget {
  final String email;
  const SignUpConfirmationView({Key? key, required this.email})
      : super(key: key);

  @override
  _SignUpConfirmationViewState createState() => _SignUpConfirmationViewState();
}

class _SignUpConfirmationViewState extends State<SignUpConfirmationView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpConfirmationViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              SvgPicture.asset(
                'assets/icons/email.svg',
                height: 300,
                width: 300,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Verify your mail",
                style: AppStyle.kBodyRegularBlack15W500,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "We have sent a OTP to your mail. Kindly click on proceed when you recieve it.",
                style: AppStyle.kBodyRegularBlack14,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              ResavationButton(
                title: 'Verify OTP',
                width: double.infinity,
                onTap: () => model.goToVerifyUser(widget.email),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () async {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('Resending verification link, please wait')));
                  try {
                    await model.resendCode(widget.email);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('An OTP email has been sent to your mail'),
                      ),
                    );
                  } catch (exception) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(exception.toString()),
                      ),
                    );
                  }
                },
                child: Text(
                  'Resend OTP mail',
                  style: AppStyle.kBodyRegularBlack14
                      .copyWith(color: kPrimaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => SignUpConfirmationViewModel(),
    );

    ;
  }
}
