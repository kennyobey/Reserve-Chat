import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/utility/assets.dart';

class ProfileHeader extends SliverPersistentHeaderDelegate {
  ProfileHeader({Key? key});
  @override
  Widget build(BuildContext context, shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ResavationImage(
          image: Assets.flower_background,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black,
              ],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        Positioned(
          left: 20,
          bottom: 0,
          child: CircleAvatar(
            radius: 35, // Image radius
            backgroundImage: AssetImage(Assets.profile_image),
          ),
        ),
        Positioned(
          left: 30,
          top: 50,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.all(6),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  double get maxExtent => 200.0;

  @override
  double get minExtent => 0;
}