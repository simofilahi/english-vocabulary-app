import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/models/CustomPopupMenu.dart';

class TopAppBar extends StatelessWidget {
  final String icon_1;
  final String icon_2;
  final int icon_2_flag;
  final String text;
  final double textSize;
  final Color color;
  final FontWeight fontWeight;
  final Function clickHandler;

  TopAppBar({
    this.icon_1,
    this.icon_2,
    this.icon_2_flag = 0,
    this.text,
    this.textSize,
    this.color = primaryGreyColor,
    this.fontWeight = FontWeight.normal,
    this.clickHandler = null,
  });

  Widget _leading(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(
        20.0,
      ),
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
          child: FittedBox(
            child: SvgPicture.asset(
              icon_1,
              height: 20.0,
              width: 20.0,
              color: Theme.of(context).textSelectionColor,
            ),
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

  List choices = [
    CustomPopupMenu(
      title: 'Reset all',
      icon: SvgPicture.asset(
        restoreIcon,
      ),
    ),
  ];

  Widget _child(BuildContext context) {
    if (icon_2_flag == 1) {
      return PopupMenuButton(
        icon: SvgPicture.asset(
          icon_2,
          height: 20.0,
          width: 20.0,
          color: Theme.of(context).indicatorColor,
        ),
        onSelected: (dynamic _) {
          resetAll(clickHandler);
        },
        elevation: 3.2,
        initialValue: choices[0],
        tooltip: 'This is tooltip',
        // onSelected: _select,
        itemBuilder: (BuildContext context) {
          return choices.map((choice) {
            return PopupMenuItem(
              height: 20.0,
              value: choice,
              child: Text(choice.title),
            );
          }).toList();
        },
      );
    } else if (icon_2_flag == 2) {
      return InkWell(
        onTap: () {
          clickHandler();
        },
        child: FittedBox(
          child: SvgPicture.asset(
            icon_2,
            height: 20.0,
            width: 20.0,
            color: Theme.of(context).indicatorColor,
          ),
        ),
      );
    } else {
      return FittedBox(
        child: SvgPicture.asset(
          icon_2,
          height: 20.0,
          width: 20.0,
          color: Theme.of(context).indicatorColor,
        ),
      );
    }
  }

  Widget _tailing(BuildContext context) {
    return InkWell(
      onTap: () {
        print("yoyoyyoyyooyoyo");
        if (icon_2_flag == 1) {}
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
          child: _child(context),
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
