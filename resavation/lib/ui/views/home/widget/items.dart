import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';

import 'package:shimmer/shimmer.dart';

import '../../../shared/colors.dart';
import '../../../shared/spacing.dart';
import '../../../shared/text_styles.dart';

class LongCategoriesAndStatesCard extends StatelessWidget {
  const LongCategoriesAndStatesCard({
    Key? key,
    required this.onTap,
    required this.image,
    required this.title,
    required this.count,
    this.shimmerEnabled = false,
  }) : super(key: key);

  final VoidCallback onTap;
  final String image;
  final bool shimmerEnabled;
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
        child: shimmerEnabled
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade100,
                highlightColor: Colors.grey.shade300,
                child: shimmerBody(),
              )
            : buildBody(),
      ),
    );
  }

  Column shimmerBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 130,
          color: kDarkBlue,
          child: ResavationImage(
            image: image,
          ),
        ),
        verticalSpaceTiny,
        Container(
          color: kPrimaryColor,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          width: double.infinity,
          height: 20,
        ),
        verticalSpaceTiny,
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          color: kPrimaryColor,
          width: double.infinity,
          height: 20,
        ),
        verticalSpaceTiny,
      ],
    );
  }

  Column buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 130,
          color: kDarkBlue,
          child: ResavationImage(
            image: image,
          ),
        ),
        verticalSpaceTiny,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            title,
            style: AppStyle.kBodyRegular18W500,
          ),
        ),
        verticalSpaceTiny,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            count,
            style: AppStyle.kBodySmallRegular12W300,
          ),
        ),
        verticalSpaceTiny,
      ],
    );
  }
}

class CategoryCard extends StatefulWidget {
  const CategoryCard({
    Key? key,
    this.category = '',
    required this.image,
    this.onTap,
    this.shimmerEnabled = false,
  }) : super(key: key);

  final String category;
  final bool shimmerEnabled;
  final String image;
  final VoidCallback? onTap;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 150,
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: widget.shimmerEnabled
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade100,
                highlightColor: Colors.grey.shade300,
                child: shimmerBody(),
              )
            : buildBody(),
      ),
    );
  }

  Stack buildBody() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  kBlack.withOpacity(0.3),
                  kBlack.withOpacity(0.3),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              child: ResavationImage(
                image: widget.image,
              ),
            ),
          ),
        ),
        Text(
          widget.category,
          style: AppStyle.kBodyBold.copyWith(
            color: kWhite,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget shimmerBody() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kPrimaryColor,
      ),
      width: double.infinity,
      height: double.infinity,
    );
  }
}

class TopCityCard extends StatefulWidget {
  const TopCityCard({
    Key? key,
    required this.location,
    required this.image,
    this.shimmerEnabled = false,
    required this.numberOfProperties,
    this.onTap,
  }) : super(key: key);

  final String location;
  final String image;
  final bool shimmerEnabled;
  final int numberOfProperties;
  final VoidCallback? onTap;

  @override
  State<TopCityCard> createState() => _TopCityCardState();
}

class _TopCityCardState extends State<TopCityCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 250,
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: widget.shimmerEnabled
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade100,
                highlightColor: Colors.grey.shade300,
                child: shimmerBody(),
              )
            : buildBody(),
      ),
    );
  }

  Widget shimmerBody() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kPrimaryColor,
      ),
      width: double.infinity,
      height: double.infinity,
    );
  }

  Stack buildBody() {
    debugPrint(widget.image);
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  kBlack.withOpacity(0.3),
                  kBlack.withOpacity(0.5),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              child: ResavationImage(
                image: widget.image,
              ),
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
                widget.location,
                style: AppStyle.kBodyRegularBlack14W600.copyWith(
                  color: kWhite,
                  fontWeight: FontWeight.w500,
                ),
              ),
              verticalSpaceSmall,
              Text(
                widget.numberOfProperties.toString() + ' Properties',
                style: AppStyle.kBodySmallRegular.copyWith(
                  color: kWhite,
                ),
              ),
            ],
          ),
        ),
      ],
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
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                'See All',
                style: AppStyle.kBodySmallRegular12W500.copyWith(
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
