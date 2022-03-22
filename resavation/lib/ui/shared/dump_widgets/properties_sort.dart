import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/text_styles.dart';

class SortProperty extends StatelessWidget {

  const SortProperty(
      {Key? key,
        required this.noOfProperties,
        required this.sortByTitle,
        this.onSortByTap,
        s})
      : super(key: key);
  final int noOfProperties;
  final String sortByTitle;
  final void Function()? onSortByTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          noOfProperties.toString(),
          style: AppStyle.kBodySmallRegular.copyWith(
            color: kPrimaryColor,
          ),
        ),
        Text(
          ' Properties',
          style: AppStyle.kBodySmallRegular,
        ),
        Spacer(),
        Text(
          "sort by",
          style: AppStyle.kBodySmallRegular,
        ),
        Icon(Icons.keyboard_arrow_down_outlined)
      ],
    );
  }
}