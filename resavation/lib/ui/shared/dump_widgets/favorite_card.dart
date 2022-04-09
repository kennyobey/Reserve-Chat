import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/property_details.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';
import 'package:resavation/ui/views/favorite/favorite_viewmodel.dart';
import 'package:stacked/stacked.dart';

class FavoriteCard extends ViewModelWidget<FavoriteViewModel> {
  const FavoriteCard({
    Key? key,
    required this.id,
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
  final int id;
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
  Widget build(BuildContext context, model) {
    return Card(
      elevation: 5,
      shadowColor: kBlack54,
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
                        style: AppStyle.kBodySmallRegular12W500,
                      ),
                      InkWell(
                        onTap: (){
                          model.changeFavoriteIcon(id);
                        },
                        child: Icon(
                          Icons.favorite,
                          color: model.isFavorite? kRed : kTransparent,
                        ),
                      ),
                    ],
                  ),
                  // verticalSpaceSmall,
                  Container(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      category ?? '',
                      style: AppStyle.kBodySmallRegular12W300.copyWith(
                        color: kBlack54,
                      ),
                    ),
                  ),
                  verticalSpaceSmall,
                  Text(
                    '\$ ' + amountPerYear.toString() + ' /year',
                    style: AppStyle.kBodySmallRegular11W400.copyWith(
                      color: kPrimaryColor,
                    ),
                  ),
                  verticalSpaceSmall,
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
