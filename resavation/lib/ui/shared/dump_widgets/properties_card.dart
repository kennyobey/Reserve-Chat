import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/property_details.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:shimmer/shimmer.dart';

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
    required this.numberOfCars,
    this.shimmerEnabled = false,
    required this.squareFeet,
    this.isFavoriteTap = false,
    this.onTap,
  }) : super(key: key);

  final void Function()? onFavoriteTap;
  final String image;
  final int id;
  final double? amountPerYear;
  final bool shimmerEnabled;
  final String propertyName;
  final String address;
  final int numberOfBedrooms;

  final int numberOfBathrooms;
  final int numberOfCars;
  final double squareFeet;
  final bool isFavoriteTap;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          width: double.infinity,
          child: shimmerEnabled
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade100,
                  highlightColor: Colors.grey.shade300,
                  child: shimmerBody(),
                )
              : buildBody(),
        ),
      ),
    );
  }

  Widget shimmerBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 150,
          color: kDarkBlue,
        ),
        verticalSpaceSmall,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: kPrimaryColor,
                width: double.infinity,
                height: 20,
              ),
              verticalSpaceTiny,
              Container(
                color: kPrimaryColor,
                width: double.infinity,
                height: 20,
              ),
              verticalSpaceTiny,
            ],
          ),
        ),
      ],
    );
  }

  Column buildBody() {
    final oCcy = NumberFormat("#,##0.00", "en_US");
    return Column(
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
              right: 5,
              top: 5,
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: onFavoriteTap,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25)),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    isFavoriteTap ? Icons.favorite : Icons.favorite_border,
                    color: isFavoriteTap ? kRed : kWhite,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        verticalSpaceSmall,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      propertyName,
                      style: AppStyle.kBodySmallRegular12W500,
                    ),
                    verticalSpaceTiny,
                    Text(
                      address,
                      style: AppStyle.kBodySmallRegular12W300,
                    ),
                  ],
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
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: PropertyDetails(
            numberOfBedrooms: numberOfBedrooms,
            numberOfBathrooms: numberOfBathrooms,
            numberOfCars: numberOfCars,
            squareFeet: squareFeet,
          ),
        ),
        verticalSpaceSmall,
      ],
    );
  }
}
