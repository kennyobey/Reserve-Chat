import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/text_styles.dart';

class PropertyDetails extends StatelessWidget {
  const PropertyDetails({
    Key? key,
    required this.numberOfBedrooms,
    required this.numberOfBathrooms,
    required this.squareFeet,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.title,
  }) : super(key: key);

  final int numberOfBedrooms;
  final int numberOfBathrooms;
  final int squareFeet;
  final String? title;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        PropertyDetailsIcon(
          icon: Icons.bed,
          numberOfBedrooms: numberOfBedrooms),

        PropertyDetailsIcon(
            icon: Icons.bathroom,
            numberOfBedrooms: numberOfBathrooms),

        PropertyDetailsIcon(
            icon: Icons.border_horizontal_outlined,
            numberOfBedrooms: squareFeet),



      ],
    );
  }
}

class PropertyDetailsIcon extends StatelessWidget {
  const PropertyDetailsIcon({
    Key? key,
    required this.numberOfBedrooms, required this.icon
  }) : super(key: key);

  final int numberOfBedrooms;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 5,),
        Text(
          numberOfBedrooms.toString() ,
          style: AppStyle.kBodySmallRegular,
        ),
      ],
    );
  }
}
