import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/screens/chooseLanguage.dart';
import 'package:lenglish/widgets/shopCard.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/widgets/topAppBar.dart';

class Setting extends StatefulWidget {
  final String lang;
  final Function updateNightMode;
  final bool nightMode;
  Setting({this.lang, this.updateNightMode, this.nightMode});

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String lang = 'English';

  @override
  void initState() {
    super.initState();
    if (widget.lang == 'ar') {
      setState(() {
        lang = 'Arabic';
      });
    } else if (widget.lang == 'fr') {
      setState(() {
        lang = 'French';
      });
    } else if (widget.lang == 'sp') {
      setState(() {
        lang = 'Spanich';
      });
    } else if (widget.lang == 'ch') {
      setState(() {
        lang = 'Chinese';
      });
    }
  }

  Widget _render(var size, String iconName, String text, String text_1,
      String iconName_2, var screen, int flag) {
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
                  text != null ? TextWidget(text: text_1) : Container(),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SvgPicture.asset(
                      iconName_2,
                      height: 15.0,
                      width: 15.0,
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
        padding: const EdgeInsets.only(right: 15.0),
        child: SvgPicture.asset(
          iconName_2,
          height: 40.0,
          width: 50.0,
          color: widget.nightMode == true ? greenColor : primaryColor,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _item(var size, String iconName, String text, String text_1,
      String iconName_2, var screen, int flag) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 4.0,
        bottom: 4.0,
        left: 2.0,
        right: 2.0,
      ),
      child: Container(
        height: 60.0,
        width: size.width * .92,
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(
              15.0,
            ),
            boxShadow: [
              shadow,
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            color: Colors.transparent,
            shadowColor: blackColor,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext ctx) {
                    return screen;
                  }),
                );
              },
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          iconName,
                          height: 20.0,
                          width: 20.0,
                          // color: primaryGreyColor,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        TextWidget(
                          text: text,
                          size: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                  _render(
                      size, iconName, text, text_1, iconName_2, screen, flag),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: primaryColor,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            TopAppBar(
              icon_1: null,
              icon_2: null,
              text: 'Settings',
              textSize: 18,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 15.0,
                ),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    ShopCard(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _item(
                      size,
                      languagesIcon,
                      'Language',
                      lang,
                      rightArrowtIcon,
                      ChooseLanguage(
                        globalDataUpdate: null,
                        settingBool: true,
                      ),
                      1,
                    ),
                    _item(
                      size,
                      sleepModesIcon,
                      'Mode nuit',
                      null,
                      widget.nightMode == false ? leftSwitch : rightSwitch,
                      null,
                      2,
                    ),
                    _item(size, restoreIcon, 'Restore', null, null, null, 0),
                    _item(size, shareIcon, 'Share app', null, null, null, 0),
                    _item(size, starIcon, 'Rate app', null, null, null, 0),
                    _item(size, privacyIcon, 'Privacy', null, null, null, 0),
                    _item(size, aboutIcon, 'About', null, null, null, 0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
