import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/text_styles.dart';

class AmenitiesItem extends StatelessWidget {
  const AmenitiesItem({
    Key? key,
    required this.label,
    required this.checkboxValue,
    this.onChanged,
  }) : super(key: key);

  final String label;
  final bool checkboxValue;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          value: checkboxValue,
          onChanged: onChanged,
        ),
        Text(
          label,
          style: AppStyle.kBodySmallRegular,
        ),
      ],
    );
  }
}
