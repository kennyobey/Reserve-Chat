import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resavation/ui/shared/colors.dart';
import 'package:resavation/ui/shared/text_styles.dart';

class ResavationTextField extends StatefulWidget {
  const ResavationTextField({
    Key? key,
    this.onTap,
    this.label,
    this.icon,
    this.onlyNumbers = false,
    this.elevation,
    this.hintText,
    this.hintTextStyle,
    this.color,
    this.fillColors,
    this.focusNode,
    this.labelText,
    this.obscureText = false,
    this.showPrefix = false,
    this.textInputAction,
    this.keyboardType,
    this.controller,
    this.validator,
    this.onChanged,
    this.maxline = 1,
  }) : super(key: key);

  final void Function()? onTap;
  final String? label;
  final Icon? icon;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final String? labelText;
  final double? elevation;
  final Color? color;
  final Color? fillColors;
  final bool obscureText;
  final bool onlyNumbers;
  final bool showPrefix;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int? maxline;

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
        elevation: widget.elevation != null ? widget.elevation! : 0,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey),
          ),
          child: TextFormField(
            onChanged: widget.onChanged,
            focusNode: widget.focusNode,
            keyboardType: widget.keyboardType,
            inputFormatters: [
              if (widget.onlyNumbers)
                FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
            ],
            maxLines: widget.maxline,
            textInputAction: widget.textInputAction,
            controller: widget.controller,
            validator: widget.validator,
            obscureText: _obscureText,
            style: style,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: kGray, width: 0.5),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 0.5),
              ),

              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kGray, width: 0.5),
              ),
              // fillColor: widget.fillColors ?? null,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kGray, width: 2.0),
              ),
              // filled: true,
              hintText: widget.hintText,
              labelText: widget.labelText,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              hintStyle:
                  widget.hintTextStyle != null ? widget.hintTextStyle : style,
              prefixIcon: widget.showPrefix ? Icon(Icons.search) : null,
              suffixIcon: widget.obscureText
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: kGray,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
