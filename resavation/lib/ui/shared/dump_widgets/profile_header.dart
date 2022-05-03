import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/utility/assets.dart';

class ProfileHeader extends SliverPersistentHeaderDelegate {
  ProfileHeader({this.onBackTap, Key? key});

  final void Function()? onBackTap;
  @override
  Widget build(BuildContext context, shrinkOffset, bool overlapsContent) {
    final topPadding = MediaQuery.of(context).padding.top;
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
          left: 10,
          bottom: 10,
          child: CircleAvatar(
            radius: 40, // Image radius
            backgroundImage: AssetImage(Assets.profile_image),
          ),
        ),
        Positioned(
          left: 10,
          top: topPadding + 10,
          child: GestureDetector(
            onTap: onBackTap,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(25)),
              alignment: Alignment.center,
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
                size: 20,
              ),
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
