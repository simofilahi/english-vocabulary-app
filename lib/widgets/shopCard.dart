import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lenglish/widgets/textWidget.dart';

import '../constants.dart';
import 'customButton.dart';

class ShopCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
        top: 4.0,
        bottom: 4.0,
        left: 2.0,
        right: 2.0,
      ),
      child: Container(
        height: 160,
        width: size.width * .90,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(
            15.0,
          ),
          boxShadow: [
            shadow(Theme.of(context).cardColor),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextWidget(
                          text: 'Premium account',
                          size: 20.0,
                          color: Theme.of(context).textSelectionColor,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        TextWidget(
                          text: 'Remove ads',
                          color: Theme.of(context).cursorColor,
                          size: 16.0,
                        ),
                      ],
                    ),
                  ),
                  CustomButton(
                    text: 'Buy',
                    buttonHeightSize: 40.0,
                    buttonWidthSize: 150.0,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.only(
                  right: 30.0,
                ),
                margin: const EdgeInsets.only(
                  bottom: 20.0,
                ),
                child: FittedBox(
                  child: SvgPicture.asset(
                    crownIcon,
                    height: 80.0,
                    width: 80.0,
                    color: primaryYellow,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
