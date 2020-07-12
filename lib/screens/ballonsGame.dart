import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/screens/playingBallonGame.dart';
import 'package:lenglish/widgets/customButton.dart';
import 'package:lenglish/widgets/topAppBar.dart';

class BallonsGame extends StatefulWidget {
  BallonsGame({Key key}) : super(key: key);

  @override
  _BallonsGameState createState() => _BallonsGameState();
}

class _BallonsGameState extends State<BallonsGame> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: primaryColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TopAppBar(
              icon_1: null,
              icon_2: null,
              text: 'Flying Balloons',
              textSize: 18,
            ),
            CustomButton(
              text: 'Start Game',
              screen: PlayingBallonGames(),
              navFlag: false,
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
