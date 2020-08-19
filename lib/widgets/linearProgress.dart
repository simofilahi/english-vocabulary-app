import 'package:flutter/material.dart';

class LinearProgress extends StatefulWidget {
  final int value;

  LinearProgress({this.value});
  @override
  _LinearProgressState createState() => new _LinearProgressState();
}

class _LinearProgressState extends State<LinearProgress>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  double value = 0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
          value = widget.value / 10;
        });
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            50.0,
          ),
        ),
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.black12,
        ),
      ),
    ));
  }
}
