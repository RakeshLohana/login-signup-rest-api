import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final Color? textColor;
  final int? maxLines;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CustomTextWidget(
      {super.key,
      required this.text,
      this.maxLines,
      this.textColor,
      this.textAlign,
      this.fontSize,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines ?? 1,
      style: TextStyle(
          color: textColor ?? Colors.black,
          fontWeight: fontWeight,
          fontSize: fontSize),
    );
  }
}
