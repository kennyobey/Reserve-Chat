import 'package:flutter/material.dart';

import '../../../shared/colors.dart';
import '../../../shared/dump_widgets/resavation_image.dart';
import '../../../shared/spacing.dart';
import '../../../shared/text_styles.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {Key? key, this.category = '', required this.image, this.onTap})
      : super(key: key);

  final String category;
  final String image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 150,
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: ResavationImage(
                  image: image,
                ),
              ),
            ),
            Text(
              category,
              style: AppStyle.kBodyBold.copyWith(
                color: kWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LongCategoriesAndStatesCard extends StatelessWidget {
  const LongCategoriesAndStatesCard({
    Key? key,
    required this.onTap,
    required this.image,
    required this.title,
    required this.count,
  }) : super(key: key);

  final VoidCallback onTap;
  final String image;
  final String title;
  final String count;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.only(left: 3, right: 3, bottom: 8),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: onTap,
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
                ),
              ),
              horizontalSpaceSmall,
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppStyle.kBodyRegular18W500,
                    ),
                    verticalSpaceTiny,
                    Text(
                      count,
                      style: AppStyle.kBodySmallRegular12W300,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopCityCard extends StatelessWidget {
  const TopCityCard({
    Key? key,
    required this.location,
    required this.image,
    required this.numberOfProperties,
    this.onTap,
  }) : super(key: key);

  final String location;
  final String image;
  final int numberOfProperties;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 250,
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: ResavationImage(
                  image: image,
                ),
              ),
            ),
            Positioned(
              left: 10,
              bottom: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location,
                    style: AppStyle.kBodySmallBold.copyWith(
                      color: kWhite,
                    ),
                  ),
                  verticalSpaceSmall,
                  Text(
                    numberOfProperties.toString() + ' Properties',
                    style: AppStyle.kBodySmallRegular.copyWith(
                      color: kWhite,
                    ),
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

class TitleListTile extends StatelessWidget {
  const TitleListTile({
    Key? key,
    this.title = '',
    required this.visibility,
    this.onTap,
  }) : super(key: key);

  final String title;
  final void Function()? onTap;
  final bool visibility;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppStyle.kSubHeadingW600,
        ),
        Spacer(),
        GestureDetector(
          onTap: onTap,
          child: Visibility(
            visible: visibility,
            child: Text(
              'See All',
              style: AppStyle.kBodySmallRegular12W500.copyWith(
                color: kPrimaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
