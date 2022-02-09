import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/property_details.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({
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
    required this.category,
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
  final String? category;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  height: 100,
                  child: ResavationImage(
                    image: image,
                  ),
                ),
              ),
            ),
            horizontalSpaceSmall,
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        location,
                        style: AppStyle.kBodySmallBold,
                      ),
                      Icon(
                        Icons.favorite,
                        color: kRed,
                      ),
                    ],
                  ),
                  // verticalSpaceSmall,
                  Container(
                    color: kPrimaryColor,
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      category ?? '',
                      style: AppStyle.kBodySmallRegular.copyWith(
                        color: kWhite,
                      ),
                    ),
                  ),
                  verticalSpaceSmall,
                  Text(
                    '\$ ' + amountPerYear.toString() + ' /year',
                    style: AppStyle.kBodySmallBold.copyWith(
                      color: kPrimaryColor,
                    ),
                  ),
                  PropertyDetails(
                    numberOfBedrooms: numberOfBedrooms,
                    numberOfBathrooms: numberOfBathrooms,
                    squareFeet: squareFeet,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
