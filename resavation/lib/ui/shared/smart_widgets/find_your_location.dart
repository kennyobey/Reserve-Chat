import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_searchbar.dart';
import 'package:resavation/ui/shared/spacing.dart';

class FindYourLocation extends StatelessWidget {
  const FindYourLocation({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: ResavationSearchBar(
            text: "",
            elevation: 0.0,
            showPrefix: true,
            hintText: 'Enter your location',
            fillColors: kWhite,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 48,
            width: 40,
            child: Icon(
              Icons.filter_list,
              color: kWhite,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
              color: kPrimaryColor,
            ),
          ),
        )
      ],
    );
  }
}
