import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/spacing.dart';
import 'package:resavation/ui/shared/text_styles.dart';

class AmenitiesSelection extends StatelessWidget {
  const AmenitiesSelection(
      {Key? key,
      this.title,
      required this.onNegativeTap,
      required this.onPositiveTap,
      this.value})
      : super(key: key);
  final String? title;
  final int? value;
  final VoidCallback onNegativeTap;
  final VoidCallback onPositiveTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title!,
            style: AppStyle.kBodyRegularBlack15W500,
          ),
        ),
        horizontalSpaceMedium,
        buildIcons(Icons.remove_circle, onNegativeTap),
        horizontalSpaceSmall,
        Text(
          value.toString(),
        ),
        horizontalSpaceSmall,
        buildIcons(Icons.add_rounded, onPositiveTap),
      ],
    );
  }

  Widget buildIcons(IconData icon, VoidCallback onTap) {
    return InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        child: Container(
          height: 22,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(3),
          width: 22,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: kPrimaryColor, width: 1),
          ),
          child: Icon(
            icon,
            size: 20,
            color: kPrimaryColor,
          ),
        ));
  }
}

// widget used to increase/decrease the amenities value
class IncrementAmenities extends StatelessWidget {
  const IncrementAmenities({Key? key, this.icon, this.onTap}) : super(key: key);

  final IconData? icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: kGray),
              borderRadius: BorderRadius.circular(10.0)),
          child: Icon(
            icon,
            color: kGray,
            size: 12,
          ),
        ),
      ),
    );
  }
}

class FilterListTile extends StatelessWidget {
  final Function(bool) onChanged;

  final bool? selectedValue;

  FilterListTile({required this.selectedValue, required this.onChanged});

  Widget buildButton(String title, bool value) {
    final bool isSelected = value == selectedValue;
    return InkWell(
      onTap: () {
        onChanged(value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: EdgeInsets.only(right: 20, left: isSelected ? 20 : 10),
        margin: const EdgeInsets.only(top: 8, left: 3, right: 3),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: isSelected
                ? kPrimaryColor.withOpacity(0.8)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color:
                    isSelected ? kBlack.withOpacity(0.2) : Colors.transparent,
                blurRadius: 0.5,
                offset: Offset(0.2, 0.2),
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppStyle.kBodyRegularBlack14
                  .copyWith(color: isSelected ? kWhite : kBlack),
            ),
            Container(
              // margin: const EdgeInsets.only(right: 20),
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xff3e3e3e).withOpacity(0.4),
                  width: 1,
                ),
              ),
              child: Container(
                margin: const EdgeInsets.all(1.3),
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  color: isSelected ? kSecondaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildButton('Yes', true),
        buildButton('No', false),
      ],
    );
  }
}
