import 'package:flutter/material.dart';
import 'package:lenglish/widgets/topAppBar.dart';
import 'package:responsive_grid/responsive_grid.dart';
import '../constants.dart';
import 'package:lenglish/widgets/textWidget.dart';

class SpellingGame extends StatefulWidget {
  SpellingGame({Key key}) : super(key: key);

  @override
  _SpellingGameState createState() => _SpellingGameState();
}

class _SpellingGameState extends State<SpellingGame> {
  String _text = '';
  String _randomWordsString = '';
  List<String> _listOfchar = [
    'a',
    'a',
    'a',
    'a',
    'a',
    'a',
    'a',
    'a',
    'a',
    'a',
    'a',
    'a',
    'a',
    'a',
    'a',
    'a',
    'a',
    'a',
    'a',
    'a',
    'a',
    'a',
    'a',
    'a',
    'a'
  ];

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   _listOfchar:
    //   _pushToListOfChar();
    // });
  }

  List<String> _pushToListOfChar() {
    return [
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a',
      'a'
    ];
  }

  Widget _inputBar() {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(
          15.0,
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter a search term',
        ),
      ),
    );
  }

  Widget _enterAndRemove(var size) {
    return Column(
      children: <Widget>[
        Container(
          height: size.height * .09,
          width: size.width * .15,
          decoration: BoxDecoration(
            color: primaryBlueColor,
            borderRadius: BorderRadius.circular(
              10.0,
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          height: size.height * .09,
          width: size.width * .15,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(
              10.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _keyBoard(var size) {
    print("hello");
    print(_listOfchar);
    return ResponsiveGridRow(children: [
      ..._listOfchar.map((e) {
        return ResponsiveGridCol(
          xs: 2,
          md: 5,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              height: 30,
              alignment: Alignment(0, 0),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(
                  5.0,
                ),
              ),
              child: TextWidget(
                text: e[0],
                color: primaryGreyColor,
              ),
            ),
          ),
        );
      }).toList()
    ]);
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
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Column(
              children: <Widget>[
                TopAppBar(
                  icon_1: backArrowIcon,
                  icon_2: backArrowIcon,
                  text: 'Games',
                  textSize: 18,
                ),
                SizedBox(
                  height: size.height * .20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: <Widget>[
                        _inputBar(),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
