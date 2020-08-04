import 'package:flutter/material.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:lenglish/widgets/textWidget.dart';

import '../constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Widget screen;
  final double buttonHeightSize;
  final double buttonWidthSize;
  final Color color;
  final bool navFlag;
  final String selectedLang;
  // final Function saveLang;
  CustomButton({
    this.text,
    this.screen,
    this.buttonWidthSize = 0.0,
    this.buttonHeightSize = 0.0,
    this.color = primaryBlueColor,
    this.navFlag,
    this.selectedLang = null,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      child: InkWell(
        onTap: () {
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
        },
        child: Container(
          height: buttonHeightSize == 0 ? 55 : buttonHeightSize,
          width: buttonWidthSize == 0.0 ? size.width * .80 : buttonWidthSize,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              10.0,
            ),
            boxShadow: [
              shadow(Theme.of(context).cardColor),
            ],
          ),
          child: Center(
            child: TextWidget(
              text: text,
              size: 18.0,
              color: whiteColor,
            ),
          ),
        ),
      ),
      color: Colors.transparent,
    );
  }
}
