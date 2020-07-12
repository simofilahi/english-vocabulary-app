import 'package:flutter/material.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/widgets/ballonAnimation.dart';
import 'package:lenglish/widgets/customButton.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/widgets/topAppBar.dart';

class PlayingBallonGames extends StatefulWidget {
  @override
  _PlayingBallonGamesState createState() => _PlayingBallonGamesState();
}

class _PlayingBallonGamesState extends State<PlayingBallonGames> {
  final int counter = 0;

  // Widget _customButton(var size, String text, Color color) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(
  //       horizontal: 20.0,
  //       vertical: 10.0,
  //     ),
  //     child: Material(
  //       child: InkWell(
  //         onTap: () {
  //           // watch ads or try again,
  //         },
  //         child: Container(
  //           height: 55,
  //           width: size.width * .80,
  //           decoration: BoxDecoration(
  //             color: color,
  //             borderRadius: BorderRadius.circular(
  //               10.0,
  //             ),
  //           ),
  //           child: Center(
  //             child: TextWidget(
  //               text: text,
  //               size: 18.0,
  //               color: whiteColor,
  //             ),
  //           ),
  //         ),
  //       ),
  //       color: Colors.transparent,
  //     ),
  //   );
  // }

  // Widget _counter() {
  //   return TextWidget(
  //     text: counter.toString(),
  //     size: 18,
  //     color: Colors.grey[700],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: <Widget>[
            // SafeArea(
            //   child: Column(
            //     children: <Widget>[
            //       TopAppBar(
            //         backArrowIcon,
            //         null,
            //         'Flying Ballons',
            //         18.0,
            //         true,
            //       ),
            //     ],
            //   ),
            // ),
            // Center(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       _customButton(
            //         size,
            //         'Start again',
            //         primaryBlueColor,
            //       ),
            //       _customButton(
            //         size,
            //         'Watch an ads to continue',
            //         primaryBlueColor,
            //       ),
            //     ],
            //   ),
            // ),
            AnimatedBalloon(),
          ],
        ),
      ),
    );
  }
}
