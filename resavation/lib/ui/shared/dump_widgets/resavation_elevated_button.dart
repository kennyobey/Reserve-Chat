import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';

class ResavationElevatedButton extends StatelessWidget {
  const ResavationElevatedButton({Key? key, this.child, this.onPressed})
      : super(key: key);

  final Widget? child;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(kLightButtonColor),
      ),
      child: child,
      onPressed: onPressed,
    );
  }
}
