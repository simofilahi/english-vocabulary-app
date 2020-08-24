import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Steria/constants.dart';

class CircleWithIcon extends StatefulWidget {
  final Color color;
  final String iconName;
  final double iconHeight;
  final double iconWidth;
  final int index;
  final Function func;
  final String word;

  CircleWithIcon({
    this.color,
    this.iconName,
    this.iconHeight,
    this.iconWidth,
    this.index,
    this.func,
    this.word,
  });
  @override
  _CircleWithIconState createState() => _CircleWithIconState();
}

class _CircleWithIconState extends State<CircleWithIcon> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      borderRadius: BorderRadius.circular(
        size.width * 0.0469 * 4,
      ),
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          widget.func(widget.index, widget.word);
        },
        borderRadius: BorderRadius.circular(
          size.width * 0.0469 * 4,
        ),
        highlightColor: rippleColor,
        child: Padding(
          padding: EdgeInsets.all(
            size.width * 0.008,
          ),
          child: Container(
            height: size.height * 0.08,
            width: size.height * 0.08,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
            ),
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
      ),
    );
  }
}
