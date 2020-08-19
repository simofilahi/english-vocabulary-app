import 'package:flutter/material.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/models/responsive.dart';
import '../constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Widget screen;
  final double buttonHeightSize;
  final double buttonWidthSize;
  final Color color;
  final bool navFlag;
  final String selectedLang;
  final double textSize;
  final Responsive res;
  final Function clickHandler;
  // final Function saveLang;
  CustomButton({
    this.text,
    this.screen = null,
    this.buttonWidthSize = 0.0,
    this.buttonHeightSize = 0.0,
    this.color = primaryBlueColor,
    this.navFlag,
    this.selectedLang = null,
    this.textSize = 0,
    this.res,
    this.clickHandler = null,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FittedBox(
      child: Material(
        child: InkWell(
          onTap: () {
            if (screen == null) {
              clickHandler();
            } else {
              if (navFlag == true) {
                updateSelectedLanguage(selectedLang).then(
                  (v) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext ctx) => screen,
                      ),
                    );
                  },
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext ctx) => screen,
                  ),
                );
              }
            }
          },
          child: Container(
            height: buttonHeightSize,
            width: buttonWidthSize,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(
                res.borderRadiusSize * 0.5,
              ),
              boxShadow: [
                shadow(Theme.of(context).cardColor),
              ],
            ),
            child: Center(
              child: TextWidget(
                text: text,
                size: textSize,
                color: whiteColor,
              ),
            ),
          ),
        ),
        color: Colors.transparent,
      ),
    );
  }
}
