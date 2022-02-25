import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/text_styles.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({
    required this.name,
    required this.image,
    Key? key,
    this.onTap,
  }) : super(key: key);

  final String name;
  final AssetImage image;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 20, // Image radius
            backgroundImage: image,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Text(
                name,
                style: AppStyle.kBodyBoldBlack,
              ),
            ),
            Text(
              'Online',
              style: AppStyle.kBodySmallRegularBlack,
            ),
          ],
        ),
      ],
    );
  }
}