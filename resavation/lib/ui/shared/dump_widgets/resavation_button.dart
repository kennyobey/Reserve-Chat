import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/text_styles.dart';

class ResavationButton extends StatelessWidget {
  const ResavationButton(
      {Key? key,
      this.onTap,
      required this.title,
      this.titleColor = kWhite,
      this.buttonColor = kPrimaryColor,
      this.height,
      this.width,
      this.borderColor = kPrimaryColor,
      this.icon,
      this.fontSize,
      this.textStyle})
      : super(key: key);
  final void Function()? onTap;
  final String title;
  final Color titleColor;
  final Color buttonColor;
  final double? height;
  final double? width;
  final Color borderColor;
  final IconData? icon;
  final double? fontSize;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor),
          ),
          duration: const Duration(milliseconds: 300),
          height: height ?? 50,
          // width: width ?? 350,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: textStyle?.copyWith(color: titleColor) ??
                    AppStyle.kBodyRegular.copyWith(
                      color: titleColor,
                      fontSize: fontSize,
                    ),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                icon,
                color: kWhite,
              ),
            ],
          )),
    );
  }
}
