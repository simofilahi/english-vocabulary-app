import 'dart:math';
import 'package:flutter/material.dart';
import 'package:Steria/constants.dart';
import 'package:Steria/logic/BoolSetter.dart';
import 'package:Steria/widgets/ballonAnimation.dart';
import 'package:Steria/widgets/textWidget.dart';
import 'package:Steria/widgets/topAppBar.dart';
import 'package:Steria/logic/initalizeFiles.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:Steria/models/responsive.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Steria/logic/checkConnection.dart';

class PlayingBallonGames extends StatefulWidget {
  final List<dynamic> globalData;
  final String lang;
  final int index;
  final Function getIndex;
  var size;

  PlayingBallonGames({
    this.globalData,
    this.lang,
    this.index,
    this.getIndex,
    this.size,
  });
  @override
  _PlayingBallonGamesState createState() => _PlayingBallonGamesState();
}

class _PlayingBallonGamesState extends State<PlayingBallonGames> {
  final _random = new Random();
  bool _boolean = false;
  String _word = "";
  String _enWord = "";
  List _randomWords = [];
  int _set = 1;
  int _index = 0;
  int _initIndex = 0;
  int _counter = 0;
  bool spinner = false;
  bool _finish = false;
  RewardedVideoAd videoAd = RewardedVideoAd.instance;
  FToast fToast;
  int _points = 0;
  bool _rewardAdLoaded = false;
  String videoRewa = 'ca-app-pub-2078580912080341/9497726311';

  @override
  void initState() {
    super.initState();

    fToast = FToast(context);
    setState(() {
      spinner = true;
      _index = widget.index;
      _initIndex = widget.index;
      _finish = _index < 2265 ? false : true;
      _counter = widget.index == 1 ? 1 : widget.index - 1;
    });

    if (!_finish) {
      _getNextItem(0);
      _getRandomWords();
    }
    _rewardListener();
    _loadRewardAd(widget.size);
  }

  @override
  void dispose() {
    super.dispose();
    widget.getIndex();
    fToast.removeCustomToast();
    fToast.removeQueuedCustomToasts();
  }

  _rewardListener() {
    videoAd.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      if (event == RewardedVideoAdEvent.loaded) {
        setState(() {
          _rewardAdLoaded = true;
        });
      }
      if (event == RewardedVideoAdEvent.rewarded) {
        print("here is amount ========> ${rewardAmount}");
        if (rewardAmount != null) {
          setState(() {
            _points = rewardAmount;
          });
        }
      }
      if (event == RewardedVideoAdEvent.closed) {
        _loadRewardAd(widget.size);
        if (_points > 0) {
          _getNextItem(1);
        }
      }
      if (event == RewardedVideoAdEvent.failedToLoad) {
        _loadRewardAd(widget.size);
      }
    };
  }

  _showToast(String text, var size) {
    Widget toast = Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.08,
        vertical: size.height * 0.02,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          size.width * 0.0469,
        ),
        color: Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.question_answer,
            size: size.height * 0.032,
            color: whiteColor,
          ),
          SizedBox(
            width: size.width * 0.02,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: size.width * 0.045,
              color: whiteColor,
            ),
          )
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }

  _loadRewardAd(var size) {
    try {
      videoAd.load(
        adUnitId: videoRewa,
      );
    } catch (_) {}
  }

  _showRewardAd(var size) {
    try {
      videoAd.show();
    } catch (_) {}
  }

  dynamic _getSetItem() {
    print("set ${_set}");
    return widget.globalData[_set == 0 ? _set : _set - 1]['set_${_set}'];
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
    playLocal('assets/audio/${data['enWord']}.mp3');
    _updataIndexAndWord(data['enWord'], data['translatedWord']);
    _getRandomWords();
  }

  void _getNextItem(int flag) async {
    print(flag);
    int setNumber = await searchForSetByIndex(widget.index, widget.globalData);
    setState(() {
      _set = setNumber;
    });
    print("set_************************** ${_set}");
    print(_points);
    print(_points);
    print(_points);
    if (_index > 2265) {
      setState(() {
        _finish = true;
      });
    } else {
      if (_index < 2265) {
        if (_index == _initIndex + 49) {
          updateIndexOfFlyingSquare(_index + 1);
          if (flag == 1) {
            setState(() {
              _initIndex = _index + 1;
              _points = _points == 2 || _points == 4 ? _points - 2 : 0;
              _boolean = false;
            });
          } else {
            setState(() {
              _initIndex = _index + 1;
              _boolean = false;
            });
          }
          _getNextItemHelper();
        } else {
          if (flag == 1) {
            setState(() {
              _points = _points == 2 || _points == 4 ? _points - 2 : 0;
              _boolean = false;
            });
          } else {
            setState(() {
              _boolean = false;
            });
          }
          _getNextItemHelper();
        }
      } else {
        updateIndexOfFlyingSquare(_index);
        setState(() {
          _finish = true;
        });
      }
    }
  }

  _updataIndexAndWord(String enWord, String word) {
    setState(() {
      _index = _index + 1;
      _enWord = enWord;
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

  Widget _renderButtons(Responsive res, var size) {
    if (_boolean == false) {
      return Text(
        _enWord,
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
                    _getNextItem(0);
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
                          text: 'Start again',
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
              onTap: () async {
                if (_points > 0) {
                  _getNextItem(1);
                } else {
                  bool ret = await checkConnection();
                  if (ret == true) {
                    if (_rewardAdLoaded == true) {
                      setState(() {
                        _rewardAdLoaded = false;
                      });
                      _showRewardAd(size);
                    } else {
                      _showToast('No ad found, please try again', size);
                      setState(() {
                        _rewardAdLoaded = true;
                      });
                    }
                  } else {
                    _showToast('No Internet Connection', size);
                  }
                }
              },
              child: Padding(
                padding: EdgeInsets.all(
                  res.allPaddingSize * 0.8,
                ),
                child: Container(
                  height: res.buttonHeightSize * 1.2,
                  width: res.buttonWidthSize * 1.8,
                  decoration: BoxDecoration(
                    color: primaryBlueColor,
                    borderRadius: BorderRadius.circular(
                      res.borderRadiusSize,
                    ),
                    boxShadow: [
                      shadow(
                        Theme.of(context).cardColor,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _points == 0
                            ? FittedBox(
                                child: SvgPicture.asset(
                                  watchIcon,
                                  height: res.iconSize * 1.3,
                                  width: res.iconSize * 1.3,
                                ),
                              )
                            : Container(),
                        SizedBox(
                          width: size.width * 0.04,
                        ),
                        TextWidget(
                          text: _points == 0
                              ? 'Watch an ad to continue'
                              : 'Continue',
                          color: whiteColor,
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
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                height: size.height,
                width: size.width,
                color: Theme.of(context).backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TopAppBar(
                      icon_1: backArrowIcon,
                      text: '${_counter + 1}/2265',
                    ),
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
              _boolean == false && _finish == false
                  ? Container(
                      height: size.height,
                      width: size.width,
                      color: Colors.transparent,
                      child: AnimatedBalloon(
                          globalData: widget.globalData,
                          text: _word,
                          getNextItem: _getNextItem,
                          updateIndex: _updataIndexAndWord,
                          randomWords: _randomWords,
                          failureHandler: _failureHandler,
                          res: res),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
