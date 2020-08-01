import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:lenglish/logic/initalizeFiles.dart';
import 'package:lenglish/screens/playingBallonGame.dart';
import 'package:lenglish/widgets/customButton.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/widgets/topAppBar.dart';
import 'package:lenglish/screens/spellingGame.dart';

class BallonsGame extends StatefulWidget {
  final List<dynamic> globalData;
  final String lang;
  final Function globalDataUpdate;
  BallonsGame({this.globalData, this.lang, this.globalDataUpdate});

  @override
  _BallonsGameState createState() => _BallonsGameState();
}

class _BallonsGameState extends State<BallonsGame> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _getIndex();
    print(widget.globalData);
  }

  _getIndex() {
    indexFile.getItem().then((onValue) {
      if (onValue != null) {
        print("here on value");
        print(onValue);
        setState(() {
          _index = int.parse(onValue[0]['index']);
        });
      }
    });
  }

  void updateIndex(index) {
    updateIndexOfFlyingSquare(index);
  }

  Widget _shape1(var size) {
    return Container(
      color: primaryColor,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 30.0,
              width: 30.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  5.0,
                ),
                color: Colors.red,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget _card(
      String gameTitle, String gameDes, var screen, Widget shape, var size) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 4.0,
        bottom: 4.0,
        left: 2.0,
        right: 2.0,
      ),
      child: Container(
        height: 160,
        width: size.width * .90,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(
            15.0,
          ),
          boxShadow: [
            shadow,
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextWidget(
                          text: gameTitle,
                          size: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        TextWidget(
                          text: gameDes,
                          color: Colors.grey[700],
                          size: 16.0,
                        ),
                      ],
                    ),
                    CustomButton(
                      text: 'Start',
                      screen: screen,
                      buttonHeightSize: 40.0,
                      buttonWidthSize: 150.0,
                      navFlag: false,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(
                  right: 25.0,
                ),
                height: size.height * .14,
                width: size.width * .10,
                child: shape,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _moreGameCard(var size) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 4.0,
        bottom: 4.0,
        left: 2.0,
        right: 2.0,
      ),
      child: Container(
        height: 160,
        width: size.width * .90,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(
            15.0,
          ),
          boxShadow: [
            shadow,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: primaryColor,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            TopAppBar(
              icon_1: null,
              icon_2: null,
              text: 'Games',
              textSize: 18,
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15.0,
              ),
              child: ListView(
                children: <Widget>[
                  _card(
                      'Flying squares',
                      'Helps for memorizing',
                      PlayingBallonGames(
                        globalData: widget.globalData,
                        lang: widget.lang,
                        index: _index,
                        getIndex: _getIndex,
                      ),
                      _shape1(size),
                      size),
                  _card(
                    'Spelling',
                    'improves writing skill',
                    SpellingGame(),
                    _shape1(size),
                    size,
                  ),
                  _moreGameCard(size),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
