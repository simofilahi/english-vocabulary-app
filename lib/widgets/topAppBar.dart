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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          icon_1 != null
              ? Padding(
                  padding: EdgeInsets.only(
                    left: 20.0,
                    top: 5.0,
                  ),
                  child: Container(
                    // decoration: BoxDecoration(
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.black12,
                    //       blurRadius: 20.0,
                    //       spreadRadius: 2.0,
                    //     )
                    //   ],
                    // ),
                    child: GestureDetector(
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
                            icon_1,
                            height: 20.0,
                            width: 20.0,
                            color: primaryYellow,
                            // color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.only(
              top: 10.0,
            ),
            child: Container(
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
            ),
          ),
          icon_2 != null
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 5.0,
                  ),
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
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
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                    right: 25.0,
                    top: 5.0,
                  ),
                  child: SizedBox(),
                ),
        ],
      ),
    );
  }
}
