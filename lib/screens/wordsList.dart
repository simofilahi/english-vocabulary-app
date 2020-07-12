import 'package:flutter/material.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/widgets/topAppBar.dart';
import '../constants.dart';
import 'flashCards.dart';

class WordsList extends StatefulWidget {
  WordsList({Key key}) : super(key: key);

  @override
  _WordsListState createState() => _WordsListState();
}

class _WordsListState extends State<WordsList> {
  Widget _cardItem(var size) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext ctx) => FlashCards(),
            ),
          );
        },
        child: Container(
          height: 80.0,
          width: size.width * 90.0,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(
              15.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _listItem(var size, String word, String translate) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: 60.0,
        width: size.width * .90,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(
            15.0,
          ),
          // border: Border(
          //   top: BorderSide(
          //     color: primaryColor,
          //   ),
          // ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextWidget(
                text: word,
                size: 18.0,
                fontWeight: FontWeight.w400,
              ),
              TextWidget(
                text: translate,
                size: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textDivder(var size) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Container(
        height: 35,
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextWidget(
                text: 'Words',
                size: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Column(
              children: <Widget>[
                TopAppBar(
                  icon_1: backArrowIcon,
                  icon_2: null,
                  text: 'Words',
                  textSize: 18.0,
                ),
                _cardItem(size),
                _textDivder(size),
                _listItem(size, 'hello', 'hello'),
                _listItem(size, 'hello', 'hello'),
                _listItem(size, 'hello', 'hello'),
                _listItem(size, 'hello', 'hello'),
                _listItem(size, 'hello', 'hello'),
                _listItem(size, 'hello', 'hello'),
                _listItem(size, 'hello', 'hello'),
                _listItem(size, 'hello', 'hello'),
                _listItem(size, 'hello', 'hello'),
                _listItem(size, 'hello', 'hello'),
                _listItem(size, 'hello', 'hello'),
                _listItem(size, 'hello', 'hello'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
