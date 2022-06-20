import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    required this.id,
    this.amountPerYear,
    required this.propertyName,
    this.address = '',
    required this.numberOfBedrooms,
    required this.numberOfBathrooms,
    required this.squareFeet,
    this.isFavoriteTap = false,
    this.onTap,
  }) : super(key: key);

  final void Function()? onFavoriteTap;
  final String image;
  final int id;
  final double? amountPerYear;
  final String propertyName;
  final String address;
  final int numberOfBedrooms;
  final int numberOfBathrooms;
  final double squareFeet;
  final bool isFavoriteTap;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("#,##0.00", "en_US");
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Hero(
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      color: kDarkBlue,
                      child: ResavationImage(
                        image: image,
                      ),
                    ),
                    tag: id.toString(),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      icon: Icon(
                        isFavoriteTap ? Icons.favorite : Icons.favorite_border,
                        color: isFavoriteTap ? kRed : kWhite,
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
                    Text(
                      propertyName,
                      style: AppStyle.kBodyRegular18W500,
                    ),
                    verticalSpaceTiny,
                    Text(
                      address,
                      style: AppStyle.kBodySmallRegular12W300,
                    ),
                  ],
                ),
              ),
              verticalSpaceSmall,
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: PropertyDetails(
                        numberOfBedrooms: numberOfBedrooms,
                        numberOfBathrooms: numberOfBathrooms,
                        squareFeet: squareFeet,
                      ),
                    ),
                    Text(
                      '${String.fromCharCode(8358)}${oCcy.format(amountPerYear ?? 0)}',
                      style: AppStyle.kBodySmallRegular12W500.copyWith(
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpaceSmall,
            ],
          ),
        ),
      ),
    );
  }
}
