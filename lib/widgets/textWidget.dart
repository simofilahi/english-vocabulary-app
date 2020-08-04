import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  TextWidget({
    this.text,
    this.size,
    this.color,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
