import 'package:flutter/material.dart';
import 'package:lenglish/screens/wordsList.dart';
import 'package:lenglish/ui_elements/infoConatiner.dart';
import 'package:lenglish/widgets/radialProgress.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/models/responsive.dart';
import 'package:lenglish/widgets/topAppBar.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:lenglish/logic/initalizeFiles.dart';

import 'package:responsive_grid/responsive_grid.dart';
import '../constants.dart';

class HomeWidget extends StatefulWidget {
  final List<dynamic> globalData;
  final String lang;
  final Function globalDataUpdate;
  final int totalLearningWords;
  Function getTotalLearningWords;
  final Function setNewGlobalData;

  HomeWidget({
    this.globalData,
    this.lang,
    this.globalDataUpdate,
    this.totalLearningWords,
    this.getTotalLearningWords,
    this.setNewGlobalData,
  });

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  double _level;
  List<dynamic> _globalData = [];
  int _totalLearningWords = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _globalData = widget.globalData;
      _level = widget.totalLearningWords * 20 / 2264;
      _totalLearningWords = widget.totalLearningWords;
    });
  }

  updatingData() async {
    print("ccccccccccccccccccccccccccccccccccccc");
    dynamic data = await getGlobalData();
    int number = await totoalLearningWords(data);
    print("new data =====> ${number}");
    setState(() {
      _globalData = data;
      _totalLearningWords = number;
      _level = number * 20 / 2264;
    });
  }

  Widget _rowItem(String text, int value, var size) {
    var textSize = size.width * 0.042;

    return Container(
      width: size.width * .40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextWidget(
            text: text,
            color: whiteColor,
            size: textSize,
          ),
          TextWidget(text: value.toString(), color: whiteColor, size: textSize),
        ],
      ),
    );
  }

  Widget _progressCard(
    var size,
    Responsive res,
  ) {
    return FittedBox(
      child: Container(
        height: res.containerHeightSize,
        width: res.containerWidthSize,
        decoration: BoxDecoration(
            color: primaryBlueColor,
            borderRadius: BorderRadius.circular(
              res.borderRadiusSize * 0.8,
            ),
            boxShadow: [
              shadow(
                Theme.of(context).cardColor,
              )
            ]),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                right: res.rightPaddingSize,
                left: res.leftPaddingSize,
                top: res.topPaddingSize * 4,
                bottom: res.bottomPaddingSize * 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FittedBox(
                    child: RadialProgress(
                      goalCompleted: _totalLearningWords.toDouble() / 2264,
                      percent: _totalLearningWords.toDouble() * 100 / 2264,
                      height: res.circleHeightSize * 1.6,
                      width: res.circleWidthSize * 1.6,
                      color: whiteColor,
                      flag: true,
                      res: res,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: res.sizedBoxHeightSize,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0XFF7491F0).withOpacity(
                    0.6,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      res.borderRadiusSize,
                    ),
                    topRight: Radius.circular(
                      res.borderRadiusSize,
                    ),
                    bottomLeft: Radius.circular(
                      res.borderRadiusSize * 0.8,
                    ),
                    bottomRight: Radius.circular(
                      res.borderRadiusSize * 0.8,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FittedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _rowItem(
                            'Level',
                            _level.toInt(),
                            size,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          _rowItem('Total words', 2264, size),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          _rowItem('Learning words', _totalLearningWords, size),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _resetItem(var data, int index) {
    resetItemHomeWidget(widget.globalData, data, index).then(
      (value) async {
        if (value) {
          List<dynamic> data = await allData.getItem();
          setState(() {
            _globalData = data;
          });
          widget.getTotalLearningWords();
        }
      },
    );
  }

  _resetAll() async {
    await widget.setNewGlobalData();
    await widget.globalDataUpdate();
    await widget.getTotalLearningWords();
    int number = await totoalLearningWords(widget.globalData);
    setState(() {
      _totalLearningWords = number;
      _level = number * 20 / 2264;
    });
  }

  Widget _item(
      BuildContext context,
      int index,
      Color firstColor,
      Color secondColor,
      var data,
      int learning_words,
      var size,
      Responsive res) {
    return ResponsiveGridCol(
      xs: 6,
      sm: 6,
      md: 6,
      lg: 6,
      xl: 6,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext ctx) => WordsList(
                data,
                index,
                widget.globalData,
                widget.lang,
                widget.globalDataUpdate,
                widget.getTotalLearningWords,
                updatingData,
              ),
              settings: RouteSettings(
                name: 'WordList',
              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.only(
            left: res.leftPaddingSize,
            right: res.rightPaddingSize,
            bottom: res.leftPaddingSize + res.rightPaddingSize,
          ),
          child: Container(
            height: size.height * .38,
            decoration: BoxDecoration(
              color: firstColor,
              borderRadius: BorderRadius.circular(
                res.borderRadiusSize * 0.8,
              ),
              boxShadow: [
                shadow(
                  Theme.of(context).cardColor,
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: res.verticalPaddingSize,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RadialProgress(
                            goalCompleted: learning_words.toDouble() / 50,
                            percent: learning_words.toDouble() * 100 / 50,
                            height: res.circleHeightSize,
                            width: res.circleWidthSize,
                            color: whiteColor,
                            flag: false,
                            res: res,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: InfoContainer(
                    setNumber: index + 1,
                    totalWords: 50,
                    learningWords: learning_words,
                    firstColor: firstColor,
                    secondColor: secondColor,
                    reset: () => _resetItem(data, index),
                    res: res,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _gridList(BuildContext context, var size, Responsive res) {
    return Container(
      width: size.width * .93,
      child: ResponsiveGridRow(
        children: [
          ..._globalData
              .asMap()
              .map(
                (index, item) => MapEntry(
                  index,
                  _item(
                    context,
                    index,
                    colors[index]['first_color'],
                    colors[index]['second_color'],
                    item['set_${index + 1}'].toList(),
                    int.parse(item['learning_words']),
                    size,
                    res,
                  ),
                ),
              )
              .values
              .toList(),
        ],
      ),
    );
  }

  Widget _topAppBar() {
    return TopAppBar(
      icon_1: crownIcon,
      icon_2: moreIcon,
      icon_2_flag: 1,
      icon_1_flag: 1,
      text: 'Home',
      textSize: 18.9,
      color: blackColor,
      fontWeight: FontWeight.bold,
      clickHandler: _resetAll,
    );
  }

  Widget _budyBuild(BuildContext context, var size) {
    Responsive res = Responsive(
      containerHeightSize: size.height * .4,
      borderRadiusSize: size.width * 0.0469,
      containerWidthSize: size.width * .90,
      sizedBoxHeightSize: size.height * 0.02,
      textSize: size.width * 0.045,
      iconSize: size.height * 0.038,
      circleHeightSize: size.height * 0.09,
      circleWidthSize: size.height * 0.09,
      bottomPaddingSize: size.height * 0.0055,
      topPaddingSize: size.height * 0.0055,
      rightPaddingSize: size.width * 0.0085,
      leftPaddingSize: size.width * 0.0085,
    );
    return Expanded(
      child: Container(
        width: size.width * .90,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: res.horizontalPaddingSize,
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: res.sizedBoxHeightSize,
                ),
                _progressCard(size, res),
                SizedBox(
                  height: res.sizedBoxHeightSize,
                ),
                _gridList(context, size, res),
              ],
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
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            _topAppBar(),
            _budyBuild(context, size),
          ],
        ),
      ),
    );
  }
}
