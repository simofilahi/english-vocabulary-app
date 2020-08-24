import 'package:flutter/material.dart';
import 'package:Steria/widgets/topAppBar.dart';
import 'package:random_string/random_string.dart';
import 'package:responsive_grid/responsive_grid.dart';
import '../constants.dart';
import 'package:Steria/widgets/textWidget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Steria/logic/BoolSetter.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:Steria/models/responsive.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Steria/logic/checkConnection.dart';

class SpellingGame extends StatefulWidget {
  final List<dynamic> globalData;
  final String lang;
  final int index;
  final Function getIndex;
  final int hintPoints;
  final Function getHintPoints;
  final int answerPoints;
  final Function getAnswerPoints;
  final dynamic size;

  SpellingGame({
    this.globalData,
    this.lang,
    this.index,
    this.getIndex,
    this.hintPoints,
    this.getHintPoints,
    this.answerPoints,
    this.getAnswerPoints,
    this.size,
  });
  @override
  _SpellingGameState createState() => _SpellingGameState();
}

class _SpellingGameState extends State<SpellingGame> {
  final TextEditingController _controller = TextEditingController(text: '');
  List<Map<String, dynamic>> _listOfchar = [];
  String _word = "";
  String _enWord = "";
  int _index = 0;
  bool spinner = false;
  bool _useKeyBoard = false;
  List<dynamic> _dataRowChar = [];
  final double borderRadius = 10.0;
  bool _inputError = false;
  int _hintPoints = 0;
  int _answerPoints = 0;
  bool _finish = false;
  FocusNode _focusNode = FocusNode();
  bool _rewardAdLoaded = false;
  final formKey = GlobalKey<FormState>();
  RewardedVideoAd videoAd = RewardedVideoAd.instance;
  BannerAd _bannerAd;
  FToast fToast;
  String bannerId = 'ca-app-pub-2078580912080341/5987401309';
  String videoRewa = 'ca-app-pub-2078580912080341/1782887822';

  @override
  void initState() {
    super.initState();
    setState(() {
      spinner = true;
      _index = widget.index;
      _hintPoints = widget.hintPoints;
      _answerPoints = widget.answerPoints;
    });
    fToast = FToast(context);
    _initialAds();
    _rewardListener(widget.size);
    _loadRewardAd(widget.size);
    _getNextItem();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        FocusScope.of(context).requestFocus(_focusNode);
      }
    });
  }

  _loadBannerAd() {
    _bannerAd.load();
  }

  _initialAds() async {
    try {
      await _bannerAd.dispose();
    } catch (_) {}
    _bannerAd = null;
    _bannerAd = createBannerAd();
    _loadBannerAd();
  }

  _showBannerAd() {
    _bannerAd.show(
      horizontalCenterOffset: 0,
      anchorOffset: widget.size.height * 0.01,
    );
  }

  _rewardListener(var size) {
    videoAd.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      if (event == RewardedVideoAdEvent.loaded) {
        setState(() {
          _rewardAdLoaded = true;
        });
      }
      print("hollllllllllllllcccccccccccccccccccccccccca");
      if (event == RewardedVideoAdEvent.rewarded) {
        print("holllllllllllllla");
        print(rewardAmount);
        if (rewardAmount != null) _updateHintAnswerPoints(rewardAmount);
      }
      if (event == RewardedVideoAdEvent.closed) _loadRewardAd(widget.size);
      if (event == RewardedVideoAdEvent.failedToLoad) {
        _loadRewardAd(widget.size);
      }
    };
  }

  _loadRewardAd(var size) {
    try {
      videoAd.load(
        adUnitId: videoRewa,
      );
    } catch (_) {
      _showToast('Ad doesn\'t loaded please try again', size);
    }
  }

  _showRewardAd(var size) {
    try {
      videoAd.show();
    } catch (_) {
      _showToast('Ad doesn\'t loaded please try again', size);
    }
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
          TextWidget(
            text: text,
            size: size.width * 0.045,
            color: whiteColor,
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 4),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    try {
      await _bannerAd.dispose();
    } catch (_) {}
    try {
      widget.getIndex();
      widget.getHintPoints();
      widget.getAnswerPoints();
      fToast.removeCustomToast();
      fToast.removeQueuedCustomToasts();
    } catch (error) {
      print("catch Error");
      print(error);
    }
  }

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: bannerId,
      size: AdSize.smartBanner,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
        if (event == MobileAdEvent.loaded) {
          _showBannerAd();
        }
        if (event == MobileAdEvent.failedToLoad) {
          _initialAds();
        }
      },
    );
  }

  void _getRandomWords() {
    String element = '';
    List<Map<String, dynamic>> arr = [];

    element = randomAlpha(5);

    element.runes.forEach((int rune) {
      var character = new String.fromCharCode(rune);
      var obj = {'char': character.toLowerCase(), 'selected': false};
      arr.add(obj);
    });
    _enWord.runes.forEach((int rune) {
      var character = new String.fromCharCode(rune);
      var obj = {'char': character, 'selected': false};
      arr.add(obj);
    });
    arr.shuffle();
    setState(() {
      _listOfchar = arr;
    });
  }

  void _getNextHelper() async {
    Map<dynamic, dynamic> data = {};

    data = await searchForWordByIndex(widget.globalData, _index, widget.lang);
    _updataIndexAndWord(data['enWord'], data['translatedWord']);
    _getRandomWords();
  }

  void _getNextItem() {
    if (_index < 2265) {
      updateIndexOfSpellingWords(_index);
      _getNextHelper();
    } else {
      if (_index == 2265) {
        updateIndexOfSpellingWords(2265);
      }
      setState(() {
        _finish = true;
      });
    }
  }

  _updataIndexAndWord(String enWord, String word) {
    setState(() {
      _index = _index + 1;
      _enWord = enWord;
      _word = word;
    });
  }

  _pushToListOfChar(var char) {
    List<dynamic> data = List<dynamic>.from(_dataRowChar);
    data.add(char);
    setState(() {
      _dataRowChar = data;
    });
  }

  _setTrueSelectedChar(int index) {
    List<Map<String, dynamic>> newData =
        List<Map<String, dynamic>>.from(_listOfchar);
    newData[index]['selected'] = true;
    _pushToListOfChar(newData[index]['char']);
    setState(() {
      _listOfchar = newData;
    });
  }

  _updateHintAnswerPoints(int points) async {
    await addinghintPoints(points);
    await addingAnswerPoints(points);
    setState(() {
      _hintPoints += points;
      _answerPoints += points;
    });
  }

  bool _wordMatch() {
    List<dynamic> arr = [];
    _enWord.runes.forEach((int rune) {
      var character = String.fromCharCode(rune);
      arr.add(character);
    });
    if (arr.length == _dataRowChar.length) return true;
    return false;
  }

  _fillForHelp(int flag, var size) async {
    if (!_wordMatch() && !(_controller.text == _enWord)) {
      setState(() {
        _inputError = false;
      });
      bool ret = await substractHintPoints(2);

      if (ret) {
        int len = _enWord.runes.length;
        int half = (len ~/ 2).toInt();
        var newWord = "";
        if (_dataRowChar.isEmpty && flag == 1) {
          newWord = _enWord.substring(0, half);
        } else if (_controller.text.isEmpty && flag == 2) {
          newWord = _enWord.substring(0, half);
        } else {
          newWord = _enWord.substring(0, len);
        }

        int value = await getHintPoints();
        if (flag == 2) {
          _controller.text = newWord;
          setState(() {
            _hintPoints = value;
          });
        } else {
          List<dynamic> arr = [];
          newWord.runes.forEach((int rune) {
            var character = String.fromCharCode(rune);
            arr.add(character);
          });
          setState(() {
            _dataRowChar = arr;
            _listOfchar = _listOfchar.map((e) {
              for (int i = 0; i < arr.length; i++) {
                if (arr[i] == e['char']) {
                  e['selected'] = true;
                  break;
                }
              }
              return e;
            }).toList();
            _hintPoints = value;
          });
        }
      } else {
        _showToast('You need coins, Watch an ads', size);
      }
    }
  }

  bool _verfieAnswer(int flag) {
    if (flag == 1) {
      if (_dataRowChar.isEmpty) return false;
      for (int i = 0; i < _dataRowChar.length; i++) {
        if (_dataRowChar[i] != _enWord[i]) {
          return false;
        }
      }
      setState(() {
        _dataRowChar = [];
      });
      return true;
    } else if (flag == 2) {
      if (_controller.text == _enWord)
        return true;
      else
        return false;
    }
    return false;
  }

  Widget _hintAndWatchAdButton(
      BuildContext context, String icon, int flag, var size, Responsive res) {
    return Container(
        height: size.height * 0.08,
        width: size.height * 0.08,
        child: Stack(
          children: <Widget>[
            Center(
              child: InkWell(
                onTap: () async {
                  bool ret = await checkConnection();
                  if (flag == 1) {
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
                  } else if (flag == 2) {
                    if (!_useKeyBoard)
                      _fillForHelp(1, size);
                    else
                      _fillForHelp(2, size);
                  } else if (flag == 3) {
                    if (_useKeyBoard == true)
                      _showAnswer(2, size);
                    else
                      _showAnswer(1, size);
                  }
                },
                child: Container(
                  height: size.height * 0.078,
                  width: size.height * 0.078,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(
                      res.borderRadiusSize * 0.4,
                    ),
                    boxShadow: [
                      shadow(Theme.of(context).cardColor),
                    ],
                  ),
                  child: Center(
                    child: FittedBox(
                      child: SvgPicture.asset(
                        icon,
                        height: res.iconSize * 1.5,
                        width: res.iconSize * 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            (icon == hintIcon || icon == answerIcon)
                ? Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: size.height * 0.025,
                      width: size.height * 0.025,
                      decoration: BoxDecoration(
                          color:
                              flag == 2 ? Color(0XFFffc107) : Color(0XFFF64779),
                          shape: BoxShape.circle,
                          boxShadow: [
                            shadow(Theme.of(context).cardColor),
                          ]),
                      child: Center(
                        child: TextWidget(
                          text: flag == 3
                              ? _answerPoints.toString()
                              : _hintPoints.toString(),
                          color: whiteColor,
                          size: res.textSize * 0.6,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ));
  }

  Widget _inputBar(var size, Responsive res) {
    return Container(
      height: size.height * 0.07,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(
          res.borderRadiusSize * 0.5,
        ),
        border: Border.all(
          color: _inputError ? Colors.red : whiteColor,
          width: _inputError ? size.width * 0.003 : 0.0,
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: res.leftPaddingSize * 2),
          child: TextField(
            autofocus: true,
            focusNode: _focusNode,
            onSubmitted: (String value) {
              if (_verfieAnswer(2)) {
                _controller.text = "";
                _getNextItem();
              } else {
                _controller.text = "";
                setState(() {
                  _inputError = true;
                  _dataRowChar = [];
                  _listOfchar = _listOfchar.map((e) {
                    e['selected'] = false;
                    return e;
                  }).toList();
                });
              }
            },
            controller: _controller,
            style: TextStyle(
              fontSize: res.textSize * 1.2,
              color: Colors.grey[600],
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              suffix: _inputError
                  ? Padding(
                      padding: EdgeInsets.only(right: res.rightPaddingSize * 2),
                      child: GestureDetector(
                        onTap: () {
                          _showAnswer(2, size);
                        },
                        child: Text(
                          'Show me',
                          style: TextStyle(
                            color: primaryBlueColor,
                            fontSize: res.textSize,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ),
          ),
        ),
      ),
    );
  }

  _removeButtonEventHandler() {
    List<dynamic> data = List<dynamic>.from(_dataRowChar);
    var char = data[data.length - 1];
    List<Map<String, dynamic>> newData =
        List<Map<String, dynamic>>.from(_listOfchar);

    for (int i = 0; i < newData.length; i++) {
      if (newData[i]['char'] == char) {
        if (newData[i]['selected'] != false) {
          newData[i]['selected'] = false;
          break;
        }
      }
    }
    data.removeLast();
    setState(() {
      _dataRowChar = data;
      _listOfchar = newData;
    });
  }

  Widget _enterAndRemove(var size, Responsive res) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            if (_verfieAnswer(1)) {
              _getNextItem();
            } else {
              setState(() {
                _inputError = true;
                _dataRowChar = [];
                _listOfchar = _listOfchar.map((e) {
                  e['selected'] = false;
                  return e;
                }).toList();
              });
            }
          },
          child: Container(
            height: size.height * .072,
            width: size.height * .072,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(
                res.borderRadiusSize * 0.5,
              ),
              boxShadow: [
                shadow(Theme.of(context).cardColor),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(
                enterIcon,
                height: res.iconSize,
                width: res.iconSize,
                color: whiteColor,
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        InkWell(
          onTap: () {
            _removeButtonEventHandler();
          },
          child: Container(
            height: size.height * .072,
            width: size.height * .072,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
              boxShadow: [
                shadow(Theme.of(context).cardColor),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(
                deleteIcon,
                height: res.iconSize,
                width: res.iconSize,
                color: whiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _listItem(int index, var size, Responsive res) {
    return ResponsiveGridCol(
      xs: 3,
      child: Padding(
        padding: EdgeInsets.all(
          res.allPaddingSize * 0.4,
        ),
        child: InkWell(
          onTap: () {
            setState(() {
              _inputError = false;
            });
            _setTrueSelectedChar(index);
          },
          child: Container(
            height: size.height * 0.07,
            width: size.height * 0.07,
            alignment: Alignment(0, 0),
            decoration: BoxDecoration(
              color: _listOfchar[index]['selected'] == true
                  ? primaryColor
                  : Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(
                res.borderRadiusSize * 0.4,
              ),
              boxShadow: [
                _listOfchar[index]['selected'] == true
                    ? shadow(Theme.of(context).cardColor)
                    : shadow_1(Theme.of(context).cardColor == blackGrey
                        ? blackGrey
                        : null),
              ],
            ),
            child: _listOfchar[index]['selected'] == false
                ? TextWidget(
                    text: _listOfchar[index]['char'],
                    color: Theme.of(context).textSelectionColor,
                    size: res.textSize * 0.8,
                    fontWeight: FontWeight.w400,
                  )
                : Container(),
          ),
        ),
      ),
    );
  }

  Widget _keyBoard(var size, Responsive res) {
    return ResponsiveGridRow(
      children: [
        ..._listOfchar
            .asMap()
            .map(
              (index, element) => MapEntry(
                index,
                _listItem(index, size, res),
              ),
            )
            .values
            .toList(),
      ],
    );
  }

  _showAnwerHelper(int flag, var size) async {
    if (_dataRowChar.isEmpty && _controller.text != _enWord) {
      bool ret = await substractAnswerPoints(4);

      if (ret) {
        if (flag == 2) {
          _controller.text = _enWord;
          setState(() {
            _inputError = false;
          });
        } else {
          List<dynamic> arr = [];
          _enWord.runes.forEach((int rune) {
            var character = String.fromCharCode(rune);
            arr.add(character);
          });
          setState(() {
            _inputError = false;
            _dataRowChar = arr;
            _listOfchar = _listOfchar.map((e) {
              for (int i = 0; i < arr.length; i++) {
                if (arr[i] == e['char']) {
                  e['selected'] = true;
                  break;
                }
              }
              return e;
            }).toList();
          });
        }
        int value = await getAnswerPoints();
        setState(() {
          _answerPoints = value;
        });
      } else {
        _showToast('You need coins, watch an ads', size);
      }
    }
  }

  _showAnswer(int flag, var size) {
    _showAnwerHelper(flag, size);
  }

  Widget _inputRow(var size, Responsive res) {
    return Container(
      height: size.height * .07,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: _inputError ? Colors.red : whiteColor,
          width: _inputError ? 1.0 : 0.0,
        ),
        color: whiteColor,
        borderRadius: BorderRadius.circular(
          res.borderRadiusSize * 0.5,
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(
            left: res.leftPaddingSize,
          ),
          child: _inputError
              ? Padding(
                  padding: EdgeInsets.only(right: res.rightPaddingSize * 2.5),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        _showAnswer(1, size);
                      },
                      child: Text(
                        'Show me',
                        style: TextStyle(
                          color: primaryBlueColor,
                          fontSize: res.textSize,
                        ),
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _dataRowChar.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: res.leftPaddingSize,
                        bottom: res.bottomPaddingSize * 1.5,
                        top: res.topPaddingSize * 1.5,
                      ),
                      child: Container(
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            boxShadow: [
                              shadow_1(Theme.of(context).cardColor == blackGrey
                                  ? blackGrey
                                  : null),
                            ],
                            borderRadius: BorderRadius.circular(
                              borderRadius,
                            )),
                        child: Center(
                          child: TextWidget(
                            text: _dataRowChar[index],
                            color: Theme.of(context).textSelectionColor,
                            size: res.textSize * 0.8,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }

  _nextSet(var size) async {
    if (_index < 2265) {
      bool ret = await substractAnswerPoints(4);
      if (ret) {
        int index = await getIndexOfSpellingWords();
        if (index < 2265) {
          index += 1;
          updateIndexOfSpellingWords(index);
          int points = await getAnswerPoints();
          setState(() {
            _index = index;
            _answerPoints = points;
          });
          _getNextItem();
        }
      } else
        _showToast('You need coins, Watch an ads', size);
    } else {
      if (_index == 2265) {
        updateIndexOfSpellingWords(2265);
      }
      setState(() {
        _finish = true;
      });
    }
  }

  Widget _bottomWidget(var size, Responsive res) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: res.horizontalPaddingSize,
          vertical: res.verticalPaddingSize,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _hintAndWatchAdButton(context, watchIcon, 1, size, res),
            Row(
              children: <Widget>[
                _hintAndWatchAdButton(context, answerIcon, 3, size, res),
                SizedBox(
                  width: size.width * 0.015,
                ),
                _hintAndWatchAdButton(context, hintIcon, 2, size, res),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _centerWidget(var size, Responsive res) {
    return Expanded(
      flex: 4,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _word,
              style: TextStyle(
                fontSize: res.textSize * 1.5,
                color: Theme.of(context).textSelectionColor,
              ),
            ),
            SizedBox(
              height: size.height * .03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: res.horizontalPaddingSize,
                vertical: res.verticalPaddingSize,
              ),
              child: Column(
                children: <Widget>[
                  _useKeyBoard == true
                      ? _inputBar(
                          size,
                          res,
                        )
                      : _inputRow(size, res),
                  SizedBox(
                    height: res.sizedBoxHeightSize,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _useKeyBoard = !_useKeyBoard;
                            _inputError = false;
                          });
                        },
                        child: FittedBox(
                          child: Text(
                            _useKeyBoard == true
                                ? 'Use hand tap'
                                : 'Use keyboard',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: primaryBlueColor,
                              fontSize: res.textSize,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      SvgPicture.asset(
                        _useKeyBoard ? handTapIcon : keyBoardIcon,
                        height: res.iconSize * 1.2,
                        width: res.iconSize * 1.2,
                        color: primaryBlueColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child:
                            !_useKeyBoard ? _keyBoard(size, res) : Container(),
                      ),
                      Expanded(
                        flex: 1,
                        child: !_useKeyBoard
                            ? Padding(
                                padding: EdgeInsets.only(
                                  left: res.leftPaddingSize * 8,
                                ),
                                child: _enterAndRemove(size, res),
                              )
                            : Container(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Responsive res = Responsive(
      containerHeightSize: size.height * .08,
      containerWidthSize: size.width * .90,
      sizedBoxHeightSize: size.height * 0.028,
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
          child: Column(
            children: <Widget>[
              TopAppBar(
                icon_1: backArrowIcon,
                icon_2: forwardIcon,
                icon_2_flag: 2,
                text: '${_index}/2265',
                textSize: 18,
                clickHandler: _nextSet,
                size: size,
              ),
              _finish
                  ? Expanded(
                      child: Center(
                        child: Container(
                          height: size.height * .10,
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Congrats',
                                style: TextStyle(
                                  fontSize: res.textSize * 1.5,
                                  color: Theme.of(context).textSelectionColor,
                                ),
                              ),
                              Text(
                                'You did it',
                                style: TextStyle(
                                  fontSize: res.textSize,
                                  color: Theme.of(context).textSelectionColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: res.sizedBoxHeightSize * 4.2,
                    ),
              !_finish ? _centerWidget(size, res) : Container(),
              !_finish ? _bottomWidget(size, res) : Container(),
              Container(
                height: size.height * .10,
                width: size.width,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
