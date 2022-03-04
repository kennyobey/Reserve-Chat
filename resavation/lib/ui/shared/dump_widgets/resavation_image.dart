import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/utility/assets.dart';
import 'package:shimmer/shimmer.dart';

class ResavationImage extends StatelessWidget {
  const ResavationImage({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    //TODO change it to CachedNetwork after
    return
      CachedNetworkImage(
      imageUrl: image,
      fit: BoxFit.cover,
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
