import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';
import 'package:resavation/ui/shared/text_styles.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({
    required this.name,
    required this.image,
    Key? key,
    this.onTap,
  }) : super(key: key);

  final String name;
  final String image;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ResavationImage(image: image),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: double.infinity,
                  ),
                  Text(
                    name,
                    style: AppStyle.kBodyBoldBlack,
                  ),
                  Text(
                    'Online',
                    style: AppStyle.kBodyRegularBlack14,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
