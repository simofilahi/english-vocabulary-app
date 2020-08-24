import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final double letterSpacing;

  TextWidget({
    this.text,
    this.size,
    this.color,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
    this.letterSpacing = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: size,
          color: color,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
        ),
      ),
    );
  }
}
