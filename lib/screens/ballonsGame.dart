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
  int _index_2 = 0;
  int _hintPoints = 0;

  @override
  void initState() {
    super.initState();
    _getIndex();
    _getIndex_2();
    _getHintPoints();
    print(widget.globalData);
  }

  _getIndex_2() {
    getIndexOfSpellingWords().then((value) {
      setState(() {
        _index_2 = value;
      });
    });
  }

  _getIndex() async {
    int value = await getIndexOfSqaureFlying();
    setState(() {
      _index = value;
    });
  }

  _getHintPoints() async {
    int value = await getHintPoints();
    setState(() {
      _hintPoints = value;
    });
  }

  void updateIndex(index) {
    updateIndexOfFlyingSquare(index);
  }

  Widget _card(
      String gameTitle, String gameDes, var screen, String icon, var size) {
    return FittedBox(
      child: Padding(
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
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(
              15.0,
            ),
            boxShadow: [
              shadow(Theme.of(context).cardColor),
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
                          FittedBox(
                            child: TextWidget(
                              text: gameTitle,
                              size: 20.0,
                              color: Theme.of(context).textSelectionColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          FittedBox(
                            child: TextWidget(
                              text: gameDes,
                              color: Theme.of(context).indicatorColor,
                              size: 16.0,
                            ),
                          ),
                        ],
                      ),
                      FittedBox(
                        child: CustomButton(
                          text: 'Start',
                          screen: screen,
                          buttonHeightSize: 40.0,
                          buttonWidthSize: 150.0,
                          navFlag: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.only(
                    right: 30.0,
                  ),
                  margin: const EdgeInsets.only(
                    bottom: 20.0,
                  ),
                  child: FittedBox(
                    child: SvgPicture.asset(
                      icon,
                      height: 80.0,
                      width: 80.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
            shadow(Theme.of(context).cardColor),
          ],
        ),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.red[400].withOpacity(
                  0.8,
                ),
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
              ),
              child: Center(
                child: TextWidget(
                  text: 'More games are coming soon',
                  color: whiteColor,
                  size: 20.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        height: size.height,
        width: size.width,
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
                        cubeIcon,
                        size),
                    _card(
                      'Spelling',
                      'improves writing skill',
                      SpellingGame(
                        globalData: widget.globalData,
                        lang: widget.lang,
                        index: _index_2,
                        getIndex: _getIndex_2,
                        hintPoints: _hintPoints,
                        getHintPoints: _getHintPoints,
                      ),
                      abcIcon,
                      size,
                    ),
                    _moreGameCard(size),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
