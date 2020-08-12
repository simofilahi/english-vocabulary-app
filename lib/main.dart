import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/screens/splashScreen.dart';
import 'package:lenglish/screens/settings.dart';
import 'package:lenglish/logic/initalizeFiles.dart';
import 'package:stripe_native/stripe_native.dart';

void main() => runApp(
      // MyApp(),
      DevicePreview(
        enabled: true,
        builder: (context) => MyApp(),
      ),
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

  _updateNightMode() {
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
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    return MaterialApp(
      locale: DevicePreview.of(context).locale, // <--- Add the locale
      builder: DevicePreview.appBuilder,
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
