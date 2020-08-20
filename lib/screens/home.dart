import 'package:flutter/material.dart';
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
  final Function updateNightMode;
  final bool nightMode;
  Home({
    this.globalData,
    this.lang = "",
    this.globalDataUpdate,
    this.updateNightMode,
    this.nightMode,
  });
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  String _lang = "";
  int _totalLearningWords = 0;
  List<dynamic> _globalData = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _globalData = widget.globalData;
    });
    _getTotalLearningWords();
    _updateLangData();
  }

  setNewGlobalData() async {
    if (mounted == true) {
      dynamic data = await getGlobalData();
      if (data != null) {
        setState(() {
          _globalData = data;
        });
      }
    }
  }

  _updateLangData() async {
    if (widget.lang == "") {
      dynamic data = await langFile.getItem();
      if (data == null) {
        setState(() {
          _lang = "en";
        });
      } else {
        setState(() {
          _lang = data[0]['selected_lang'];
        });
      }
    } else {
      setState(() {
        _lang = widget.lang;
      });
    }
  }

  _getTotalLearningWords() {
    int number = totoalLearningWords(_globalData);

    setState(() {
      _totalLearningWords = number;
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
        globalData: _globalData,
        lang: _lang,
        globalDataUpdate: widget.globalDataUpdate,
        totalLearningWords: _totalLearningWords,
        getTotalLearningWords: _getTotalLearningWords,
        setNewGlobalData: setNewGlobalData,
      );
    } else if (currentIndex == 1) {
      return BallonsGame(
        globalData: _globalData,
        lang: _lang,
        globalDataUpdate: widget.globalDataUpdate,
      );
    } else if (currentIndex == 2) {
      return MyWords(
        globalData: _globalData,
        lang: _lang,
        globalDataUpdate: widget.globalDataUpdate,
      );
    } else if (currentIndex == 3) {
      return Setting(
        lang: _lang,
        updateNightMode: widget.updateNightMode,
        nightMode: widget.nightMode,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: BottomBar(
        currentIndex: currentIndex,
        updateIndex: updateIndex,
      ),
      body: _getScreen(currentIndex),
    );
  }
}
