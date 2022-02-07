import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/text_styles.dart';

class ResavationTextSpan extends StatelessWidget {
  const ResavationTextSpan({
    Key? key,
    this.onTap,
    this.leading = '',
    this.trailing = '',
  }) : super(key: key);
  final String leading;
  final String trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Text.rich(
        TextSpan(children: [
          TextSpan(
            text: leading,
          ),
          TextSpan(
            text: trailing,
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
