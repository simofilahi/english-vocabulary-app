import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lenglish/constants.dart';

class CircleWithIcon extends StatefulWidget {
  final Color color;
  final String iconName;
  final double iconHeight;
  final double iconWidth;
  final Function func;
  final int wordObjIndex;
  final String word;

  CircleWithIcon({
    this.color,
    this.iconName,
    this.iconHeight,
    this.iconWidth,
    this.func,
    this.wordObjIndex,
    this.word,
  });
  @override
  _CircleWithIconState createState() => _CircleWithIconState();
}

class _CircleWithIconState extends State<CircleWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: 60.0,
      decoration: BoxDecoration(
        color: widget.color,
        shape: BoxShape.circle,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            widget.func(widget.wordObjIndex, widget.word);
          },
          child: Center(
            child: SvgPicture.asset(
              widget.iconName,
              height: widget.iconHeight,
              width: widget.iconWidth,
              color: whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
