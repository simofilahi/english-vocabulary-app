import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/screens/splashScreen.dart';
import 'package:lenglish/screens/settings.dart';
import 'package:lenglish/logic/initalizeFiles.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _nightMode = false;
  bool _flag = false;
  String _lang = '';

  _updateNightMode() {
    print("yuuuuuuuuuup");
    langFile.getItem().then((lang) {
      print("item ======> lang");
      print(lang[0]['selected_lang']);
      setState(() {
        _lang = lang[0]['selected_lang'];
        _flag = true;
        _nightMode = !_nightMode;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        backgroundColor: !_nightMode ? primaryColor : blackColor,
        cardColor: !_nightMode ? whiteColor : blackGrey,
        textSelectionColor: !_nightMode ? blackColor : whiteColor,
        cursorColor: !_nightMode ? Colors.grey[700] : Colors.grey[200],
        indicatorColor: !_nightMode ? blackColor : whiteColor,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: _flag == false
          ? SplashScreen(
              updateNightMode: _updateNightMode,
              nightMode: _nightMode,
            )
          : Setting(
              lang: _lang,
              updateNightMode: _updateNightMode,
              nightMode: _nightMode,
            ),
    );
  }
}
