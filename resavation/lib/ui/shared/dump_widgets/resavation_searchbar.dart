import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/text_styles.dart';

class ResavationSearchBar extends StatefulWidget {
  const ResavationSearchBar({
    Key? key,
    required this.text,
    this.onChanged,
    this.onTap,
    this.label,
    this.icon,
    this.elevation,
    this.hintText,
    this.color,
    this.labelText,
    this.showPrefix = false,
    this.textInputAction,
    this.keyboardType,
    this.controller,
    this.validator,
  }) : super(key: key);

  final String text;
  final ValueChanged<String>? onChanged;
  final void Function()? onTap;
  final String? label;
  final Icon? icon;
  final String? hintText;
  final String? labelText;
  final double? elevation;
  final Color? color;
  final bool showPrefix;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  _ResavationSearchBarState createState() => _ResavationSearchBarState();
}

class _ResavationSearchBarState extends State<ResavationSearchBar> {
  late String _text = widget.controller!.text;

  @override
  Widget build(BuildContext context) {
    final style = AppStyle.kBodySmallRegular;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        elevation: widget.elevation != null ? widget.elevation! : 0.0,
        child: TextFormField(
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          controller: widget.controller,
          validator: widget.validator,
          style: style,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
              borderSide: const BorderSide(color: kPrimaryColor, width: 0.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
            ),
            hintText: widget.hintText,
            labelText: widget.labelText,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            hintStyle: style,
            prefixIcon: widget.showPrefix ? Icon(Icons.search) : null,
            // logic behind the cancel icon in search bar
            suffixIcon: widget.text.isNotEmpty
                ? GestureDetector(
              child: Icon(Icons.close, color: style.color),
              onTap: () {
                widget.controller!.clear();
                widget.onChanged!('');
                FocusScope.of(context).requestFocus(FocusNode());
              },
            )
                : null,
          ),
        ),
      ),
    );
  }
}
