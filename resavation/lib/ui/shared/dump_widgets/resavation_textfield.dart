import 'package:flutter/material.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/text_styles.dart';

class ResavationTextField extends StatefulWidget {
  const ResavationTextField({
    Key? key,
    this.onTap,
    this.label,
    this.icon,
    this.hintText,
    this.color,
    this.labelText,
    this.obscureText = false,
    this.showPrefix = false,
  }) : super(key: key);

  final void Function()? onTap;
  final String? label;
  final Icon? icon;
  final String? hintText;
  final String? labelText;
  final Color? color;
  final bool obscureText;
  final bool showPrefix;

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
      child: TextFormField(
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
    );
  }
}