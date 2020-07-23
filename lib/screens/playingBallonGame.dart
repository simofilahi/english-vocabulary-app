import 'dart:math';

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
  final _random = new Random();
  bool _boolean = false;
  String _word;
  String _en_word;
  List _randomWords = [];
  int _set = 1;
  int _index = 0;
  int _initIndex = 0;

  @override
  void initState() {
    super.initState();
    print("after");
    _index = getIndexOfFlyingSquare();
    _getNextItem();
    _getRandomWords();
    setState(() {
      _initIndex = _index;
    });
  }

  dynamic _getSetItem() {
    var data;
    for (int i = 0; i < widget.globalData.length; i++) {
      return widget.globalData[i]['set_${_set}'];
    }
  }

  void _getRandomWords() {
    final List randomWords = [];
    var data = _getSetItem();
    for (int i = 0; i < 2; i++) {
      var element = data[_random.nextInt(data.length)];
      randomWords.add(getRightTranslate(null, element, 0, widget.lang));
    }
    randomWords.add(_word);
    setState(() {
      _randomWords = randomWords;
    });
  }

  void _getNextItem() {
    int i = 1;
    int j = 0;
    String word;
    String en_word;
    int indexx;

    if (_index == _initIndex + 10) {
      updateIndexOfFlyingSquare(_index);
    } else {
      widget.globalData.forEach(
        (item) {
          item['set_${i}'].forEach(
            (f) {
              if (j == _index) {
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
      _getRandomWords();
    }
  }

  _updataIndexAndWord(String en_word, String word) {
    setState(() {
      _index = _index + 1;
      _en_word = en_word;
      _word = word;
    });
  }

  _failureHandler() {
    setState(
      () {
        _boolean = true;
      },
    );
  }

  tryAgain() {
    setState(
      () {
        _boolean = false;
      },
    );
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
                    TopAppBar(text: '${_index}/2000'),
                    _boolean == false
                        ? TextWidget(
                            text: _en_word,
                            size: 24.0,
                          )
                        : Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _index = 0;
                                        _boolean = false;
                                      });
                                    },
                                    child: Container(
                                      height: 50.0,
                                      width: 160.0,
                                      decoration: BoxDecoration(
                                        color: whiteColor,
                                        borderRadius: BorderRadius.circular(
                                          15.0,
                                        ),
                                      ),
                                      child: Center(
                                        child: TextWidget(
                                          text: 'Try again',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50.0,
                                  width: 200.0,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(
                                      15.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: TextWidget(
                                      text: 'Watch Ads',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    Container(),
                  ],
                ),
              ),
            ),
            _boolean == false
                ? AnimatedBalloon(
                    globalData: widget.globalData,
                    text: _word,
                    getNextItem: _getNextItem,
                    updateIndex: _updataIndexAndWord,
                    randomWords: _randomWords,
                    failureHandler: _failureHandler,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
