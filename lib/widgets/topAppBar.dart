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

  TopAppBar({
    this.icon_1,
    this.icon_2,
    this.text,
    this.textSize,
    this.color = primaryGreyColor,
    this.fontWeight = FontWeight.normal,
  });

  Widget _leading(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        height: 30.0,
        width: 30.0,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          shape: BoxShape.circle,
          boxShadow: [
            shadow(Theme.of(context).cardColor),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            icon_1,
            height: 20.0,
            width: 20.0,
            color: Theme.of(context).textSelectionColor,
          ),
        ),
      ),
    );
  }

  Widget _center(BuildContext context) {
    return Container(
      height: 30.0,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(
          15.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 2.0,
        ),
        child: Center(
          child: TextWidget(
            text: text,
            size: textSize,
            color: Theme.of(context).textSelectionColor,
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
          color: Theme.of(context).cardColor,
          shape: BoxShape.circle,
          boxShadow: [
            shadow(Theme.of(context).cardColor),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            icon_2,
            height: 20.0,
            width: 20.0,
            color: Theme.of(context).indicatorColor,
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
          children: <Widget>[
            icon_1 != null
                ? Expanded(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: _leading(context)),
                  )
                : Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(),
                    ),
                  ),
            Expanded(flex: 1, child: _center(context)),
            icon_2 != null
                ? Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: _tailing(context),
                    ),
                  )
                : Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
