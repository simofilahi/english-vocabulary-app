import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/widgets/customButton.dart';
import 'package:lenglish/widgets/shopCard.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/widgets/topAppBar.dart';

class Setting extends StatefulWidget {
  Setting({Key key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final List _list = [
    'Hello',
    '2',
    '2',
    '2',
  ];

  Widget _item(
      var size, String iconName, String text, String iconName_2, bool flag) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: 60.0,
        width: size.width * .90,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(
            15.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      iconName,
                      height: 20.0,
                      width: 20.0,
                      color: primaryGreyColor,
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
              flag
                  ? Expanded(
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
                                TextWidget(text: 'spanich'),
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
                    )
                  : Container(),
            ],
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
                      height: 35.0,
                    ),
                    _item(
                      size,
                      gearIcon,
                      'Language',
                      rightArrowtIcon,
                      true,
                    ),
                    _item(
                      size,
                      sleepModesIcon,
                      'Mode nuit',
                      rightArrowtIcon,
                      true,
                    ),
                    _item(size, restoreIcon, 'Restore', null, false),
                    _item(size, shareIcon, 'Share app', null, false),
                    _item(size, gearIcon, 'language', null, false),
                    _item(size, gearIcon, 'language', null, false),
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
