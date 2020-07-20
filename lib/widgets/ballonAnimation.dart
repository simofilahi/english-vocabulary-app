import 'package:flutter/material.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/widgets/textWidget.dart';

class AnimatedBalloon extends StatefulWidget {
  final List<dynamic> globalData;
  final String text;
  final Function getNextItem;
  final Function updateIndex;
  const AnimatedBalloon(
      {this.globalData, this.text, this.getNextItem, this.updateIndex});

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

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: Duration(seconds: 10), vsync: this);
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
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _item(Color color) {
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   flag = !flag;
        //   marginValue = _animationFloatUp.value;
        // });
        _controller.reset();
        print("*************");
        widget.getNextItem();
        _controller.repeat(min: 0.0, max: 1.0);
        // _controller.reverse();
        // _controller.forward();
      },
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          color: primaryBlueColor,
          borderRadius: BorderRadius.circular(
            15.0,
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
            text: widget.text,
            color: whiteColor,
          ),
        ),
      ),
    );
    // return GestureDetector(
    //   child: SvgPicture.asset(
    //     ballonIcon,
    //     height: 200,
    //     width: 200,
    //     color: color,
    //   ),
    //   onTap: () {
    //     setState(() {
    //       flag = !flag;
    //       marginValue = _animationFloatUp.value;
    //     });
    //     _controller.reset();
    //     _controller.repeat(min: 0.0, max: 1.0);
    //     // _controller.reverse();
    //     // _controller.forward();
    //   },
    // );
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
                      _item(Colors.deepOrange),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: _item(Colors.deepOrange),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 20.0,
                  ),
                  child: _item(Colors.deepOrange),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
