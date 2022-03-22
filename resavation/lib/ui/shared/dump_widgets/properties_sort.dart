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
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Sort by ',
                style: AppStyle.kBodySmallRegular,
              ),
              // TextSpan(
              //   text: sortByTitle,
              //   style: AppStyle.kBodyRegular,
              //   recognizer: TapGestureRecognizer()..onTap = onSortByTap,
              // )
            ],
          ),
        ),
        DropdownButton(
          items: <String>['Category', 'City', 'Office Space', 'Apartment']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            //TODO add an action to change value
          },
        )
      ],
    );
  }
}
