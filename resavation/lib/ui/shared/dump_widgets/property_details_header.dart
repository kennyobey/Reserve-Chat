import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/utility/assets.dart';

import '../../../model/property_model.dart';

class PropertyDetailsHeader extends SliverPersistentHeaderDelegate {
  final Property? property;

  PropertyDetailsHeader({
    Key? key,
    this.onBackTap,
    this.onFavoriteTap,
    required this.property,
    this.isFavoriteTap = false,
  });

  final void Function()? onBackTap;
  final void Function()? onFavoriteTap;
  final bool isFavoriteTap;

  final StreamController<int> _fetchingStream =
      StreamController<int>.broadcast();
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context, shrinkOffset, bool overlapsContent) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Stack(
      fit: StackFit.expand,
      children: [
        Hero(
          tag: (property?.id ?? -1).toString(),
          child: CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                _fetchingStream.add(index);
              },
              autoPlay: true,
            ),
            items: Assets.imgList
                .map((item) => ResavationImage(image: item))
                .toList(),
          ),
        ),
        buildIndicators(_fetchingStream.stream),
        buildBackButton(topPadding),
        buildFavouriteButton(topPadding),
      ],
    );
  }

  StreamBuilder<int> buildIndicators(Stream<int> stream) {
    return StreamBuilder<int>(
        stream: stream,
        builder: (ctx, asyncDataSnapshot) {
          final index = asyncDataSnapshot.data ?? 0;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: Assets.imgList.asMap().entries.map((entry) {
              final isSelected = index == entry.key;
              return InkWell(
                splashColor: Colors.transparent,
                onTap: () => _controller.animateToPage(entry.key),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isSelected ? 20.0 : 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(isSelected ? 0.9 : 0.4),
                  ),
                ),
              );
            }).toList(),
          );
        });
  }

  Positioned buildFavouriteButton(double topPadding) {
    return Positioned(
      right: 10,
      top: topPadding + 10,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(25)),
        alignment: Alignment.center,
        padding: EdgeInsets.all(5),
        child: Icon(
          isFavoriteTap ? Icons.favorite_border : Icons.favorite_border,
          color: isFavoriteTap ? kRed : kWhite,
          size: 20,
        ),
      ),
    );
  }

  Positioned buildBackButton(double topPadding) {
    return Positioned(
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
