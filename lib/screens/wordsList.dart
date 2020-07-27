import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:lenglish/logic/initalizeFiles.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/widgets/topAppBar.dart';
import '../constants.dart';
import 'flashCards.dart';

class WordsList extends StatefulWidget {
  final List data;
  final int objIndex;
  final List<dynamic> allData;
  final String lang;
  final Function globalDataUpdate;
  final Function getTotalLearningWords;

  WordsList(
    this.data,
    this.objIndex,
    this.allData,
    this.lang,
    this.globalDataUpdate,
    this.getTotalLearningWords,
  );

  @override
  _WordsListState createState() => _WordsListState();
}

class _WordsListState extends State<WordsList> {
  List<dynamic> _flashCardWords = [];
  List<dynamic> _familiarWords = [];
  List<dynamic> _unknowWords = [];
  int _flashCardsWordsCount = 0;
  int _familiarWordsCount = 0;
  int _unknowWordsCount = 0;

  @override
  void initState() {
    super.initState();
    _updateCountOfWords();
    // _updateFalshCarsWords();
    // _updateFamiliarWords();
    // _updateUnknownWords();
  }

  _updateCountOfWords() {
    setState(() {
      _flashCardsWordsCount = getWords(widget.data).length;
      _familiarWordsCount = getFamiliarWord(widget.data).length;
      _unknowWordsCount = getUnknownWord(widget.data).length;
    });
  }

  _updateFalshCarsWords() {
    setState(() {
      _flashCardWords = getWords(widget.data);
    });
  }

  _updateFamiliarWords() {
    setState(() {
      _familiarWords = getFamiliarWord(widget.data);
    });
  }

  _updateUnknownWords() {
    setState(() {
      _unknowWords = getUnknownWord(widget.data);
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

  Widget _cardItem(var size, String title, String subtitle, List<dynamic> item,
      int flag, int len) {
    print("leeen");
    print(len);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 5.0,
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext ctx) => FlashCards(
                item,
                widget.objIndex,
                widget.allData,
                widget.lang,
                _updateFalshCarsWords,
                _updateFamiliarWords,
                _updateUnknownWords,
                _updateCountOfWords,
                widget.globalDataUpdate,
                widget.getTotalLearningWords,
                flag,
                len,
              ),
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
            boxShadow: [
              shadow,
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextWidget(
                      text: title,
                      size: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    TextWidget(
                      text: subtitle,
                      color: Colors.grey[700],
                      size: 16.0,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: SvgPicture.asset(
                  rightArrowtIcon,
                  height: 25.0,
                  width: 25.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listItem(var size, List data, int index) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 4.0,
        bottom: 4.0,
        left: 5.0,
        right: 5.0,
      ),
      child: Container(
        height: 60.0,
        width: size.width * .90,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(
            15.0,
          ),
          boxShadow: [
            shadow,
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: TextWidget(
                      text: data[index]['en'],
                      size: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextWidget(
                    text: getRightTranslate(data, null, index, widget.lang),
                    size: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      playLocal(
                          'assets/audio/${widget.data[index]['audioPath']}');
                    },
                    child: SvgPicture.asset(
                      speakerIcon,
                      height: 25.0,
                      width: 25.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textDivder(var size) {
    return Container(
      height: 35,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: TextWidget(
              text: 'Words',
              size: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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
        child: SafeArea(
          child: Column(
            children: <Widget>[
              TopAppBar(
                icon_1: backArrowIcon,
                icon_2: null,
                text: 'Words',
                textSize: 18.0,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: ListView(
                    children: <Widget>[
                      _cardItem(
                        size,
                        'Flash card',
                        _flashCardWords == [] || _flashCardWords == null
                            ? '0 words'
                            : '${_flashCardsWordsCount} words',
                        widget.data,
                        0,
                        _flashCardsWordsCount,
                      ),
                      _cardItem(
                        size,
                        'Familiar words',
                        _familiarWords == [] || _familiarWords == null
                            ? '0 words'
                            : '${_familiarWordsCount} words',
                        widget.data,
                        1,
                        _familiarWordsCount,
                      ),
                      _cardItem(
                        size,
                        'Unknown words',
                        _unknowWords == [] || _unknowWords == null
                            ? '0 words'
                            : '${_unknowWordsCount} words',
                        widget.data,
                        2,
                        _unknowWordsCount,
                      ),
                      _textDivder(size),
                      ...widget.data
                          .asMap()
                          .map(
                            (index, element) => MapEntry(
                              index,
                              _listItem(size, widget.data, index),
                            ),
                          )
                          .values
                          .toList(),
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
