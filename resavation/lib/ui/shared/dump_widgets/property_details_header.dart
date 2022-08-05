import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:resavation/model/propety_model/property_image.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';

class PropertyDetailsHeader extends StatelessWidget {
  final List<PropertyImage> propertyImages;

  PropertyDetailsHeader({
    Key? key,
    this.onBackTap,
    this.onFavoriteTap,
    required this.propertyImages,
    this.isFavoriteTap = false,
  });

  final void Function()? onBackTap;
  final void Function()? onFavoriteTap;
  final bool isFavoriteTap;

  final StreamController<int> _fetchingStream =
      StreamController<int>.broadcast();
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    final topPadding = queryData.padding.top;

    return SizedBox(
      height: 300,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: double.infinity,
              enableInfiniteScroll: true,
              pauseAutoPlayOnTouch: true,
              onPageChanged: (index, reason) {
                _fetchingStream.add(index);
              },
              autoPlay: true,
            ),
            items: propertyImages
                .map((item) => Container(
                      padding: const EdgeInsets.only(right: 5),
                      height: double.infinity,
                      width: double.infinity,
                      child: ResavationImage(
                        image: item.imageUrl ?? '',
                        boxFit: BoxFit.cover,
                      ),
                    ))
                .toList(),
          ),
          Positioned(
            child: buildIndicators(_fetchingStream.stream),
            bottom: 5,
            left: 0,
            right: 0,
          ),
          buildBackButton(topPadding),
          if (onFavoriteTap != null) buildFavouriteButton(topPadding),
        ],
      ),
    );
  }

  StreamBuilder<int> buildIndicators(Stream<int> stream) {
    return StreamBuilder<int>(
        stream: stream,
        builder: (ctx, asyncDataSnapshot) {
          final index = asyncDataSnapshot.data ?? 0;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: propertyImages.map((entry) {
              final isSelected = index == propertyImages.indexOf(entry);
              return InkWell(
                splashColor: Colors.transparent,
                onTap: () =>
                    _controller.animateToPage(propertyImages.indexOf(entry)),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 6.0,
                  height: 6.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: kWhite),
                    color: isSelected ? kWhite : Colors.transparent,
                  ),
                ),
              );
            }).toList(),
          );
        });
  }

  Widget buildFavouriteButton(double topPadding) {
    return Positioned(
      right: 10,
      top: topPadding + 10,
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: onFavoriteTap,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(25)),
          alignment: Alignment.center,
          padding: EdgeInsets.all(5),
          child: Icon(
            isFavoriteTap ? Icons.favorite : Icons.favorite_border,
            color: isFavoriteTap ? kRed : kWhite,
            size: 20,
          ),
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
}
