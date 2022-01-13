import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/text_styles.dart';

class PropertyDetails extends StatelessWidget {
  const PropertyDetails({
    Key? key,
    required this.numberOfBedrooms,
    required this.numberOfBathrooms,
    required this.squareFeet,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
  }) : super(key: key);

  final int numberOfBedrooms;
  final int numberOfBathrooms;
  final int squareFeet;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text(
          numberOfBedrooms.toString() + ' Beds',
          style: AppStyle.kBodySmallRegular,
        ),
        Text(
          numberOfBathrooms.toString() + ' Baths',
          style: AppStyle.kBodySmallRegular,
        ),
        Text(
          squareFeet.toString() + ' Sqft',
          style: AppStyle.kBodySmallRegular,
        ),
      ],
    );
  }
}
