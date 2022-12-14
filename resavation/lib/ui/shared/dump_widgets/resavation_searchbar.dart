import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/text_styles.dart';

class ResavationSearchBar extends StatefulWidget {
  const ResavationSearchBar({
    Key? key,
    required this.text,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.label,
    this.icon,
    this.elevation,
    this.hintText,
    this.fillColors,
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
  final ValueChanged<String>? onFieldSubmitted;
  final void Function()? onTap;
  final String? label;
  final Icon? icon;
  final String? hintText;
  final String? labelText;
  final double? elevation;
  final Color? color;
  final Color? fillColors;
  final bool showPrefix;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  _ResavationSearchBarState createState() => _ResavationSearchBarState();
}

class _ResavationSearchBarState extends State<ResavationSearchBar> {
  @override
  Widget build(BuildContext context) {
    final style = AppStyle.kBodySmallRegular;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        elevation: widget.elevation != null ? widget.elevation! : 0.0,
        child: TextFormField(
          keyboardType: widget.keyboardType,
          onFieldSubmitted: widget.onFieldSubmitted,
          textInputAction: widget.textInputAction,
          controller: widget.controller,
          validator: widget.validator,
          style: style,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            fillColor: widget.fillColors ?? null,
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: widget.fillColors ?? kGray, width: 0.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: widget.fillColors ?? kGray, width: 0.5),
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
