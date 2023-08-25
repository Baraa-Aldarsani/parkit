// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final Alignment alignment;
  String text;
  var fontWeight;
  var fontFamily;
  final double fontSize;
  final Color color;
  final int maxLine;
  final double height;
  CustomText({super.key,
    this.alignment = Alignment.topLeft,
    this.text = '',
    this.fontSize = 16,
    this.color = Colors.black,
    this.maxLine = 1,
    this.height = 1,
    this.fontWeight,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(text,
          style: TextStyle(fontSize: fontSize, color: color, height: height,fontWeight: fontWeight,fontFamily: fontFamily),
          maxLines: maxLine),
    );
  }
}
