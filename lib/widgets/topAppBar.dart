import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/widgets/textWidget.dart';

class TopAppBar extends StatelessWidget {
  final String icon_1;
  final String icon_2;
  final String text;
  final double textSize;
  final Color color;
  final FontWeight fontWeight;

  TopAppBar(
      {this.icon_1,
      this.icon_2,
      this.text,
      this.textSize,
      this.color = primaryGreyColor,
      this.fontWeight = FontWeight.normal});

  Widget _leading(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        height: 30.0,
        width: 30.0,
        decoration: BoxDecoration(
          color: whiteColor,
          shape: BoxShape.circle,
          boxShadow: [
            shadow,
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            icon_1,
            height: 20.0,
            width: 20.0,
            color: primaryGreyColor,
          ),
        ),
      ),
    );
  }

  Widget _center() {
    return Container(
      height: 30.0,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(
          15.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 2.0,
        ),
        child: Center(
          child: TextWidget(
            text: text,
            size: textSize,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _tailing(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        height: 30.0,
        width: 30.0,
        decoration: BoxDecoration(
          color: whiteColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 20.0,
              color: Colors.black26,
            )
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            icon_2,
            height: 20.0,
            width: 20.0,
            color: primaryGreyColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            icon_1 != null ? _leading(context) : Container(),
            _center(),
            icon_2 != null ? _tailing(context) : Container(),
          ],
        ),
      ),
    );
  }
}
