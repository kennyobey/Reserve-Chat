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
        buildIcons(Icons.remove_rounded, onNegativeTap),
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
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: Icon(
            icon,
            size: 18,
            color: Colors.grey,
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

    return CheckboxListTile(
      title: Text(
        title,
        style: AppStyle.kBodyRegularBlack14,
      ),
      value: isSelected, // Displays checked or unchecked value
      controlAffinity: ListTileControlAffinity.platform,
      onChanged: (_) {
        onChanged(value);
      },
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
