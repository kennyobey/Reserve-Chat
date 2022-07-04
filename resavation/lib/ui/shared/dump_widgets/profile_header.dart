import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/dump_widgets/resavation_image.dart';

import 'package:resavation/model/propety_model/user.dart';
import 'package:resavation/ui/shared/text_styles.dart';

class ProfileHeader extends StatelessWidget {
  final User user;

  final VoidCallback onBackTap;
  final VoidCallback onChatPressed;
  ProfileHeader({
    required this.onBackTap,
    required this.onChatPressed,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Stack(
      children: [
        SizedBox(
          height: 200,
          width: double.infinity,
          child: ResavationImage(
            image: user.imageUrl ?? '',
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
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
          child: Text(
            '${user.firstName ?? ''} ${user.lastName ?? ''}',
            style: AppStyle.kHeading1.copyWith(
              color: kWhite,
            ),
          ),
        ),
        Positioned(
          left: 10,
          right: 10,
          top: topPadding + 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onBackTap,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25)),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onChatPressed,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25)),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.message_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
