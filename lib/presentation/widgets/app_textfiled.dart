import 'package:amritha_ayurvedha/core/constants/font_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final String? labelText, hintText;
  final IconData? icon;
  final TextInputType? textInputType;
  final int? maxLength;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? prefix, suffix;
  final bool readOnly, obscureText;
  final int maxlines;
  final Color? txtColor, fillColor, borderColor;
  final double? borderWidth;
  final FocusNode? focusNode;
  final double? horizontalPadding;
  final bool autofocus;

  const AppTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.icon,
    this.textInputType,
    this.horizontalPadding,
    this.maxLength,
    this.controller,
    this.inputFormatters,
    this.onChanged,
    this.validator,
    this.prefix,
    this.suffix,
    this.readOnly = false,
    this.obscureText = false,
    this.maxlines = 1,
    this.txtColor,
    this.fillColor,
    this.borderColor,
    this.borderWidth,
    this.focusNode,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color defaultFillColor = const Color(0xFFD9D9D9);
    final Color defaultBorderColor = const Color(0xFFD9D9D9);
    final Color textColor = const Color(0xFF2E2E2E);

    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      maxLength: maxLength,
      validator: validator,
      maxLines: maxlines,
      focusNode: focusNode,
      obscureText: obscureText,
      autofocus: autofocus,
      cursorColor: textColor,
      keyboardType: textInputType ?? TextInputType.text,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      style: TextStyle(
        color: txtColor ?? textColor,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        counterText: '',
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefix,
        suffixIcon: suffix,
        filled: true,
        fillColor: fillColor ?? defaultFillColor,
        labelStyle: TextStyle(
          color: textColor,
          fontSize: 13,
          fontFamily: poppins500,
        ),
        hintStyle: TextStyle(
          color: textColor,
          fontSize: 13,
          fontFamily: poppins400,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: borderColor ?? defaultBorderColor,
            width: borderWidth ?? 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: borderColor ?? defaultBorderColor,
            width: borderWidth ?? 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: borderColor ?? defaultBorderColor,
            width: borderWidth ?? 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: borderColor ?? defaultBorderColor,
            width: borderWidth ?? 1.0,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: horizontalPadding ?? 10,
        ),
      ),
    );
  }
}
