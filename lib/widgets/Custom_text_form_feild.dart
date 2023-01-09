
import 'package:myshopp/constants.dart';
import 'package:myshopp/widgets/custom_text.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';


class CustomTextFormField extends StatelessWidget {
  final String title;
  final String hintText;
  final String? Function(String?) validatorFn;
  final Function(String?) onSavedFn;
  final String initialValue;
  final TextInputType? keyboardType;
  final bool obscureText;

  CustomTextFormField({
    required this.title,
    required this.hintText,
    required this.validatorFn,
    required this.onSavedFn,
    this.initialValue = '',
    this.keyboardType,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: title,
          fontSize: 14,
          color: Colors.grey.shade900,
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
              ),
            ),
          ),
          keyboardType: keyboardType,
          obscureText: obscureText,
          initialValue: initialValue,
          validator: validatorFn,
          onSaved: onSavedFn,
        ),
      ],
    );
  }
}
