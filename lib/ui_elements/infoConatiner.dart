import 'package:flutter/material.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/ui_elements/smallCircle.dart';
import 'package:lenglish/widgets/textWidget.dart';

class InfoContainer extends StatelessWidget {
  final int setNumber;
  final int totalWords;
  final int learningWords;
  final Color firstColor;
  final Color secondColor;

  InfoContainer(
      {this.setNumber,
      this.totalWords,
      this.learningWords,
      this.firstColor,
      this.secondColor});
  Widget _item(var text, int number) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5.0,
        left: 10.0,
      ),
      child: Row(
        children: <Widget>[
          SmallCircle(
            number: number,
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
    return Row(
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
              text: 'Unlock',
              color: whiteColor.withOpacity(0.8),
            ),
          ),
        )
      ],
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
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                bottom: 5.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _item('set', setNumber),
                  _item('total words', totalWords),
                  _item('learning words', learningWords),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: _bottomButton(),
          )
        ],
      ),
    );
  }
}
