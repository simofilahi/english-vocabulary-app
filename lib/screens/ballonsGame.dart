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

  Widget _card(var size) {
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
                          text: 'Balloons game',
                          size: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        TextWidget(
                          text: 'Helps for memorazing',
                          color: Colors.grey[700],
                          size: 16.0,
                        ),
                      ],
                    ),
                    CustomButton(
                      text: 'Start',
                      screen: PlayingBallonGames(
                        globalData: widget.globalData,
                        lang: widget.lang,
                        index: _index,
                        getIndex: _getIndex,
                      ),
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
                  right: 30.0,
                ),
                margin: const EdgeInsets.only(
                  bottom: 20.0,
                ),
                child: SvgPicture.asset(
                  ballonIcon,
                  height: 80.0,
                  width: 80.0,
                  color: Colors.red[500],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoItem(var size, String text, int wordsCount, double progress) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 8.0,
      ),
      child: Container(
        height: 150.0,
        width: size.width * .25,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextWidget(
                    text: wordsCount.toString(),
                    size: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextWidget(
                    text: text,
                    size: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 5.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(
                        30.0,
                      ),
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: primaryBlueColor,
                        borderRadius: BorderRadius.circular(
                          30.0,
                        ),
                      ),
                    ),
                  )
                ],
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
              text: 'Flying Balloons',
              textSize: 18,
            ),
            SizedBox(
              height: 50.0,
            ),
            _card(size),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 210,
              width: size.width * .90,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(
                  20.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 0.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 5.0,
                        top: 10.0,
                        bottom: 12.0,
                      ),
                      child: TextWidget(
                        text: 'Latest round',
                        size: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: _infoItem(
                            size,
                            'Familiar',
                            10,
                            10.0,
                          ),
                        ),
                        Expanded(
                          child: _infoItem(
                            size,
                            'Unknowns',
                            50,
                            50.0,
                          ),
                        ),
                        Expanded(
                          child: _infoItem(
                            size,
                            'Excelent',
                            40,
                            40.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
