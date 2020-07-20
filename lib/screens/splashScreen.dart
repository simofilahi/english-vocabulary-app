import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:lenglish/models/data.dart';
import 'package:lenglish/screens/chooseLanguage.dart';
import 'package:lenglish/screens/home.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:localstorage/localstorage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _checkerBoolean = 0;
  String _lang;
  List<dynamic> _globalData;

  @override
  void initState() {
    super.initState();
    verfieFiles().then((v) {
      if (v == true) {
        getTheSelectedLang().then((onValue) {
          setState(() {
            _lang = onValue;
            _globalData = words;
            _checkerBoolean = 1;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext ctx) {
                if (_checkerBoolean == 1) {
                  return ChooseLanguage(
                    globalData: _globalData,
                  );
                } else {
                  return Home(
                    globalData: _globalData,
                    lang: _lang,
                  );
                }
              }),
            );
          },
          child: TextWidget(
            text: 'Click here',
            color: blackColor,
          ),
        ),
      ),
    );
  }
}
