import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/logic/initalizeFiles.dart';
import 'package:lenglish/models/languages.dart';
import 'package:lenglish/screens/home.dart';
import 'package:lenglish/widgets/customButton.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/models/responsive.dart';
import 'package:responsive_grid/responsive_grid.dart';

class ChooseLanguage extends StatefulWidget {
  final Function globalDataUpdate;
  final bool settingBool;
  final Function updateNightMode;
  final bool nightMode;

  ChooseLanguage({
    this.globalDataUpdate,
    this.settingBool,
    this.updateNightMode,
    this.nightMode,
  });
  @override
  _ChooseLanguageState createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  List<dynamic> _globalData = [];

  @override
  void initState() {
    super.initState();

    allData.getItem().then((data) {
      setState(() {
        _globalData = data;
      });
    });
  }

  void _changeIsActive(LanguagesList item) {
    setState(() {
      languagesList.forEach((f) {
        if (f == item) {
          f.isActive = true;
        } else {
          f.isActive = false;
        }
      });
    });
  }

  String _getActiveLang() {
    String ret;
    languagesList.forEach((f) {
      if (f.isActive == true) {
        ret = f.name;
      }
    });
    return ret;
  }

  Widget _item(LanguagesList item, Responsive res, var size) {
    return ResponsiveGridCol(
      xs: 6,
      sm: 6,
      md: 6,
      lg: 4,
      xl: 4,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _changeIsActive(item);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: res.horizontalPaddingSize * 0.2,
              vertical: res.horizontalPaddingSize * 0.2,
            ),
            child: Container(
              height: size.height * 0.2,
              decoration: BoxDecoration(
                color: item.isActive
                    ? primaryBlueColor
                    : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(
                  res.borderRadiusSize,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FittedBox(
                    child: SvgPicture.asset(
                      item.icon,
                      height: res.iconSize * 2.5,
                      width: res.iconSize * 2.5,
                    ),
                  ),
                  SizedBox(
                    height: res.sizedBoxHeightSize,
                  ),
                  FittedBox(
                    child: TextWidget(
                      text: item.name,
                      size: res.textSize,
                      color: item.isActive
                          ? whiteColor
                          : Theme.of(context).textSelectionColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // _saveLang(langData) {
  //   saveChosenLang(langData);
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double left_right_padding = size.width * .10;
    final double top_bottom_padding = size.width * .15;
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
      backgroundColor: Theme.of(context).backgroundColor,
      body: OrientationBuilder(builder: (context, orientation) {
        return Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Align(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: res.sizedBoxHeightSize * 6,
                  ),
                  TextWidget(
                    text: 'Choose Language',
                    size: res.textSize * 1.8,
                    color: Theme.of(context).textSelectionColor,
                  ),
                  SizedBox(
                    height: res.sizedBoxHeightSize * 1.5,
                  ),
                  Container(
                    height: size.height * .64,
                    width: size.width,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: res.horizontalPaddingSize,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: ResponsiveGridRow(
                          children: [
                            ...languagesList
                                .map((item) => _item(item, res, size))
                                .toList()
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: res.sizedBoxHeightSize * 1.5,
                  ),
                  Container(
                    height: size.height * .10,
                    width: size.width * .90,
                    child: Center(
                      child: CustomButton(
                        text: widget.settingBool == true ? 'Done' : 'Continue',
                        screen: Home(
                          globalData: _globalData,
                          globalDataUpdate: widget.globalDataUpdate,
                          updateNightMode: widget.updateNightMode,
                          nightMode: widget.nightMode,
                        ),
                        buttonHeightSize: res.buttonHeightSize * 1.4,
                        buttonWidthSize: res.buttonWidthSize * 2,
                        textSize: res.textSize,
                        navFlag: true,
                        selectedLang: _getActiveLang(),
                        res: res,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
