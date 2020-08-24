import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Steria/constants.dart';
import 'package:Steria/screens/chooseLanguage.dart';
import 'package:Steria/logic/BoolSetter.dart';
import 'package:Steria/widgets/textWidget.dart';
import 'package:Steria/widgets/topAppBar.dart';
import 'package:Steria/models/responsive.dart';
import 'package:share/share.dart';
import 'package:Steria/screens/splashScreen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class Setting extends StatefulWidget {
  final String lang;
  final Function updateNightMode;
  bool nightMode;
  Setting({this.lang, this.updateNightMode, this.nightMode});

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String lang = 'English';
  double totalAmount = 0;
  double amount = 0;
  String currencyName = "";
  String generatedToken = "";

  @override
  void initState() {
    super.initState();

    setState(() {
      lang = getNameOfLang(widget.lang);
    });
  }

  Widget _render(var size, String iconName, String text, String text_1,
      String iconName_2, var screen, int flag, int navFlag, Responsive res) {
    if (flag == 1) {
      return Expanded(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  text != null
                      ? TextWidget(
                          text: text_1,
                          size: size.width * 0.035,
                          color: Theme.of(context).textSelectionColor,
                        )
                      : Container(),
                  Padding(
                    padding: EdgeInsets.only(
                      right: res.rightPaddingSize,
                    ),
                    child: FittedBox(
                      child: SvgPicture.asset(
                        iconName_2,
                        height: size.height * 0.028,
                        width: size.height * 0.028,
                        color: Theme.of(context).textSelectionColor,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else if (flag == 2) {
      return Padding(
        padding: EdgeInsets.only(
          right: size.width * 0.025,
        ),
        child: InkWell(
          onTap: () {
            widget.updateNightMode();
          },
          child: SvgPicture.asset(
            iconName_2,
            height: size.height * 0.05,
            width: size.height * 0.05,
            color: Theme.of(context).backgroundColor == blackColor
                ? greenColor
                : primaryColor,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  _dialogResetAll(Responsive res) {
    AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: 'RESET',
      desc: 'Are you sure, wanna reset the app',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext ctx) {
            return SplashScreen(
              updateNightMode: widget.updateNightMode,
              nightMode: widget.nightMode,
              flag: 1,
            );
          }),
        );
      },
      res: res,
    )..show();
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {}
  }

  Widget _item(var size, String iconName, String text, String text_1,
      String iconName_2, var screen, int flag, int navFlag) {
    Responsive res = Responsive(
      containerHeightSize: size.height * .08,
      containerWidthSize: size.width * .90,
      sizedBoxHeightSize: size.height * 0.028,
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
      height: size.height,
      width: size.width,
    );
    print("bbbbbbbb ===> ${res.sizedBoxWidthSize}");
    return FittedBox(
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(
          res.borderRadiusSize,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(
            res.borderRadiusSize,
          ),
          highlightColor: rippleColor,
          onTap: () {
            if (navFlag == 3) {
              _dialogResetAll(res);
            } else if (navFlag == 4) {
              Share.share(
                  'Hey! check out this Awesome Learning English Vocabulary app https://play.google.com/store/apps/details?id=com.forudevapp.wallpapers');
            } else if (navFlag == 6) {
              _launchURL('https://steriapp.herokuapp.com/');
            } else if (navFlag == 5) {
              _launchURL(
                  'https://play.google.com/store/apps/details?id=com.forudevapp.steria');
            } else if (navFlag == 1) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext ctx) {
                  return screen;
                }),
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.only(
              top: res.topPaddingSize,
              bottom: res.bottomPaddingSize,
              left: res.leftPaddingSize,
              right: res.rightPaddingSize,
            ),
            child: Container(
              height: res.containerHeightSize,
              width: res.containerWidthSize,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(
                    res.borderRadiusSize,
                  ),
                  boxShadow: [
                    shadow(Theme.of(context).cardColor),
                  ]),
              child: Padding(
                padding: EdgeInsets.all(
                  res.allPaddingSize,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            iconName,
                            height: res.iconSize,
                            width: res.iconSize,
                          ),
                          SizedBox(
                            width: res.sizedBoxWidthSize,
                          ),
                          TextWidget(
                            text: text,
                            size: res.textSize,
                            color: Theme.of(context).textSelectionColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                    _render(size, iconName, text, text_1, iconName_2, screen,
                        flag, navFlag, res),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _settingItems(var size) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        _item(
          size,
          languagesIcon,
          'Language',
          lang,
          rightArrowtIcon,
          ChooseLanguage(
            globalDataUpdate: null,
            settingBool: true,
            updateNightMode: widget.updateNightMode,
            nightMode: widget.nightMode,
          ),
          1,
          1,
        ),
        _item(
          size,
          sleepModesIcon,
          'Dark Mode',
          null,
          Theme.of(context).backgroundColor == blackColor
              ? rightSwitch
              : leftSwitch,
          null,
          2,
          2,
        ),
        _item(size, restoreIcon, 'Reset', null, null, null, 0, 3),
        _item(size, shareIcon, 'Share With Friends', null, null, null, 0, 4),
        _item(size, starIcon, 'Rate Us', null, null, null, 0, 5),
        _item(size, privacyIcon, 'Privacy Policy', null, null, null, 0, 6),
        _item(size, aboutIcon, 'v1.1', null, null, null, 0, 7),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Responsive res = Responsive(
      sizedBoxHeightSize: size.height * 0.028,
      horizontalPaddingSize: size.width * 0.06,
      verticalPaddingSize: size.height * 0.0055,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        height: size.height,
        width: size.width,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              TopAppBar(
                icon_1: null,
                icon_2: null,
                text: 'Settings',
              ),
              SizedBox(
                height: res.sizedBoxHeightSize,
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: res.horizontalPaddingSize,
                  ),
                  child: _settingItems(size),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
