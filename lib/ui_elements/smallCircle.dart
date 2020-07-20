import 'package:flutter/material.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/widgets/textWidget.dart';

class SmallCircle extends StatelessWidget {
  final int number;
  final Color firstColor;

  SmallCircle({
    this.number,
    this.firstColor,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: firstColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: TextWidget(
          text: number.toString(),
          size: 8.0,
          color: whiteColor,
        ),
      ),
    );
  }
}
