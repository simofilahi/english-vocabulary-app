import 'package:flutter/material.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:lenglish/models/data.dart';
import 'package:lenglish/screens/settings.dart';
import 'package:lenglish/widgets/bottomBar.dart';
import 'package:lenglish/widgets/home.dart';
import 'package:localstorage/localstorage.dart';

import 'ballonsGame.dart';
import 'myWords.dart';

class Home extends StatefulWidget {
  final List<dynamic> globalData;
  final String lang;
  Home({this.globalData, this.lang = null});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static LocalStorage storage = new LocalStorage('data');
  int currentIndex = 0;
  String _lang;

  @override
  void initState() {
    super.initState();
    if (widget.lang == null) {
      getTheSelectedLang().then((onValue) {
        setState(() {
          _lang = onValue;
        });
      });
    }
  }

  // List<Widget> _tabs = [

  //   // BuyPremium(),

  // ];

  updateIndex(int index) {
    setState(
      () {
        currentIndex = index;
      },
    );
  }

  dynamic _getScreen(currentIndex) {
    if (currentIndex == 0) {
      return HomeWidget(globalData: words, lang: _lang);
    } else if (currentIndex == 1) {
      return BallonsGame(globalData: words, lang: _lang);
    } else if (currentIndex == 2) {
      return MyWords(globalData: words, lang: _lang);
    } else if (currentIndex == 3) {
      return Setting();
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
