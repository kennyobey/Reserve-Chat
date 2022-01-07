import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/text_styles.dart';

class ResavationButton extends StatelessWidget {
  const ResavationButton({
    Key? key,
    this.onTap,
    required this.title,
    this.titleColor = kWhite,
    this.buttonColor = kPrimaryColor,
    this.height,
    this.width,
  }) : super(key: key);
  final void Function()? onTap;
  final String title;
  final Color titleColor;
  final Color buttonColor;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(milliseconds: 300),
        height: height ?? 50,
        width: width ?? 350,
        child: Text(
          title,
          style: AppStyle.kBodyBold.copyWith(color: titleColor),
        ),
      ),
    );
  }
}
