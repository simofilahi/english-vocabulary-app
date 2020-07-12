import 'package:flutter/material.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/screens/settings.dart';
import 'package:lenglish/widgets/bottomBar.dart';
import 'package:lenglish/widgets/home.dart';

import 'ballonsGame.dart';
import 'buyPremium.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  List<Widget> _tabs = [
    HomeWidget(),
    BallonsGame(),
    BuyPremium(),
    Setting(),
  ];

  updateIndex(int index) {
    setState(
      () {
        currentIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      bottomNavigationBar: BottomBar(
        currentIndex: currentIndex,
        updateIndex: updateIndex,
      ),
      body: _tabs[currentIndex],
    );
  }
}
