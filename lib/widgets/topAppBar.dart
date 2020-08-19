import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/models/CustomPopupMenu.dart';
import 'package:lenglish/models/responsive.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class TopAppBar extends StatelessWidget {
  final String icon_1;
  final String icon_2;
  final int icon_2_flag;
  final int icon_1_flag;
  final String text;
  final double textSize;
  final Color color;
  final FontWeight fontWeight;
  final Function clickHandler;
  var size;

  TopAppBar({
    this.icon_1,
    this.icon_2,
    this.icon_2_flag = 0,
    this.icon_1_flag = 0,
    this.text,
    this.textSize,
    this.color = primaryGreyColor,
    this.fontWeight = FontWeight.normal,
    this.clickHandler = null,
    this.size = 0,
  });

  Color _colorBuild(BuildContext context) {
    if (icon_1_flag == 1) {
      return goldColor;
    } else
      return Theme.of(context).textSelectionColor;
  }

  Widget _leading(BuildContext context, var size) {
    Responsive res = Responsive(
      containerHeightSize: size.height * 0.05,
      containerWidthSize: size.height * 0.05,
      iconSize: size.height * 0.03,
      borderRadiusSize: size.width * 0.16,
      bottomPaddingSize: size.height * 0.0086,
      allPaddingSize: size.width * 0.008,
    );
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(
        res.borderRadiusSize,
      ),
      child: InkWell(
        onTap: () {
          if (icon_1_flag != 1) {
            Navigator.of(context).pop();
          }
        },
        highlightColor: rippleColor,
        borderRadius: BorderRadius.circular(
          res.borderRadiusSize,
        ),
        child: Container(
          height: res.containerHeightSize,
          width: res.containerWidthSize,
          child: Padding(
            padding: EdgeInsets.all(
              res.allPaddingSize,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                shape: BoxShape.circle,
                boxShadow: [
                  shadow(Theme.of(context).cardColor),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: icon_1_flag == 1 ? res.bottomPaddingSize : 0.0,
                  ),
                  child: SvgPicture.asset(
                    icon_1,
                    height: res.iconSize,
                    width: res.iconSize,
                    color: _colorBuild(context),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _center(BuildContext context, var size) {
    Responsive res = Responsive(
      containerHeightSize: size.height * .045,
      containerWidthSize: size.height * 0.05,
      iconSize: size.height * 0.03,
      borderRadiusSize: size.width * 0.0469,
      bottomPaddingSize: size.height * 0.0086,
      allPaddingSize: size.width * 0.008,
      textSize: size.width * 0.045,
    );
    return Container(
      height: res.containerHeightSize,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(
          res.borderRadiusSize,
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
            size: res.textSize,
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

  _resetAllDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: 'RESET',
      desc: 'Are you sure, wanna reset all sets',
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        print("hello");
        bool ret = await resetAll();
        if (ret) clickHandler();
      },
    )..show();
  }

  Widget _child(BuildContext context, var size, Responsive res) {
    if (icon_2_flag == 1) {
      return PopupMenuButton(
        icon: SvgPicture.asset(
          icon_2,
          height: res.iconSize,
          width: res.iconSize,
          color: Theme.of(context).indicatorColor,
        ),
        onSelected: (dynamic _) {
          _resetAllDialog(context);
        },
        elevation: 1.0,
        initialValue: choices[0],
        // tooltip: 'This is tooltip',
        // onSelected: _select,
        itemBuilder: (BuildContext context) {
          return choices.map((choice) {
            return PopupMenuItem(
              height: size.height * 0.02,
              value: choice,
              child: Text(
                choice.title,
                style: TextStyle(
                  fontSize: res.textSize,
                ),
              ),
            );
          }).toList();
        },
      );
    } else if (icon_2_flag == 2) {
      return FittedBox(
        child: SvgPicture.asset(
          icon_2,
          height: res.iconSize,
          width: res.iconSize,
          color: Theme.of(context).indicatorColor,
        ),
      );
    } else {
      return FittedBox(
        child: SvgPicture.asset(
          icon_2,
          height: res.iconSize * 0.6,
          width: res.iconSize * 0.6,
          color: Theme.of(context).indicatorColor,
        ),
      );
    }
  }

  Widget _tailing(BuildContext context, var size) {
    Responsive res = Responsive(
      containerHeightSize: size.height * 0.05,
      containerWidthSize: size.height * 0.05,
      iconSize: size.height * 0.03,
      borderRadiusSize: size.width * 0.16,
      bottomPaddingSize: size.height * 0.0086,
      allPaddingSize: size.width * 0.008,
      textSize: size.width * 0.05,
    );
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(
        res.borderRadiusSize,
      ),
      child: InkWell(
        onTap: () {
          if (icon_2_flag == 2) {
            clickHandler(size);
          } else if (icon_2_flag == 3) {
            clickHandler();
            Navigator.popUntil(context, ModalRoute.withName('WordList'));
          }
        },
        highlightColor: rippleColor,
        borderRadius: BorderRadius.circular(
          res.borderRadiusSize,
        ),
        child: Container(
          height: res.containerHeightSize,
          width: res.containerWidthSize,
          child: Padding(
            padding: EdgeInsets.all(
              res.allPaddingSize,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                shape: BoxShape.circle,
                boxShadow: [
                  shadow(Theme.of(context).cardColor),
                ],
              ),
              child: Center(
                child: _child(context, size, res),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Responsive res = Responsive(
      containerHeightSize: size.height * 0.07,
      horizontalPaddingSize: size.width * 0.0325,
    );

    return Container(
      height: res.containerHeightSize,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: res.horizontalPaddingSize,
        ),
        child: Row(
          children: <Widget>[
            icon_1 != null
                ? Expanded(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: _leading(context, size)),
                  )
                : Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(),
                    ),
                  ),
            Expanded(flex: 1, child: _center(context, size)),
            icon_2 != null
                ? Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: _tailing(context, size),
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
