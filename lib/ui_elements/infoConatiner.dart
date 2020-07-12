import 'package:flutter/material.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/ui_elements/smallCircle.dart';
import 'package:lenglish/widgets/textWidget.dart';

class InfoContainer extends StatelessWidget {
  final Color firstColor;
  final Color secondColor;

  InfoContainer({this.firstColor, this.secondColor});
  Widget _item(var text) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5.0,
        left: 10.0,
      ),
      child: Row(
        children: <Widget>[
          SmallCircle(
            firstColor: firstColor,
          ),
          SizedBox(
            width: 10.0,
          ),
          TextWidget(
            text: text,
            size: 16.0,
            color: whiteColor,
          ),
        ],
      ),
    );
  }

  Widget _bottomButton() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 80.0,
            height: 25.0,
            decoration: BoxDecoration(
              color: firstColor,
              borderRadius: BorderRadius.circular(
                10.0,
              ),
            ),
            child: Center(
              child: TextWidget(
                text: 'Reset',
                color: whiteColor.withOpacity(0.8),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondColor.withOpacity(
          0.6,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(
            30.0,
          ),
          topRight: Radius.circular(
            30.0,
          ),
          bottomRight: Radius.circular(
            10.0,
          ),
          bottomLeft: Radius.circular(
            10.0,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 5.0,
          ),
          _item('sets'),
          _item('total words'),
          _item('learning words'),
          _bottomButton()
        ],
      ),
    );
  }
}
