import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:lenglish/screens/playingBallonGame.dart';
import 'package:lenglish/widgets/customButton.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/widgets/topAppBar.dart';
import 'package:lenglish/screens/spellingGame.dart';
import 'package:lenglish/models/responsive.dart';
import 'package:lenglish/logic/initalizeFiles.dart';
import 'package:lenglish/models/CustomPopupMenu.dart';

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
  int _answerPoints = 0;

  @override
  void initState() {
    super.initState();
    indexFile_2.setItem('index', [
      {"index": "2263"}
    ]).then((value) {
      _getIndex();
      _getIndex_2();
      _getHintPoints();
      _getAnswerPoints();
      // print(widget.globalData);
    });
  }

  _getAnswerPoints() async {
    int value = await getAnswerPoints();
    setState(() {
      _answerPoints = value;
    });
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

  Widget _resetButton(var size, Responsive res, String icon_2, int flag) {
    return PopupMenuButton(
      icon: SvgPicture.asset(
        icon_2,
        height: res.iconSize,
        width: res.iconSize,
        color: Theme.of(context).cursorColor,
      ),
      onSelected: (dynamic _) {
        if (flag == 0) {
          resetFlyingSquaresGame();
          _getIndex();
        } else if (flag == 1) {
          resetSpellingGame();
          _getIndex_2();
        }
      },
      elevation: 1.0,
      initialValue: choices[0],
      itemBuilder: (BuildContext context) {
        return choices.map((choice) {
          return PopupMenuItem(
            height: size.height * 0.02,
            value: choice,
            child: Text(
              choice.title,
              style: TextStyle(
                fontSize: res.textSize,
              ),
            ),
          );
        }).toList();
      },
    );
  }

  List choices = [
    CustomPopupMenu(
      title: 'Reset',
      icon: SvgPicture.asset(
        restoreIcon,
      ),
    ),
  ];

  Widget _card(String gameTitle, String gameDes, var screen, String icon,
      var size, Responsive res, int flag) {
    return FittedBox(
      child: Padding(
        padding: EdgeInsets.only(
          top: res.topPaddingSize,
          bottom: res.bottomPaddingSize,
        ),
        child: Container(
          height: size.height * .3,
          width: size.width * .90,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(
              res.borderRadiusSize * 0.8,
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
                  padding: EdgeInsets.all(res.allPaddingSize * 4),
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
                              size: res.textSize * 1.5,
                              color: Theme.of(context).textSelectionColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.004,
                          ),
                          TextWidget(
                            text: gameDes,
                            color: Theme.of(context).indicatorColor,
                            size: res.textSize,
                          ),
                        ],
                      ),
                      CustomButton(
                        text: 'Start',
                        textSize: res.textSize,
                        screen: screen,
                        buttonHeightSize: res.buttonHeightSize,
                        buttonWidthSize: res.buttonWidthSize,
                        navFlag: false,
                        res: res,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: res.bottomPaddingSize * 3,
                          left: res.leftPaddingSize * 24,
                          top: res.topPaddingSize,
                        ),
                        child: Container(
                          child: _resetButton(size, res, moreIcon, flag),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: res.rightPaddingSize * 4,
                        ),
                        child: FittedBox(
                          child: SvgPicture.asset(
                            icon,
                            height: res.iconSize * 4,
                            width: res.iconSize * 4,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _moreGameCard(var size, Responsive res) {
    return Padding(
      padding: EdgeInsets.only(
        top: res.topPaddingSize,
        bottom: res.bottomPaddingSize,
        left: res.leftPaddingSize,
        right: res.rightPaddingSize,
      ),
      child: Container(
        height: size.height * .3,
        width: size.width * .90,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(
            res.borderRadiusSize * 0.8,
          ),
          boxShadow: [
            shadow(Theme.of(context).cardColor),
          ],
        ),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0XFFBE5062), Color(0XFFEF4A76)],
                ),
                borderRadius: BorderRadius.circular(
                  res.borderRadiusSize * 0.8,
                ),
              ),
              child: Center(
                child: TextWidget(
                  text: 'More games are coming soon',
                  color: whiteColor,
                  size: res.textSize * 1.2,
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
    Responsive res = Responsive(
      containerHeightSize: size.height * .08,
      containerWidthSize: size.width * .90,
      sizedBoxHeightSize: size.height * 0.02,
      sizedBoxWidthSize: size.width * 0.0310,
      horizontalPaddingSize: size.width * 0.06,
      verticalPaddingSize: size.height * 0.0055,
      borderRadiusSize: size.width * 0.0469,
      bottomPaddingSize: size.height * 0.0055,
      topPaddingSize: size.height * 0.0055,
      rightPaddingSize: size.width * 0.0085,
      leftPaddingSize: size.width * 0.0085,
      textSize: size.width * 0.05,
      iconSize: size.height * 0.032,
      allPaddingSize: size.width * 0.02,
      buttonHeightSize: size.height * 0.06,
      buttonWidthSize: size.width * 0.4,
    );
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
              ),
              SizedBox(
                height: res.sizedBoxHeightSize,
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: res.horizontalPaddingSize,
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
                        size,
                        res,
                        0),
                    _card(
                      'Spelling',
                      'Improves writing skill',
                      SpellingGame(
                        globalData: widget.globalData,
                        lang: widget.lang,
                        index: _index_2,
                        getIndex: _getIndex_2,
                        hintPoints: _hintPoints,
                        getHintPoints: _getHintPoints,
                        answerPoints: _answerPoints,
                        getAnswerPoints: _getAnswerPoints,
                        height: size.height,
                      ),
                      abcIcon,
                      size,
                      res,
                      1,
                    ),
                    _moreGameCard(size, res),
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
