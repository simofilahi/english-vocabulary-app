import 'package:flutter/material.dart';
import 'package:lenglish/widgets/topAppBar.dart';
import 'package:random_string/random_string.dart';
import 'package:responsive_grid/responsive_grid.dart';
import '../constants.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:lenglish/models/responsive.dart';

class SpellingGame extends StatefulWidget {
  final List<dynamic> globalData;
  final String lang;
  final int index;
  final Function getIndex;
  final int hintPoints;
  final Function getHintPoints;
  final int answerPoints;
  final Function getAnswerPoints;
  final dynamic height;

  SpellingGame({
    this.globalData,
    this.lang,
    this.index,
    this.getIndex,
    this.hintPoints,
    this.getHintPoints,
    this.answerPoints,
    this.getAnswerPoints,
    this.height,
  });
  @override
  _SpellingGameState createState() => _SpellingGameState();
}

class _SpellingGameState extends State<SpellingGame> {
  final TextEditingController _controller = TextEditingController(text: '');
  List<Map<String, dynamic>> _listOfchar = [];
  String _word = "";
  String _enWord = "";
  int _set = 1;
  int _index = 0;
  int _initIndex = 0;
  bool spinner = false;
  bool _useKeyBoard = false;
  List<dynamic> _dataRowChar = [];
  final double borderRadius = 10.0;
  bool _inputError = false;
  int _hintPoints = 0;
  int _answerPoints = 0;
  FocusNode _focusNode = FocusNode();

  /// just  define _formkey with static final

  final formKey = GlobalKey<FormState>();

  RewardedVideoAd videoAd = RewardedVideoAd.instance;
  BannerAd _bannerAd;

  @override
  void initState() {
    super.initState();
    setState(() {
      spinner = true;
      _index = widget.index;
      _initIndex = widget.index;
      _hintPoints = widget.hintPoints;
      _answerPoints = widget.answerPoints;
    });
    print('height');
    print(widget.height - (widget.height * .6));
    _bannerAd = createBannerAd()
      ..load()
      ..show(
        horizontalCenterOffset: 0,
        anchorOffset: widget.height,
      );
    videoAd.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print("RewardedVideoAd event $event");
      print("amount $rewardAmount");
      if (event == RewardedVideoAdEvent.rewarded) {
        // if (rewardAmount == null) {
        _updateHintPoints(6);
        // }
      }
    };
    _getNextItem();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        FocusScope.of(context).requestFocus(_focusNode);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
    widget.getIndex();
    widget.getHintPoints();
    widget.getAnswerPoints();
  }

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      // targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
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
    // print("here arr ===> ");
    // print(arr);
    print("here is en_word");
    print(_enWord);
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
    if (_index == _initIndex + 5) {
      updateIndexOfSpellingWords(_index);
      setState(() {
        _initIndex = _index + 1;
      });
      _getNextHelper();
    } else {
      _getNextHelper();
    }
  }

  _updataIndexAndWord(String enWord, String word) {
    print(_enWord);
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

  _updateHintPoints(int points) {
    addinghintPoints();
    addingAnswerPoints();
    setState(() {
      _hintPoints += points;
      _answerPoints += points;
    });
  }

  _fillForHelp() {
    if (_dataRowChar.isEmpty) {}
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
                onTap: () {
                  if (flag == 1) {
                    videoAd
                        .load(
                      adUnitId: RewardedVideoAd.testAdUnitId,
                    )
                        .then((value) {
                      if (value == true) {
                        RewardedVideoAd.instance.show();
                      }
                    });
                  } else if (flag == 1) {
                    if (_hintPoints > 0) {
                      _fillForHelp();
                    } else {}
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
      width: size.width * .85,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(
          res.borderRadiusSize * 0.5,
        ),
        border: Border.all(
          color: _inputError ? Colors.red : whiteColor,
          width: _inputError ? 1.0 : 0.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: res.leftPaddingSize * 2,
        ),
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
            fontSize: res.textSize,
            color: Colors.grey[600],
            height: size.height * .002,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            suffix: _inputError
                ? Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: GestureDetector(
                      onTap: () {
                        _showAnswer(2);
                      },
                      child: Text(
                        'Show me',
                        style: TextStyle(
                          color: primaryBlueColor,
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
          ),
        ),
      ),
    );
  }

  _removeButtonEventHandler() {
    List<dynamic> data = List<dynamic>.from(_dataRowChar);
    var char = data[data.length - 1];
    print(char);
    List<Map<String, dynamic>> newData =
        List<Map<String, dynamic>>.from(_listOfchar);

    for (int i = 0; i < newData.length; i++) {
      if (newData[i]['char'] == char) {
        newData[i]['selected'] = false;
        // here is a bug try to fix it ;
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
                    : shadow_1,
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

  _showAnwerHelper(int flag) {
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
            print(arr[i]);
            if (arr[i] == e['char']) {
              e['selected'] = true;
              break;
            }
          }
          return e;
        }).toList();
      });
    }
  }

  _showAnswer(int flag) {
    if (flag > 0) {
      _showAnwerHelper(flag);
    } else {
      _controller.text = _enWord;
      setState(() {
        _inputError = false;
      });
    }
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
                        _showAnswer(1);
                      },
                      child: TextWidget(
                        text: 'Show me',
                        size: res.textSize,
                        color: primaryBlueColor,
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
                              shadow_1,
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

  _nextSet() async {
    int index = await getNextSetIndex();
    if (index < 2251) {
      index += 50;
      updateIndexOfSpellingWords(index);
      setState(() {
        _index = index;
        _initIndex = index;
      });
      _getNextItem();
      setNextSetIndex(index);
    }
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
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              SizedBox(
                height: res.sizedBoxHeightSize,
              ),
              Expanded(
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
                                  child: !_useKeyBoard
                                      ? _keyBoard(size, res)
                                      : Container(),
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
              ),
              Expanded(
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
                          _hintAndWatchAdButton(
                              context, answerIcon, 3, size, res),
                          SizedBox(
                            width: size.width * 0.015,
                          ),
                          _hintAndWatchAdButton(
                              context, hintIcon, 2, size, res),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
