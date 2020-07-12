import 'package:flutter/material.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/screens/chooseLanguage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: primaryColor,
      ),
      home: ChooseLanguage(),
    );
  }
}
