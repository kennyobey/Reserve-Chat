import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/text_styles.dart';

class ResavationAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ResavationAppBar(
      {Key? key, this.title, this.actions, this.centerTitle = true})
      : super(key: key);

  final String? title;
  final List<Widget>? actions;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kWhite,
      actions: actions,
      title: Text(
        title ?? '',
        style: AppStyle.kHeading0.copyWith(color: kBlack),
      ),
      elevation: 0,
      centerTitle: centerTitle,
      // iconTheme: IconThemeData(color: ),
      leading: Navigator.canPop(context)
          ? BackButton(
              color: kDarkBlue,
            )
          : null,
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}
