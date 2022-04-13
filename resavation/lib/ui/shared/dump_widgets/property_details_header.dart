import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/utility/assets.dart';
import 'package:stacked/stacked.dart';

class PropertyDetailsHeader extends SliverPersistentHeaderDelegate {
   PropertyDetailsHeader({
    Key? key,
    this.onBackTap,
    this.onFavoriteTap,
    this.isFavoriteTap = false,
  });

  final void Function()? onBackTap;
  final void Function()? onFavoriteTap;
  final bool isFavoriteTap;

   int _current = 0;
   final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context, shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, reason){
              _current = index;
            },
            autoPlay: true,
          ),
          items: Assets.imgList
              .map((item) => ResavationImage(image: item))
              .toList(),),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: Assets.imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
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
