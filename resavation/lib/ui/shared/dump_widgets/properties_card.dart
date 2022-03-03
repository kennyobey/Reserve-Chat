import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/property_details.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({
    Key? key,
    required this.image,
    this.onFavoriteTap,
    this.amountPerYear,
    required this.location,
    this.address = '',
    required this.numberOfBedrooms,
    required this.numberOfBathrooms,
    required this.squareFeet,
    this.isFavoriteTap = false,
    this.onTap,
  }) : super(key: key);

  final void Function()? onFavoriteTap;
  final String image;
  final int? amountPerYear;
  final String location;
  final String address;
  final int numberOfBedrooms;
  final int numberOfBathrooms;
  final int squareFeet;
  final bool isFavoriteTap;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    color: kDarkBlue,
                    child: ResavationImage(
                      image: image,
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: IconButton(
                      icon: Icon(
                        isFavoriteTap ? Icons.favorite : Icons.favorite_border,
                        color: isFavoriteTap ? kRed : null,
                      ),
                      iconSize: 25,
                      onPressed: onFavoriteTap,
                    ),
                  ),
                ],
              ),
              verticalSpaceSmall,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          location,
                          style: AppStyle.kBodySmallRegular12W500,
                        ),
                        Text(
                          '\$ ' + amountPerYear.toString() + ' /year',
                          style: AppStyle.kBodySmallRegular12.copyWith(
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      address,
                      style: AppStyle.kBodySmallRegular12W300,
                    ),
                  ],
                ),
              ),
              verticalSpaceSmall,
              PropertyDetails(
                numberOfBedrooms: numberOfBedrooms,
                numberOfBathrooms: numberOfBathrooms,
                squareFeet: squareFeet,
              ),
              verticalSpaceSmall,
            ],
          ),
        ),
      ),
    );
  }
}
