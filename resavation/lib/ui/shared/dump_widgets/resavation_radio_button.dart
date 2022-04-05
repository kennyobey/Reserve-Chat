import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/text_styles.dart';

// Space Type Yes/No Radio Button
class ResavationRadioButton extends StatelessWidget {
  const ResavationRadioButton(
      {Key? key,
      required this.title,
      required this.radioValue,
      required this.groupValue,
      required this.onChanged})
      : super(key: key);

  final String title;
  final String radioValue;
  final String groupValue;
  final Function(String? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppStyle.kBodySmallRegular12,
        ),
        Radio(
          value: radioValue,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
