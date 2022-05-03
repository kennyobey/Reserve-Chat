import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_searchbar.dart';

class FindYourLocation extends StatelessWidget {
  const FindYourLocation({
    Key? key,
    this.onTap,
    this.controller,
  }) : super(key: key);

  final void Function()? onTap;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: ResavationSearchBar(
            text: "",
            controller: controller,
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
