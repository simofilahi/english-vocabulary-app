import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/models/responsive.dart';

class AnimatedBalloon extends StatefulWidget {
  final List<dynamic> globalData;
  final String text;
  final Function getNextItem;
  final Function updateIndex;
  final List randomWords;
  final Function failureHandler;
  final Responsive res;

  const AnimatedBalloon({
    this.globalData,
    this.text,
    this.getNextItem,
    this.updateIndex,
    this.randomWords,
    this.failureHandler,
    this.res,
  });
  @override
  _AnimatedBalloonState createState() => _AnimatedBalloonState();
}

class _AnimatedBalloonState extends State<AnimatedBalloon>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animationFloatUp;
  Animation<double> _animationFloatDown;
  Animation<double> _animationGrowSize;
  final bool bottom = true;
  bool flag = false;
  double marginValue = 0;
  double _balloonHeight;
  double _balloonWidth;
  double _balloonBottomLocation;
  List _arrayNum = [0, 1, 2];
  final _random = new Random();
  int _i = 0;
  int _j = 0;
  int _k = 0;

  @override
  void initState() {
    super.initState();

    _generateRandomIndex();
    _controller =
        AnimationController(duration: Duration(seconds: 10), vsync: this)
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              widget.failureHandler();
            }
          });
    ;
  }

  _generateRandomIndex() {
    var i = 0;
    var j = 0;
    var k = 0;

    while (true) {
      i = _arrayNum[_random.nextInt(_arrayNum.length)];
      j = _arrayNum[_random.nextInt(_arrayNum.length)];
      k = _arrayNum[_random.nextInt(_arrayNum.length)];
      if (i != j && i != k && j != k) {
        break;
      }
    }
    setState(() {
      _i = i;
      _j = j;
      _k = k;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _balloonHeight = 120;
    _balloonWidth = 120;
    print(_balloonHeight);
    print(_balloonWidth);
    _balloonBottomLocation = MediaQuery.of(context).size.height;

    _animationFloatUp = Tween(
      begin: _balloonBottomLocation,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 1.0, curve: Curves.easeOut),
      ),
    );
    if (_controller.isCompleted) {
      _controller.reset();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _item(Color color, int index) {
    return GestureDetector(
      onTap: () {
        if (widget.text == widget.randomWords[index]) {
          _controller.reset();
          widget.getNextItem();
          _generateRandomIndex();
          _controller.forward();
        } else {
          _controller.reset();
          widget.failureHandler();
        }
      },
      child: Container(
        height: widget.res.buttonWidthSize,
        width: widget.res.buttonWidthSize,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            widget.res.borderRadiusSize,
          ),
          boxShadow: [
            BoxShadow(
              color: primaryGreyColor.withOpacity(
                0.2,
              ),
              blurRadius: 20.0,
              spreadRadius: 5.0,
            )
          ],
        ),
        child: Center(
          child: TextWidget(
            text: widget.randomWords[index],
            color: whiteColor,
            size: widget.res.textSize * 1.2,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: AnimatedBuilder(
        animation: _animationFloatUp,
        builder: (context, child) {
          return Container(
            child: child,
            color: Colors.transparent,
            margin: EdgeInsets.only(
              top: _animationFloatUp.value,
              bottom: 0,
              // left: _animationGrowSize.value * 0.25,
            ),
            // width: _animationGrowSize.value,
          );
        },
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      _item(Colors.pink[300], _i),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: widget.res.sizedBoxHeightSize * 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: widget.res.leftPaddingSize * 6,
                  ),
                  child: _item(Colors.red[300], _j),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: widget.res.leftPaddingSize * 6,
                  ),
                  child: _item(Colors.blue[300], _k),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
