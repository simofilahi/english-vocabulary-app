import 'package:flutter/material.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:lenglish/widgets/ballonAnimation.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/widgets/topAppBar.dart';

class PlayingBallonGames extends StatefulWidget {
  final List<dynamic> globalData;
  final String lang;

  PlayingBallonGames({this.globalData, this.lang});
  @override
  _PlayingBallonGamesState createState() => _PlayingBallonGamesState();
}

class _PlayingBallonGamesState extends State<PlayingBallonGames> {
  String _word;
  String _en_word;

  @override
  void initState() {
    super.initState();
    _getNextItem();
  }

  int _index = 0;

  // _getIndex() {}

  void _getNextItem() {
    int i = 1;
    int j = 0;
    String word;
    String en_word;
    int indexx;

    widget.globalData.forEach(
      (item) {
        item['set_${i}'].forEach(
          (f) {
            if (j == _index) {
              print(j);
              print(_index);
              en_word = f['en'];
              word = getRightTranslate(null, f, 0, widget.lang);
            }
            j++;
          },
        );
        i++;
      },
    );
    _updataIndexAndWord(en_word, word);
  }

  _updataIndexAndWord(String en_word, String word) {
    setState(() {
      _index = _index + 1;
      _en_word = en_word;
      _word = word;
    });
  }

  String _getWordByIndex(int index) {}

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
            SafeArea(
              child: Container(
                height: size.height,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TopAppBar(text: '0/2000'),
                    TextWidget(
                      text: _en_word,
                      size: 24.0,
                    ),
                    Container(),
                  ],
                ),
              ),
            ),
            AnimatedBalloon(
              globalData: widget.globalData,
              text: _word,
              getNextItem: _getNextItem,
              updateIndex: _updataIndexAndWord,
            ),
          ],
        ),
      ),
    );
  }
}

// [
//   {

//   },
//   {

//   }
// ]
