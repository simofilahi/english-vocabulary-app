import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Steria/constants.dart';
import 'package:Steria/logic/BoolSetter.dart';
import 'package:Steria/logic/initalizeFiles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'chooseLanguage.dart';
import 'package:Steria/widgets/textWidget.dart';
import 'package:Steria/models/responsive.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  final Function updateNightMode;
  final bool nightMode;
  final int flag;

  SplashScreen({
    this.updateNightMode,
    this.nightMode,
    this.flag,
  });
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  int _checkerBoolean = 0;
  String _lang;
  List<dynamic> _globalData;

  @override
  void initState() {
    super.initState();

    if (widget.flag == 1) {
      _restoreApp();
    } else
      _uploadData();
  }

  _restoreApp() {
    creationOfFiles().then((value) {
      if (value) {
        Future.delayed(const Duration(seconds: 2), () {
          _callScreen();
        });
      }
    });
  }

  _uploadData() {
    langFile.isExist().then((ret) {
      if (ret == false) {
        creationOfFiles().then((value) {
          if (value) {
            Future.delayed(const Duration(seconds: 2), () {
              _callScreen();
            });
          }
        });
      } else {
        allData.getItem().then((data) {
          langFile.getItem().then((lang) {
            Future.delayed(const Duration(seconds: 2), () {
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

  _globalDataUpdate() async {
    if (this.mounted) {
      dynamic data = await getGlobalData();
      if (data != null) {
        setState(() {
          _globalData = data;
        });
      }
    }
  }

  Widget _body(var size, Responsive res) {
    return Container(
      child: Image.asset(
        'assets/images/splashScreenIcon.png',
        height: size.height * 0.02,
        width: size.height * 0.02,
      ),
    );
  }

  Widget _bottom(var size, Responsive res) {
    return TextWidget(
      text: 'Steria',
      size: size.width * 0.10,
      color: primaryBlueColor,
      letterSpacing: 1,
    );
  }

  Widget _spinner(BuildContext context) {
    return SpinKitDoubleBounce(
      color: primaryBlueColor,
      size: MediaQuery.of(context).size.height * 0.1,
      controller: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1200),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Responsive res = Responsive(
      containerHeightSize: size.height * .08,
      containerWidthSize: size.width * .90,
      sizedBoxHeightSize: size.height * 0.02,
      sizedBoxWidthSize: size.width * 0.0310,
      horizontalPaddingSize: size.width * 0.06,
      verticalPaddingSize: size.height * 0.0055,
      borderRadiusSize: size.width * 0.0469,
      bottomPaddingSize: size.height * 0.0055,
      topPaddingSize: size.height * 0.0055,
      rightPaddingSize: size.width * 0.0085,
      leftPaddingSize: size.width * 0.0085,
      textSize: size.width * 0.05,
      iconSize: size.height * 0.032,
      allPaddingSize: size.width * 0.02,
      buttonHeightSize: size.height * 0.06,
      buttonWidthSize: size.width * 0.4,
    );
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: size.height * 0.40,
              width: size.width,
            ),
            Container(
              height: size.height * 0.20,
              width: size.width,
              // color: Colors.red,
              child: _body(size, res),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              height: size.height * 0.05,
              width: size.width,
              child: _spinner(context),
            ),
            Container(
              height: size.height * 0.34,
              width: size.width,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: res.topPaddingSize * 4,
                      ),
                      child: Center(
                        child: _bottom(size, res),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
