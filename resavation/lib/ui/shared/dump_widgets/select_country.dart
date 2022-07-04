import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class SelectCountry extends StatelessWidget {
  const SelectCountry({
    Key? key,
    required this.label,
    required this.onSelected,
  }) : super(key: key);

  final String label;
  final Function(Country) onSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: Colors.grey, width: 1.0)),
          width: MediaQuery.of(context).size.width,
          height: 42,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(label), Icon(Icons.keyboard_arrow_down_sharp)],
            ),
          )),
      onTap: () {
        showCountryPicker(
          context: context,
          showPhoneCode: true,
          // optional. Shows phone code before the country name.
          onSelect: onSelected,
        );
      },
    );
  }
}
