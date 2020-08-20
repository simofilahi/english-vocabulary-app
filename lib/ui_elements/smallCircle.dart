import 'package:flutter/material.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/models/responsive.dart';

class SmallCircle extends StatelessWidget {
  final int number;
  final Color firstColor;

  SmallCircle({
    this.number,
    this.firstColor,
  });
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Responsive res = Responsive(
      containerHeightSize: size.height * 0.0354,
      containerWidthSize: size.height * 0.0354,
      textSize: size.width * 0.025,
    );

    return Container(
      height: res.containerHeightSize,
      width: res.containerHeightSize,
      decoration: BoxDecoration(
        color: firstColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: TextWidget(
          text: number.toString(),
          size: res.textSize,
          color: whiteColor,
        ),
      ),
    );
  }
}
