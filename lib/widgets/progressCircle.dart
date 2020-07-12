import 'package:flutter/material.dart';
import 'package:lenglish/widgets/radialProgress.dart';

class ProgressCircle extends StatelessWidget {
  const ProgressCircle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadialProgress(
      height: 200,
      width: 200,
      flag: false,
    );
  }
}
