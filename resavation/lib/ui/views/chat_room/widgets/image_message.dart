import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';

class ImageMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5, // 45% of total width
      child: AspectRatio(
        aspectRatio: 1.6,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              child: Image.asset("assets/images/client1.png"),
            ),
          ],
        ),
      ),
    );
  }
}