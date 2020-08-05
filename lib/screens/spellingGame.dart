import 'package:flutter/material.dart';
import 'package:lenglish/widgets/topAppBar.dart';
import 'package:random_string/random_string.dart';
import 'package:responsive_grid/responsive_grid.dart';
import '../constants.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'dart:math';

class SpellingGame extends StatefulWidget {
  final List<dynamic> globalData;
  final String lang;
  final int index;
  final Function getIndex;
  final int hintPoints;
  final Function getHintPoints;

  SpellingGame({
    this.globalData,
    this.lang,
    this.index,
    this.getIndex,
    this.hintPoints,
    this.getHintPoints,
  });
  @override
  _SpellingGameState createState() => _SpellingGameState();
}

class _SpellingGameState extends State<SpellingGame> {
  final TextEditingController _controller = TextEditingController(text: '');
  List<Map<String, dynamic>> _listOfchar = [];
  final _random = new Random();
  bool _boolean = false;
  String _word = "";
  String _en_word = "";
  int _set = 1;
  int _index = 0;
  int _initIndex = 0;
  bool spinner = false;
  bool _useKeyBoard = false;
  List<dynamic> _dataRowChar = [];
  final double borderRadius = 10.0;
  bool _inputError = false;
  int _hintPoints = 0;
  FocusNode _focusNode = FocusNode();

  /// just  define _formkey with static final

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      spinner = true;
      _index = widget.index;
      _initIndex = widget.index;
      _hintPoints = widget.hintPoints;
    });
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
    widget.getIndex();
    widget.getHintPoints();
  }

  dynamic _getSetItem() {
    for (int i = 0; i < widget.globalData.length; i++) {
      return widget.globalData[i]['set_${_set}'];
    }
  }

  void _getRandomWords() {
    String element = '';
    List<Map<String, dynamic>> arr = [];

    element = randomAlpha(5);

    element.runes.forEach((int rune) {
      var character = new String.fromCharCode(rune);
      var obj = {'char': character, 'selected': false};
      arr.add(obj);
    });
    _en_word.runes.forEach((int rune) {
      var character = new String.fromCharCode(rune);
      var obj = {'char': character, 'selected': false};
      arr.add(obj);
    });
    // print("here arr ===> ");
    // print(arr);
    print("here is en_word");
    print(_en_word);
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
    print(_en_word);
    setState(() {
      _index = _index + 1;
      _en_word = enWord;
      _word = word;
    });
  }

  List<String> _pushToListOfChar(var char) {
    List<dynamic> data = List<dynamic>.from(_dataRowChar);
    print("here is the data");
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

  _updateHintPoints() {
    addinghintPoints();
    setState(() {
      _hintPoints += 3;
    });
  }

  _fillForHelp() {
    if (_dataRowChar.isEmpty) {}
  }

  bool _verfieAnswer(int flag) {
    if (flag == 1) {
      if (_dataRowChar.isEmpty) return false;
      for (int i = 0; i < _dataRowChar.length; i++) {
        if (_dataRowChar[i] != _en_word[i]) {
          return false;
        }
      }
      setState(() {
        _dataRowChar = [];
      });
      return true;
    } else if (flag == 2) {
      if (_controller.text == _en_word)
        return true;
      else
        return false;
    }
  }

  Widget _hintAndWatchAdButton(BuildContext context, String icon, int flag) {
    var s = MediaQuery.of(context).size;
    return Container(
        height: 60.0,
        width: 60.0,
        child: Stack(
          children: <Widget>[
            Center(
              child: InkWell(
                onTap: () {
                  if (flag == 1) {
                    _updateHintPoints();
                  } else if (flag == 1) {
                    if (_hintPoints > 0) {
                      _fillForHelp();
                    } else {}
                  }
                },
                child: Container(
                  height: 55.0,
                  width: 55.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(
                      borderRadius,
                    ),
                    boxShadow: [
                      shadow(Theme.of(context).cardColor),
                    ],
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      icon,
                      height: 35.0,
                      width: 35.0,
                    ),
                  ),
                ),
              ),
            ),
            icon == hintIcon
                ? Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                          color: Color(0XFFffc107),
                          shape: BoxShape.circle,
                          boxShadow: [
                            shadow(Theme.of(context).cardColor),
                          ]),
                      child: Center(
                        child: FittedBox(
                          child: TextWidget(
                            text: _hintPoints.toString(),
                            color: whiteColor,
                            size: 10.0,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ));
  }

  Widget _inputBar() {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
        border: Border.all(
          color: _inputError ? Colors.red : whiteColor,
          width: _inputError ? 1.0 : 0.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: TextField(
          key: formKey,
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
            color: primaryGreyColor,
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

  Widget _enterAndRemove(var size) {
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
            height: size.height * .09,
            width: size.width * .15,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
              boxShadow: [
                shadow(Theme.of(context).cardColor),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(
                enterIcon,
                height: 20.0,
                width: 20.0,
                color: whiteColor,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        InkWell(
          onTap: () {
            _removeButtonEventHandler();
          },
          child: Container(
            height: size.height * .09,
            width: size.width * .15,
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
                height: 20.0,
                width: 20.0,
                color: whiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _listItem(int index) {
    return ResponsiveGridCol(
      xs: 3,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: InkWell(
          onTap: () {
            setState(() {
              _inputError = false;
            });
            _setTrueSelectedChar(index);
          },
          child: Container(
            height: 45,
            alignment: Alignment(0, 0),
            decoration: BoxDecoration(
              color: _listOfchar[index]['selected'] == true
                  ? primaryColor
                  : Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(
                borderRadius,
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
                  )
                : Container(),
          ),
        ),
      ),
    );
  }

  Widget _keyBoard(var size) {
    return ResponsiveGridRow(
      children: [
        ..._listOfchar
            .asMap()
            .map(
              (index, element) => MapEntry(
                index,
                _listItem(index),
              ),
            )
            .values
            .toList(),
      ],
    );
  }

  _showAnwerHelper(int flag) {
    if (flag == 2) {
      _controller.text = _en_word;
      setState(() {
        _inputError = false;
      });
    } else {
      List<dynamic> arr = [];
      _en_word.runes.forEach((int rune) {
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
      _controller.text = _en_word;
      setState(() {
        _inputError = false;
      });
    }
  }

  Widget _inputRow() {
    return Container(
      height: 50.0,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: _inputError ? Colors.red : whiteColor,
          width: _inputError ? 1.0 : 0.0,
        ),
        color: whiteColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
          ),
          child: _inputError
              ? Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        _showAnswer(1);
                      },
                      child: Text(
                        'Show me',
                        style: TextStyle(
                          color: primaryBlueColor,
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
                      padding: const EdgeInsets.only(
                        left: 5.0,
                        bottom: 5.0,
                        top: 5.0,
                      ),
                      child: Container(
                        width: 30.0,
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

  _nextSet() {
    int index = (_index - 50).abs() + _index;
    print("here index");
    print(index);
    updateIndexOfSpellingWords(index);
    setState(() {
      _index = index;
      _initIndex = index;
    });
    _getNextItem();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 4,
                child: Column(
                  children: <Widget>[
                    TextWidget(
                      text: _word,
                      size: 24.0,
                      color: Theme.of(context).textSelectionColor,
                    ),
                    SizedBox(
                      height: size.height * .04,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                        child: Column(
                          children: <Widget>[
                            _useKeyBoard == true ? _inputBar() : _inputRow(),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _useKeyBoard = !_useKeyBoard;
                                    });
                                  },
                                  child: Text(
                                    _useKeyBoard == true
                                        ? 'Use hand tap'
                                        : 'Use keyboard',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: primaryBlueColor,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                SvgPicture.asset(
                                  _useKeyBoard ? handTapIcon : keyBoardIcon,
                                  height: 23.0,
                                  width: 20.0,
                                  color: primaryBlueColor,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: !_useKeyBoard
                                      ? _keyBoard(size)
                                      : Container(),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: !_useKeyBoard
                                      ? _enterAndRemove(size)
                                      : Container(),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _hintAndWatchAdButton(context, watchIcon, 1),
                      _hintAndWatchAdButton(context, hintIcon, 2),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
