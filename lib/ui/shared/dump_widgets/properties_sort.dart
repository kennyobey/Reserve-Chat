import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/text_styles.dart';

class SortProperty extends StatelessWidget {
  const SortProperty({Key? key, required this.noOfProperties, required this.sortByTitle, this.onSortByTap, s}) : super(key: key);
  final int noOfProperties;
  final String sortByTitle;
  final void Function()? onSortByTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          noOfProperties.toString(),
          style: AppStyle.kBodyBold.copyWith(
            color: kPrimaryColor,
          ),
        ),
        Text(
          ' Properties',
          style: AppStyle.kBodyBold,
        ),
        Spacer(),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Sort by: ',
                style: AppStyle.kBodyBold,
              ),
              TextSpan(
                text: sortByTitle,
                style: AppStyle.kBodyRegular,
                recognizer: TapGestureRecognizer()..onTap = onSortByTap,
              )
            ],
          ),
        ),
      ],
    );
  }
}
