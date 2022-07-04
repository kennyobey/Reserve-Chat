import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/text_styles.dart';

class ResavationButton extends StatelessWidget {
  const ResavationButton(
      {Key? key,
      this.onTap,
      this.margin = const EdgeInsets.all(0),
      required this.title,
      this.titleColor = kWhite,
      this.buttonColor = kPrimaryColor,
      this.height,
      this.width,
      this.isLoadingEnabled = false,
      this.borderColor = kPrimaryColor,
      this.icon,
      this.fontSize,
      this.textStyle})
      : super(key: key);
  final void Function()? onTap;
  final String title;
  final EdgeInsets margin;
  final bool isLoadingEnabled;
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
      child: Container(
        alignment: Alignment.center,
        margin: margin,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: borderColor),
        ),
        height: height ?? 50,
        width: width ?? 350,
        child: isLoadingEnabled
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: buttonColor,
                  valueColor: const AlwaysStoppedAnimation(kWhite),
                ),
              )
            : Row(
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
                  if (icon != null)
                    SizedBox(
                      width: 5,
                    ),
                  if (icon != null)
                    Icon(
                      icon,
                      color: kWhite,
                    ),
                ],
              ),
      ),
    );
  }
}
