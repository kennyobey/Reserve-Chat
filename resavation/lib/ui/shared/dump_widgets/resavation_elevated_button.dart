import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';

class ResavationElevatedButton extends StatelessWidget {
  const ResavationElevatedButton(
      {Key? key, this.child, this.onPressed, this.color, this.foregroundColor})
      : super(key: key);

  final Widget? child;
  final Function()? onPressed;
  final Color? color;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0.0),
        foregroundColor: foregroundColor == null
            ? null
            : MaterialStateProperty.all<Color>(foregroundColor!),
        backgroundColor:
            MaterialStateProperty.all<Color>(color ?? kLightButtonColor),
      ),
      child: child,
      onPressed: onPressed,
    );
  }
}
