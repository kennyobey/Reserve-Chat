import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_textfield.dart';
import 'package:resavation/ui/shared/spacing.dart';

class FindYourLocation extends StatelessWidget {
  const FindYourLocation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: ResavationTextField(
            showPrefix: true,
            hintText: 'Enter your location',
          ),
        ),
        horizontalSpaceSmall,
        Container(
          height: 45,
          width: 40,
          child: Icon(
            Icons.filter_list,
            color: kWhite,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: kPrimaryColor,
          ),
        )
      ],
    );
  }
}
