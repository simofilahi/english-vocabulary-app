import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_math/vector_math_64.dart' as math;

import '../constants.dart';

class RadialProgress extends StatefulWidget {
  final double goalCompleted;
  final double percent;
  final double height;
  final double width;
  final Color color;
  final bool flag;

  RadialProgress(
      {this.goalCompleted,
      this.percent,
      this.height,
      this.width,
      this.color,
      this.flag});
  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  AnimationController _radialProgressAnimationController;
  Animation<double> _progressAnimation;
  final Duration fadeInDuration = Duration(milliseconds: 500);
  final Duration fillDuration = Duration(seconds: 2);

  double progressDegrees = 0;
  var count = 0;
  var counter = 0;

  @override
  void initState() {
    super.initState();
    print("yes yes");
    print(widget.percent);
    _radialProgressAnimationController =
        AnimationController(vsync: this, duration: fillDuration);
    _progressAnimation = Tween(begin: 0.0, end: 360.0).animate(CurvedAnimation(
        parent: _radialProgressAnimationController, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {
          progressDegrees = widget.goalCompleted * _progressAnimation.value;
        });
      });

    _radialProgressAnimationController.forward();
  }

  @override
  void dispose() {
    _radialProgressAnimationController.dispose();
    super.dispose();
  }

  Widget _content() {
    if (widget.flag) {
      return Column(children: <Widget>[
        SvgPicture.asset(
          rocketIcon,
          height: 30.0,
          width: 30.0,
        ),
        SizedBox(
          height: 10.0,
        ),
      ]);
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: widget.height,
        width: widget.width,
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: fadeInDuration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _content(),
              Text(
                '${widget.percent.toStringAsPrecision(3)}%',
                style: TextStyle(
                  fontSize: widget.flag == true ? 15.0 : 10.0,
                  fontWeight: FontWeight.w500,
                  color: whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
      painter: RadialPainter(progressDegrees, widget.color, widget.flag),
    );
  }
}

class RadialPainter extends CustomPainter {
  double progressInDegrees;
  final Color color;
  final bool flag;

  RadialPainter(this.progressInDegrees, this.color, this.flag);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = flag == false ? 6.0 : 8.0;

    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width / 2, paint);

    Paint progressPaint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = flag == false ? 6.0 : 8.0;

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(-90),
        math.radians(progressInDegrees),
        false,
        progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
