import 'package:flutter/material.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:lenglish/logic/initalizeFiles.dart';
import 'package:lenglish/screens/settings.dart';
import 'package:lenglish/widgets/bottomBar.dart';
import 'package:lenglish/widgets/home.dart';
import 'ballonsGame.dart';
import 'myWords.dart';

class Home extends StatefulWidget {
  final List<dynamic> globalData;
  final String lang;
  final Function globalDataUpdate;
  Home({
    this.globalData,
    this.lang = null,
    this.globalDataUpdate,
  });
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  String _lang;
  int _totalLearningWords = 0;

  @override
  void initState() {
    super.initState();
    _getTotalLearningWords();
    if (widget.lang == null) {
      langFile.getItem().then((data) {
        print(data);
        if (data == null) {
          setState(() {
            _lang = "en";
          });
        } else {
          setState(() {
            _lang = data[0]['selected_lang'];
          });
        }
      });
    } else {
      setState(() {
        _lang = widget.lang;
      });
    }
  }

  _getTotalLearningWords() {
    setState(() {
      _totalLearningWords = totoalLearningWords(widget.globalData);
    });
  }

  updateIndex(int index) {
    setState(
      () {
        currentIndex = index;
      },
    );
  }

  dynamic _getScreen(currentIndex) {
    if (currentIndex == 0) {
      return HomeWidget(
          globalData: widget.globalData,
          lang: _lang,
          globalDataUpdate: widget.globalDataUpdate,
          totalLearningWords: _totalLearningWords,
          getTotalLearningWords: _getTotalLearningWords);
    } else if (currentIndex == 1) {
      return BallonsGame(
          globalData: widget.globalData,
          lang: _lang,
          globalDataUpdate: widget.globalDataUpdate);
    } else if (currentIndex == 2) {
      return MyWords(
        globalData: widget.globalData,
        lang: _lang,
        globalDataUpdate: widget.globalDataUpdate,
      );
    } else if (currentIndex == 3) {
      return Setting(
        lang: _lang,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      bottomNavigationBar: BottomBar(
        currentIndex: currentIndex,
        updateIndex: updateIndex,
      ),
      body: _getScreen(currentIndex),
    );
  }
}
