import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:lenglish/logic/initalizeFiles.dart';
import 'package:lenglish/models/data.dart';
import 'package:lenglish/widgets/textWidget.dart';

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

class _SplashScreenState extends State<SplashScreen> {
  int _checkerBoolean = 0;
  String _lang;
  List<dynamic> _globalData;

  @override
  void initState() {
    super.initState();
    print("before is exist");
    langFile.isExist().then((ret) {
      print('inside is exist');
      print("ret ");
      print(ret);
      if (ret == false) {
        langFile.createFile().then((value) {
          print("first value is false");
          if (value == true) {
            print("inside first false");
            allData.createFile().then((v) {
              if (v == true) {
                print("set global data");
                allData.setItem('data', words);
              }
            });
            indexFile.createFile().then((v) {
              if (v == true) {
                print("set global index");
                indexFile.setItem('index', [
                  {"index": "0"}
                ]);
              }
            });
            indexFile_2.createFile().then((v) {
              if (v == true) {
                print("set global indexData 2");
                indexFile_2.setItem('index', [
                  {"index": "0"}
                ]);
              }
            });
            hintPointsFile.createFile().then((v) {
              if (v == true) {
                print("set global points ******************************* ");
                hintPointsFile.setItem('points', [
                  {"points": "3"}
                ]);
              }
            });
            langFile.createFile().then((v) {
              if (v == true) {
                print("set lang data");
                langFile.setItem('Lang', [
                  {"selected_lang": "en"}
                ]);
              }
            });
            indexFile.createFile().then((v) {
              if (v == true) {
                print("set indexFile data");
                indexFile.setItem('Index', [
                  {"index": "0"}
                ]);
              }
            });
            favFile.createFile();
          }
        });
      } else {
        print("else condition");
        allData.getItem().then((data) {
          print("before get iTEM");
          langFile.getItem().then((lang) {
            print("item ======> lang");
            print(lang[0]['selected_lang']);
            setState(() {
              _lang = lang[0]['selected_lang'];
              _globalData = data;
              _checkerBoolean = 1;
            });
          });
        });
      }
    });
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
      backgroundColor: Color(0xfff78C800),
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
          child: TextWidget(
            text: 'Click here',
            color: blackColor,
          ),
        ),
      ),
    );
  }
}
