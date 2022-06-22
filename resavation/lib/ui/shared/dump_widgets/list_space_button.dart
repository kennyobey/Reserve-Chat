import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';

class ListSpaceResavationElevatedButton extends StatelessWidget {
  const ListSpaceResavationElevatedButton(
      {Key? key, this.child, this.onPressed, this.color})
      : super(key: key);

  final Widget? child;
  final Function()? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: kWhite, // background
        onPrimary: kBlack, // foreground
      ),
      child: child,
      onPressed: onPressed,
    );
  }
}
