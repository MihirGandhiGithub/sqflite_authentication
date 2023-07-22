import 'package:flutter/material.dart';

import '../../Global_Variables/Sizes/Sizes.dart';
import '../../Global_Variables/colors/colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final String labelText;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final Widget icon;
  final bool isLastField;

  const TextFormFieldWidget({
    Key? key,
    required this.controller,
    this.errorText,
    required this.labelText,
    required this.onChanged,
    required this.icon,
    required this.isLastField,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textInputAction =
        isLastField ? TextInputAction.done : TextInputAction.next;

    return Container(
      margin: EdgeInsets.only(bottom: textFormFieldMarginBottom),
      child: TextFormField(
        controller: controller,
        style: TextStyle(
            fontSize: textFormFieldFontSize, color: textFormFieldFontColor),
        cursorColor: textFormFieldCursorColor,
        cursorHeight: textFormFieldCursorHeight,
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon: icon,

          filled: true,
          fillColor: Colors.white10,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(textFormFieldBorderRadius),
          ),
          labelText: labelText,
          errorText: errorText, // Pass the errorText directly
          errorStyle: TextStyle(
              fontSize: textFormFieldErrorFontSize,
              color: textFormFieldErrorTextColor),
          errorMaxLines: 1,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(textFormFieldErrorBorderRadius),
          ),
        ),
        textInputAction: textInputAction,
        onChanged: onChanged,
      ),
    );
  }
}
