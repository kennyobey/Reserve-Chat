import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/property_details.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/favorite/favorite_viewmodel.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

class FavoriteCard extends ViewModelWidget<FavoriteViewModel> {
  const FavoriteCard({
    Key? key,
    required this.id,
    required this.image,
    this.onFavoriteTap,
    this.amountPerYear,
    required this.name,
    this.address = '',
    required this.numberOfBedrooms,
    required this.numberOfBathrooms,
    this.shimmerEnabled = false,
    required this.numberOfCars,
    required this.squareFeet,
    this.isFavoriteTap = false,
    this.onTap,
  }) : super(key: key);

  final void Function()? onFavoriteTap;
  final int id;
  final String image;
  final double? amountPerYear;
  final String name;
  final String address;
  final int numberOfBedrooms;
  final int numberOfBathrooms;
  final bool shimmerEnabled;
  final int numberOfCars;
  final double squareFeet;
  final bool isFavoriteTap;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context, model) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 8),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: shimmerEnabled
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade100,
                  highlightColor: Colors.grey.shade300,
                  child: shimmerBody(),
                )
              : buildBody(model),
        ),
      ),
    );
  }

  Row shimmerBody() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: kPrimaryColor),
          ),
        ),
        horizontalSpaceSmall,
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: kPrimaryColor,
                width: double.infinity,
                height: 10,
              ),
              verticalSpaceTiny,
              Container(
                color: kPrimaryColor,
                width: double.infinity,
                height: 10,
              ),
              verticalSpaceSmall,
              Container(
                color: kPrimaryColor,
                width: double.infinity,
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row buildBody(FavoriteViewModel model) {
    final oCcy = NumberFormat("#,##0.00", "en_US");
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: onTap,
            child: Hero(
              child: Container(
                height: 100,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ResavationImage(
                  image: image,
                ),
              ),
              tag: id.toString(),
            ),
          ),
        ),
        horizontalSpaceSmall,
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: AppStyle.kBodySmallRegular12W500,
                  ),
                  InkWell(
                    onTap: () {
                      model.changeFavoriteIcon(id);
                    },
                    child: Padding(
                      child: Icon(
                        /* isFavoriteTap
                                ? */
                        Icons.favorite /* : Icons.favorite_border_outlined*/,
                        color: /*isFavoriteTap ?*/ kRed /*: Colors.grey*/,
                        size: 18,
                      ),
                      padding: const EdgeInsets.only(left: 5, bottom: 5),
                    ),
                  ),
                ],
              ),
              verticalSpaceTiny,
              Text(
                address,
                style: AppStyle.kBodySmallRegular12W300,
              ),
              verticalSpaceSmall,
              Text(
                '${String.fromCharCode(8358)}${oCcy.format(amountPerYear ?? 0)}',
                style: AppStyle.kBodySmallRegular12W500.copyWith(
                  color: kPrimaryColor,
                ),
              ),
              verticalSpaceSmall,
              PropertyDetails(
                numberOfBedrooms: numberOfBedrooms,
                numberOfBathrooms: numberOfBathrooms,
                numberOfCars: numberOfCars,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                squareFeet: squareFeet,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
