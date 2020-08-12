import 'package:flutter/material.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/ui_elements/smallCircle.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/models/responsive.dart';

class InfoContainer extends StatelessWidget {
  final int setNumber;
  final int totalWords;
  final int learningWords;
  final Color firstColor;
  final Color secondColor;
  final Function reset;
  final Responsive res;

  InfoContainer({
    this.setNumber,
    this.totalWords,
    this.learningWords,
    this.firstColor,
    this.secondColor,
    this.reset,
    this.res,
  });

  Widget _item(var text, int number, var size) {
    Responsive res_1 = Responsive(
      topPaddingSize: size.height * 0.009,
      bottomPaddingSize: size.height * 0.005,
      leftPaddingSize: size.width * 0.02,
      sizedBoxWidthSize: size.width * 0.03,
      textSize: size.width * 0.042,
    );
    return Padding(
      padding: EdgeInsets.only(
        left: res_1.leftPaddingSize,
        bottom: res_1.bottomPaddingSize,
      ),
      child: Row(
        children: <Widget>[
          SmallCircle(
            number: number,
            firstColor: firstColor,
          ),
          SizedBox(
            width: res_1.sizedBoxWidthSize,
          ),
          TextWidget(
            text: text,
            size: res_1.textSize,
            color: whiteColor,
          ),
        ],
      ),
    );
  }

  Widget _bottomButton(var size) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: res.bottomPaddingSize,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              reset();
            },
            child: Container(
              height: size.height * 0.04,
              width: size.width * 0.3,
              decoration: BoxDecoration(
                color: firstColor,
                borderRadius: BorderRadius.circular(
                  res.borderRadiusSize * 0.5,
                ),
              ),
              child: Center(
                child: TextWidget(
                  text: 'Reset',
                  color: whiteColor.withOpacity(0.8),
                  size: size.width * 0.042,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: secondColor.withOpacity(
          0.6,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            res.borderRadiusSize,
          ),
          topRight: Radius.circular(
            res.borderRadiusSize,
          ),
          bottomRight: Radius.circular(
            res.borderRadiusSize * 0.8,
          ),
          bottomLeft: Radius.circular(
            res.borderRadiusSize * 0.8,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(
                top: res.topPaddingSize,
                bottom: res.bottomPaddingSize,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: res.topPaddingSize * 3,
                  bottom: res.bottomPaddingSize * 1.2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _item('set', setNumber, size),
                    _item('total words', totalWords, size),
                    _item('learning words', learningWords, size),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: _bottomButton(size),
          )
        ],
      ),
    );
  }
}
