import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/text_styles.dart';

Widget bottomSheet(BuildContext context) {
  return Container(
    height: 278,
    width: MediaQuery.of(context).size.width,
    child: Card(
      margin: EdgeInsets.all(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AttachmentIcon(
                  icon: Icons.insert_drive_file,
                  iconText: "Documents",
                  color: Colors.indigo,
                ),
                SizedBox(
                  width: 19,
                ),
                AttachmentIcon(
                  icon: Icons.camera_alt,
                  iconText: "Camera",
                  color: Colors.pink,
                ),
                SizedBox(
                  width: 25,
                ),
                AttachmentIcon(
                  icon: Icons.insert_photo,
                  iconText: "Gallery",
                  color: Colors.purple,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AttachmentIcon(
                  icon: Icons.headset,
                  iconText: "Audio",
                  color: Colors.orange,
                ),
                SizedBox(
                  width: 28,
                ),
                AttachmentIcon(
                  icon: Icons.location_pin,
                  iconText: "Location",
                  color: Colors.pinkAccent,
                ),
                SizedBox(
                  width: 25,
                ),
                AttachmentIcon(
                  icon: Icons.person,
                  iconText: "Contacts",
                  color: Colors.blue,
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

class AttachmentIcon extends StatelessWidget {
  const AttachmentIcon(
      {Key? key,
      required this.icon,
      this.onTap,
      required this.iconText,
      this.color})
      : super(key: key);

  final IconData? icon;
  final Function()? onTap;
  final String? iconText;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 29,
              color: kWhite,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            iconText!,
            style: AppStyle.kBodySmallRegular12W300,
          )
        ],
      ),
    );
  }
}
