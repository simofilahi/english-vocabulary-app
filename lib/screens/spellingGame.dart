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

  SpellingGame({this.globalData, this.lang, this.index, this.getIndex});
  @override
  _SpellingGameState createState() => _SpellingGameState();
}

class _SpellingGameState extends State<SpellingGame> {
  String _text = '';
  String _randomWordsString = '';
  final TextEditingController _controller = TextEditingController(text: '');
  List<Map<String, dynamic>> _listOfchar = [];
  final _random = new Random();
  bool _boolean = false;
  String _word;
  String _en_word;
  String _randomWord = '';
  int _set = 1;
  int _index = 0;
  int _initIndex = 0;
  bool spinner = false;
  bool _useKeyBoard = false;
  List<dynamic> _dataRowChar = [];
  final double borderRadius = 10.0;
  bool _inputError = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      spinner = true;
      _index = widget.index;
      _initIndex = widget.index;
    });
    _getNextItem();
    print("here init index");
    print(widget.index);
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   widget.getIndex();
  // }

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
    print("here arr ===> ");
    print(arr);
    arr.shuffle();
    setState(() {
      _listOfchar = arr;
    });
  }

  void _getNextItem() {
    int i = 1;
    int j = 0;
    String word;
    String en_word;

    if (_index == _initIndex + 5) {
      updateIndexOfSpellingWords(_index);
      setState(() {
        _initIndex = _index + 1;
      });
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

  Widget _hintAndWatchAdButton(BuildContext context, String icon) {
    var s = MediaQuery.of(context).size;
    return Container(
      height: 60.0,
      width: 60.0,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
        boxShadow: [
          shadow,
        ],
      ),
      child: Center(
        child: SvgPicture.asset(
          icon,
          height: 35.0,
          width: 35.0,
        ),
      ),
    );
  }

  Widget _inputBar() {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: TextField(
          controller: _controller,
          style: TextStyle(
            color: primaryGreyColor,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter a search term',
          ),
        ),
      ),
    );
  }

  bool _verfieAnswer() {
    print("before");
    if (_dataRowChar.isEmpty) return false;
    for (int i = 0; i < _dataRowChar.length; i++) {
      print(_dataRowChar[i]);
      print(_en_word[i]);
      if (_dataRowChar[i] != _en_word[i]) {
        return false;
      }
    }
    setState(() {
      _dataRowChar = [];
    });
    return true;
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
            if (_verfieAnswer()) {
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
                shadow,
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
                shadow,
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
                  : whiteColor,
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
              boxShadow: [
                _listOfchar[index]['selected'] == true ? shadow : shadow_1,
              ],
            ),
            child: _listOfchar[index]['selected'] == false
                ? TextWidget(
                    text: _listOfchar[index]['char'],
                    color: primaryGreyColor,
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
          child: ListView.builder(
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
                      color: primaryColor,
                      boxShadow: [
                        shadow_1,
                      ],
                      borderRadius: BorderRadius.circular(
                        borderRadius,
                      )),
                  child: Center(
                    child: TextWidget(
                      text: _dataRowChar[index],
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        height: size.height,
        width: size.width,
        color: primaryColor,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              TopAppBar(
                icon_1: backArrowIcon,
                icon_2: forwardIcon,
                text: '${_index}/2265',
                textSize: 18,
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: size.height * .16,
                  ),
                  TextWidget(
                    text: _word,
                    size: 24.0,
                    color: primaryGreyColor,
                  ),
                  SizedBox(
                    height: size.height * .04,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    child: Expanded(
                      flex: 4,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
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
                                    _useKeyBoard = !_useKeyBoard;
                                  },
                                  child: Text(
                                    'Use keyboard',
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
                                  keyBoardIcon,
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
                                  child: _keyBoard(size),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: _enterAndRemove(size),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    child: Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _hintAndWatchAdButton(context, watchIcon),
                          _hintAndWatchAdButton(context, hintIcon),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
