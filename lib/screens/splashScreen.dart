import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:lenglish/logic/initalizeFiles.dart';

import 'package:lenglish/widgets/textWidget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'chooseLanguage.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  final Function updateNightMode;
  final bool nightMode;

  SplashScreen({
    this.updateNightMode,
    this.nightMode,
  });
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  int _checkerBoolean = 0;
  String _lang;
  List<dynamic> _globalData;
  var spinkit;

  @override
  void initState() {
    super.initState();
    spinkit = SpinKitDoubleBounce(
      color: primaryBlueColor,
      size: 50.0,
      controller: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 1200)),
    );
    print("before is exist");
    langFile.isExist().then((ret) {
      print('inside is exist');
      print("ret ");
      print(ret);
      creationOfFiles().then((value) {
        if (value) {
          Future.delayed(const Duration(seconds: 4), () {
            _callScreen();
          });
        }
      });
      if (ret == false) {
      } else {
        print("else condition");
        allData.getItem().then((data) {
          langFile.getItem().then((lang) {
            Future.delayed(const Duration(seconds: 4), () {
              setState(() {
                _lang = lang[0]['selected_lang'];
                _globalData = data;
                _checkerBoolean = 1;
              });
              _callScreen();
            });
          });
        });
      }
    });
  }

  _callScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext ctx) {
          if (_checkerBoolean == 0) {
            return ChooseLanguage(
              globalDataUpdate: _globalDataUpdate,
              settingBool: false,
              updateNightMode: widget.updateNightMode,
              nightMode: widget.nightMode,
            );
          } else {
            return Home(
              globalData: _globalData,
              lang: _lang,
              globalDataUpdate: _globalDataUpdate,
              updateNightMode: widget.updateNightMode,
              nightMode: widget.nightMode,
            );
          }
        },
      ),
    );
  }

  Future<bool> _globalDataUpdate() async {
    if (this.mounted) {
      getGlobalData().then((onValue) {
        setState(() {
          _globalData = onValue;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext ctx) {
                  if (_checkerBoolean == 0) {
                    return ChooseLanguage(
                      globalDataUpdate: _globalDataUpdate,
                      settingBool: false,
                      updateNightMode: widget.updateNightMode,
                      nightMode: widget.nightMode,
                    );
                  } else {
                    return Home(
                      globalData: _globalData,
                      lang: _lang,
                      globalDataUpdate: _globalDataUpdate,
                      updateNightMode: widget.updateNightMode,
                      nightMode: widget.nightMode,
                    );
                  }
                },
              ),
            );
          },
          child: spinkit,
        ),
      ),
    );
  }
}
