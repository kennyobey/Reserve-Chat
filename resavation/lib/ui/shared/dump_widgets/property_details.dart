import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/text_styles.dart';

import '../spacing.dart';

class PropertyDetails extends StatelessWidget {
  const PropertyDetails({
    Key? key,
    required this.numberOfBedrooms,
    required this.numberOfBathrooms,
    required this.squareFeet,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.title,
  }) : super(key: key);

  final int numberOfBedrooms;
  final int numberOfBathrooms;
  final double squareFeet;
  final String? title;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        PropertyDetailsIcon(
            icon: Icons.king_bed_outlined, numberOfBedrooms: numberOfBedrooms),
        horizontalSpaceSmall,
        PropertyDetailsIcon(
            icon: Icons.shower_outlined, numberOfBedrooms: numberOfBathrooms),
        horizontalSpaceSmall,
        PropertyDetailsIcon(
            icon: Icons.square_foot_outlined, numberOfBedrooms: squareFeet),
      ],
    );
  }
}

class PropertyDetailsIcon extends StatelessWidget {
  const PropertyDetailsIcon(
      {Key? key, required this.numberOfBedrooms, required this.icon})
      : super(key: key);

  final dynamic numberOfBedrooms;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: kBlack54,
          size: 20,
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          numberOfBedrooms.toString(),
          style: AppStyle.kBodySmallRegular,
        ),
      ],
    );
  }
}
