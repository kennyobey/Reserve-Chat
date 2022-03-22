import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/text_styles.dart';

class ResavationAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ResavationAppBar({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kWhite,
      title: Text(
        title ?? '',
        style: AppStyle.kHeading0.copyWith(color: kBlack),
      ),
      elevation: 0,
      centerTitle: true,
      // iconTheme: IconThemeData(color: ),
      leading: Navigator.canPop(context)
          ? IconButton(
        onPressed: () => Navigator.maybePop(context),
        icon: Icon(
          CupertinoIcons.chevron_back,
          color: kDarkBlue,
          size: 24,
        ),
      )
          : null,
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}