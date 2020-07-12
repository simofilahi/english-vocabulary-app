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

  Widget _item(var size, String iconName, String text) {
    return Container(
      height: 60.0,
      width: size.width * .90,
      decoration: BoxDecoration(
        color: primaryColor,
        border: Border(
          top: BorderSide(
            color: whiteColor,
          ),
        ),
      ),
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
                    _item(size, gearIcon, 'language'),
                    _item(size, gearIcon, 'language'),
                    _item(size, gearIcon, 'language'),
                    _item(size, gearIcon, 'language'),
                    _item(size, gearIcon, 'language'),
                    _item(size, gearIcon, 'language'),
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
