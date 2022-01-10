import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/text_styles.dart';

class SignUpText extends StatelessWidget {
  const SignUpText({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Text.rich(
        TextSpan(children: [
          TextSpan(
            text: "Don't have an account? ",
          ),
          TextSpan(
            text: 'Sign up',
            style: AppStyle.kBodyBold.copyWith(
              color: kPrimaryColor,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ]),
        style: AppStyle.kBodyRegular,
      ),
    );
  }
}
