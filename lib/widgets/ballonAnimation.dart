import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lenglish/constants.dart';

class AnimatedBalloon extends StatefulWidget {
  const AnimatedBalloon({Key key}) : super(key: key);

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
    print('Holla');
    _balloonHeight = 120;
    _balloonWidth = 120;
    print(_balloonHeight);
    print(_balloonWidth);
    _balloonBottomLocation = MediaQuery.of(context).size.height;

    _animationFloatUp = Tween(begin: _balloonBottomLocation, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    // _animationGrowSize = Tween(begin: 50.0, end: _balloonWidth).animate(
    //   CurvedAnimation(
    //     parent: _controller,
    //     curve: Interval(0.0, 0.75, curve: Curves.elasticInOut),
    //   ),
    // );

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
    print('margin value');
    print(marginValue);
    print('flag');
    print(flag);
    if (flag) {
      print('inside');
      return Container(
        height: 100.0,
        width: 100.0,
        color: Colors.red,
        margin: EdgeInsets.only(top: 0),
      );
    } else {
      return GestureDetector(
        child: SvgPicture.asset(
          ballonIcon,
          height: 200,
          width: 200,
          color: color,
        ),
        onTap: () {
          setState(() {
            flag = !flag;
            marginValue = _animationFloatUp.value;
          });
          _controller.reverse();
          // _controller.forward();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedBuilder(
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
                child: _item(Colors.deepOrange),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              AnimatedBuilder(
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
                child: _item(Colors.deepOrange),
              ),
              AnimatedBuilder(
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
                child: _item(Colors.deepOrange),
              )
            ],
          ),
        ],
      ),
    );
  }
}
