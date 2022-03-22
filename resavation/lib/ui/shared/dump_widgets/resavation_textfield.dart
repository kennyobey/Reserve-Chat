import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/text_styles.dart';

class ResavationTextField extends StatefulWidget {
  const ResavationTextField({
    Key? key,
    this.onTap,
    this.label,
    this.icon,
    this.elevation,
    this.hintText,
    this.color,
    this.labelText,
    this.obscureText = false,
    this.showPrefix = false,
    this.textInputAction,
    this.keyboardType,
    this.controller,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  final void Function()? onTap;
  final String? label;
  final Icon? icon;
  final String? hintText;
  final String? labelText;
  final double? elevation;
  final Color? color;
  final bool obscureText;
  final bool showPrefix;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  _ResavationTextFieldState createState() => _ResavationTextFieldState();
}

class _ResavationTextFieldState extends State<ResavationTextField> {
  late bool _obscureText = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    final style = AppStyle.kBodySmallRegular;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        elevation: widget.elevation != null ? widget.elevation! : 0.0,
        child: TextFormField(
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          controller: widget.controller,
          validator: widget.validator,
          obscureText: _obscureText,
          style: style,
          decoration: InputDecoration(
            border: OutlineInputBorder(
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
            suffixIcon: widget.obscureText
                ? GestureDetector(
              onTap: () {
                setState(() {
                  print(true);
                  _obscureText = !_obscureText;
                });
              },
              child: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: kPrimaryColor,
              ),
            )
                : null,
          ),
        ),
      ),
    );
  }
}