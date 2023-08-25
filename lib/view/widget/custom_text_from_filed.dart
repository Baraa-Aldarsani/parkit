import 'package:flutter/material.dart';

import '../../helper/constant.dart';

class CustomTextFromField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final dynamic onSaved;
  final dynamic validator;
  final dynamic onTap;
  final Color hintColor;
  final double fontSize;
  final bool obscureText;
  final bool readOnly;
  var controller;

  CustomTextFromField({
    this.hintText = '',
    this.icon = Icons.hourglass_empty,
    this.onSaved,
    this.onTap,
    this.controller,
    this.validator,
    this.hintColor = const Color.fromRGBO(29, 53, 87, 1),
    this.fontSize = 18,
    this.obscureText = false,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: lightgreen,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      width: double.infinity,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 5),
        child: TextFormField(
          readOnly: readOnly,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            icon: Icon(
              icon,
              color: deepdarkblue,
              size: 30,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: hintColor,
              fontSize: fontSize,
              fontFamily: 'Playfair Display',
            ),
            border: InputBorder.none,
          ),
          onSaved: onSaved,
          onTap: onTap ,
          validator: validator,
          obscureText: obscureText,
          cursorColor: darkblue,
        ),
      ),
    );
  }
}
