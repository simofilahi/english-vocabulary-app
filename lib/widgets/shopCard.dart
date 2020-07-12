import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lenglish/widgets/textWidget.dart';

import '../constants.dart';
import 'customButton.dart';

class ShopCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 160,
      width: size.width * .90,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(
          15.0,
        ),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextWidget(
                      text: 'Premium account',
                      size: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    TextWidget(
                      text: 'Remove ads',
                      color: Colors.grey[700],
                      size: 16.0,
                    ),
                  ],
                ),
                CustomButton(
                  text: 'Buy',
                  buttonHeightSize: 40.0,
                  buttonWidthSize: 150.0,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              right: 30.0,
            ),
            margin: const EdgeInsets.only(
              bottom: 20.0,
            ),
            child: SvgPicture.asset(
              crownIcon,
              height: 80.0,
              width: 80.0,
              color: primaryYellow,
            ),
          ),
        ],
      ),
    );
  }
}
