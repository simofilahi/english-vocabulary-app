import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/screens/splashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _nightMode = false;

  _updateNightMode() {
    setState(() {
      _nightMode = !_nightMode;
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
        scaffoldBackgroundColor: Colors.black,
        primaryColor: primaryColor,
      ),
      home: SplashScreen(
        updateNightMode: _updateNightMode(),
        nightMode: _nightMode,
      ),
    );
  }
}
