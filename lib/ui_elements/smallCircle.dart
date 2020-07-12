import 'package:flutter/material.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/widgets/textWidget.dart';

class SmallCircle extends StatelessWidget {
  final Color firstColor;

  SmallCircle({
    this.firstColor,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        color: firstColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: TextWidget(
          text: '1',
          size: 8.0,
          color: whiteColor,
        ),
      ),
    );
  }
}
