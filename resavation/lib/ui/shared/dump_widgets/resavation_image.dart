import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/utility/assets.dart';
import 'package:shimmer/shimmer.dart';

class ResavationImage extends StatelessWidget {
  const ResavationImage({
    Key? key,
    required this.image,
    this.boxFit = BoxFit.cover,
  }) : super(key: key);
  final String image;
  final BoxFit boxFit;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      fit: boxFit,
      placeholder: (context, url) => Container(
        alignment: Alignment.center,
        color: kDarkBlue,
        child: Shimmer.fromColors(
          enabled: true,
          child: SvgPicture.asset(Assets.logo),
          baseColor: kDarkBlue,
          highlightColor: kWhite,
        ),
      ),
      errorWidget: (context, url, error) => Container(
        alignment: Alignment.center,
        color: kDarkBlue,
        child: SvgPicture.asset(
          Assets.logo,
          color: kDarkBlue,
        ),
      ),
    );
  }
}
