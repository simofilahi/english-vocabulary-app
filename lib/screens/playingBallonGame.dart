import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:lenglish/widgets/ballonAnimation.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/widgets/topAppBar.dart';
import 'package:lenglish/logic/initalizeFiles.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:lenglish/models/responsive.dart';
import 'package:flutter_svg/svg.dart';

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
  String _word = "";
  String _en_word = "";
  List _randomWords = [];
  int _set = 1;
  int _index = 0;
  int _initIndex = 0;
  int _counter = 0;
  bool spinner = false;
  bool _finish = false;
  RewardedVideoAd videoAd = RewardedVideoAd.instance;

  @override
  void initState() {
    super.initState();

    setState(() {
      spinner = true;
      _index = widget.index;
      _initIndex = widget.index;
      _finish = _index < 2264 ? false : true;
      _counter = widget.index == 1 ? 1 : widget.index - 1;
    });

    if (!_finish) {
      _getNextItem();
      _getRandomWords();
    }
    _loadAds();
    videoAd.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print("RewardedVideoAd event $event");
      print("amount $rewardAmount");
      _getNextItem();
      setState(() {
        _boolean = false;
      });
      if (event == RewardedVideoAdEvent.rewarded) {}
    };
  }

  @override
  void dispose() {
    super.dispose();
    widget.getIndex();
  }

  dynamic _getSetItem() {
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
    assetsAudioPlayer.open(
      Audio(path),
    );
  }

  void _getNextItemHelper() async {
    Map<dynamic, dynamic> data = {};

    data = await searchForWordByIndex(widget.globalData, _index, widget.lang);
    print(data);
    playLocal('assets/audio/${data['enWord']}.mp3');
    _updataIndexAndWord(data['enWord'], data['translatedWord']);
    _getRandomWords();
  }

  void _getNextItem() {
    if (_index <= 2264) {
      if (_index == _initIndex + 5) {
        updateIndexOfFlyingSquare(_index + 1);
        setState(() {
          _initIndex = _index + 1;
        });
        _getNextItemHelper();
      } else {
        _getNextItemHelper();
      }
    } else {
      updateIndexOfFlyingSquare(_index);
      setState(() {
        _finish = true;
      });
    }
  }

  _updataIndexAndWord(String enWord, String word) {
    setState(() {
      _index = _index + 1;
      _en_word = enWord;
      _word = word;
      _counter = _counter + 1;
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

  _loadAds() {
    videoAd.load(
      adUnitId: RewardedVideoAd.testAdUnitId,
    );
  }

  Widget _renderButtons(Responsive res, var size) {
    if (_boolean == false) {
      return Text(
        _en_word,
        style: TextStyle(
          color: Theme.of(context).textSelectionColor,
          fontSize: res.textSize * 2,
        ),
      );
    } else {
      return Column(
        children: <Widget>[
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(
              res.borderRadiusSize,
            ),
            child: InkWell(
              highlightColor: rippleColor,
              borderRadius: BorderRadius.circular(
                res.borderRadiusSize,
              ),
              onTap: () {
                getIndexOfSqaureFlying().then((value) {
                  if (value != null) {
                    setState(() {
                      _index = value;
                      _initIndex = value;
                      _counter = value == 1 ? 1 : value - 1;
                      _boolean = false;
                    });
                    _getNextItem();
                  }
                });
              },
              child: Padding(
                padding: EdgeInsets.all(
                  res.allPaddingSize * 0.8,
                ),
                child: Container(
                  height: res.buttonHeightSize * 1.2,
                  width: res.buttonWidthSize,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(
                      res.borderRadiusSize,
                    ),
                    boxShadow: [
                      shadow(Theme.of(context).cardColor),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          tryIcon,
                          height: res.iconSize * 1.2,
                          width: res.iconSize * 1.2,
                        ),
                        SizedBox(
                          width: res.containerWidthSize * 0.03,
                        ),
                        TextWidget(
                          text: 'Try again',
                          color: Theme.of(context).textSelectionColor,
                          size: res.textSize * 0.9,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(
              res.borderRadiusSize,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(
                res.borderRadiusSize,
              ),
              highlightColor: rippleColor,
              onTap: () {
                RewardedVideoAd.instance.show().then((value) {
                  print("***********8");
                  print(value);
                });
                _loadAds();
              },
              child: Padding(
                padding: EdgeInsets.all(
                  res.allPaddingSize * 0.8,
                ),
                child: Container(
                  height: res.buttonHeightSize * 1.2,
                  width: res.buttonWidthSize * 1.4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(
                      res.borderRadiusSize,
                    ),
                    boxShadow: [shadow(Theme.of(context).cardColor)],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FittedBox(
                          child: SvgPicture.asset(
                            watchIcon,
                            height: res.iconSize * 1.3,
                            width: res.iconSize * 1.3,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.04,
                        ),
                        TextWidget(
                          text: 'Watch Ads',
                          color: Theme.of(context).textSelectionColor,
                          size: res.textSize * 0.9,
                        ),
                      ],
                    ),
                  ),
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
        color: Theme.of(context).backgroundColor,
        child: Stack(
          children: <Widget>[
            SafeArea(
              child: Container(
                height: size.height,
                width: size.width,
                color: Theme.of(context).backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TopAppBar(icon_1: backArrowIcon, text: '${_counter}/2263'),
                    !_finish
                        ? _renderButtons(res, size)
                        : Center(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Congrats',
                                  style: TextStyle(
                                    fontSize: res.textSize * 1.5,
                                  ),
                                ),
                                Text(
                                  'You did it',
                                  style: TextStyle(
                                    fontSize: res.textSize,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Container(),
                  ],
                ),
              ),
            ),
            _boolean == false && _finish == false
                ? AnimatedBalloon(
                    globalData: widget.globalData,
                    text: _word,
                    getNextItem: _getNextItem,
                    updateIndex: _updataIndexAndWord,
                    randomWords: _randomWords,
                    failureHandler: _failureHandler,
                    res: res)
                : Container(),
          ],
        ),
      ),
    );
  }
}
