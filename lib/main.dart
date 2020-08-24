import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Steria/constants.dart';
import 'package:Steria/screens/splashScreen.dart';
import 'package:Steria/screens/settings.dart';
import 'package:Steria/logic/initalizeFiles.dart';
import 'package:Steria/logic/BoolSetter.dart';

void main() => runApp(
      MyApp(),
    );

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _nightMode = false;
  bool _flag = false;
  String _lang = '';

  @override
  void initState() {
    super.initState();
    _darkModeStatus();
  }

  _darkModeStatus() async {
    bool check = await darkMode.isExist();
    if (check) {
      bool ret = await getDarkModeStatus();
      if (ret == false) {
        setState(() {
          _nightMode = false;
        });
      } else {
        setState(() {
          _nightMode = true;
        });
      }
    }
  }

  _updateNightMode() async {
    await setDarkModeStatus(!_nightMode);
    langFile.getItem().then((lang) {
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: !_nightMode ? primaryBlueColor : blackColor,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Steria',
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
              flag: 0,
            )
          : Setting(
              lang: _lang,
              updateNightMode: _updateNightMode,
              nightMode: _nightMode,
            ),
    );
  }
}
