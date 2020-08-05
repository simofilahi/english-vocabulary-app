import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/logic/initalizeFiles.dart';
import 'package:lenglish/models/languages.dart';
import 'package:lenglish/screens/home.dart';
import 'package:lenglish/widgets/customButton.dart';
import 'package:lenglish/widgets/textWidget.dart';
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
      print(data);
      setState(() {
        _globalData = data;
      });
    });
  }

  final List<LanguagesList> languagesList = [
    LanguagesList(
      name: 'Spanich',
      icon: 'assets/icons/spain.svg',
      isActive: true,
    ),
    LanguagesList(
      name: 'French',
      icon: 'assets/icons/france.svg',
      isActive: false,
    ),
    LanguagesList(
      name: 'Arabic',
      icon: 'assets/icons/saudi-arabia.svg',
      isActive: false,
    ),
    LanguagesList(
      name: 'Chinese',
      icon: 'assets/icons/china.svg',
      isActive: false,
    ),
    LanguagesList(
      name: 'Italian',
      icon: 'assets/icons/italy.svg',
      isActive: false,
    ),
    LanguagesList(
      name: 'Hindi',
      icon: 'assets/icons/india.svg',
      isActive: false,
    ),
    LanguagesList(
      name: 'Urdu',
      icon: 'assets/icons/pakistan.svg',
      isActive: false,
    ),
    LanguagesList(
      name: 'Filipino',
      icon: 'assets/icons/philippines.svg',
      isActive: false,
    ),
    LanguagesList(
      name: 'German',
      icon: 'assets/icons/germany.svg',
      isActive: false,
    ),
    LanguagesList(
      name: 'Russian',
      icon: 'assets/icons/russia.svg',
      isActive: false,
    ),
    LanguagesList(
      name: 'Turkish',
      icon: 'assets/icons/turkey.svg',
      isActive: false,
    ),
    LanguagesList(
      name: 'Bengali',
      icon: 'assets/icons/bangladesh.svg',
      isActive: false,
    ),
  ];

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

  Widget _item(LanguagesList item) {
    return ResponsiveGridCol(
      xs: 4,
      xl: 2,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _changeIsActive(item);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5.0,
              vertical: 5.0,
            ),
            child: Container(
              height: 80.0,
              decoration: BoxDecoration(
                color: item.isActive
                    ? primaryBlueColor
                    : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FittedBox(
                    child: SvgPicture.asset(
                      item.icon,
                      height: 30.0,
                      width: 30.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  FittedBox(
                    child: TextWidget(
                      text: item.name,
                      size: 18.0,
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
                    height: size.height * .15,
                  ),
                  TextWidget(
                    text: 'Choose Language',
                    size: 30.0,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    height: size.height * .55,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 35.0,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: ResponsiveGridRow(
                          children: [
                            ...languagesList.map((item) => _item(item)).toList()
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  CustomButton(
                    text: widget.settingBool == true ? 'Done' : 'Continue',
                    screen: Home(
                      globalData: _globalData,
                      globalDataUpdate: widget.globalDataUpdate,
                      updateNightMode: widget.updateNightMode,
                      nightMode: widget.nightMode,
                    ),
                    navFlag: true,
                    selectedLang: _getActiveLang(),

                    // saveLang: _saveLang,
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
