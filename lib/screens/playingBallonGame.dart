import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:lenglish/widgets/ballonAnimation.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/widgets/topAppBar.dart';
import 'package:lenglish/logic/initalizeFiles.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class PlayingBallonGames extends StatefulWidget {
  final List<dynamic> globalData;
  final String lang;
  final int index;
  final Function getIndex;

  PlayingBallonGames({this.globalData, this.lang, this.index, this.getIndex});
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
  bool spinner = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      spinner = true;
      _index = widget.index;
      _initIndex = widget.index;
    });
    _getNextItem();
    _getRandomWords();
    print("here init index");
    print(widget.index);
  }

  @override
  void dispose() {
    super.dispose();
    widget.getIndex();
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

  playLocal(path) async {
    // print("Here is the path");
    // print(path);
    // player.play(path);

    assetsAudioPlayer.open(
      Audio(path),
    );
  }

  void _getNextItem() {
    int i = 1;
    int j = 0;
    String word;
    String en_word;

    if (_index == _initIndex + 5) {
      updateIndexOfFlyingSquare(_index);
      print("helllllllo");
      print(_index);
      setState(() {
        _initIndex = _index + 1;
      });
    } else {
      widget.globalData.forEach(
        (item) {
          item['set_${i}'].forEach(
            (f) {
              print("here index");
              print(_index);
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
      playLocal('assets/audio/${en_word}.mp3');
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

  Widget _renderButtons() {
    if (_boolean == false) {
      return TextWidget(
        text: _en_word,
        size: 24.0,
      );
    } else {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  playLocal('assets/audio/${_en_word}.mp3');
                  setState(() {
                    _index = widget.index;
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
                      boxShadow: [shadow]),
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
                boxShadow: [shadow],
              ),
              child: Center(
                child: TextWidget(
                  text: 'Watch Ads',
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

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
                color: primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TopAppBar(icon_1: backArrowIcon, text: '${_index}/2265'),
                    _renderButtons(),
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
