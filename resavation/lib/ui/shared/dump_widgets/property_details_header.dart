import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/utility/assets.dart';

class PropertyDetailsHeader extends SliverPersistentHeaderDelegate {
  const PropertyDetailsHeader({
    Key? key,
    this.onBackTap,
    this.onFavoriteTap,
    this.isFavoriteTap = false,
  });

  final void Function()? onBackTap;
  final void Function()? onFavoriteTap;
  final bool isFavoriteTap;

  @override
  Widget build(BuildContext context, shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ResavationImage(
          image: Assets.sitting_room_placeholder,
        ),
        Positioned(
          left: 30,
          top: 50,
          child: GestureDetector(
            onTap: onBackTap,
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.grey[700],
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 4),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          right: 30,
          top: 50,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.grey[700],
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.all(1),
            child: Icon(
              isFavoriteTap ? Icons.favorite_border : Icons.favorite_border,
              color: isFavoriteTap ? kRed : kWhite,

            ),
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  double get maxExtent => 300.0;

  @override
  double get minExtent => 0;
}
