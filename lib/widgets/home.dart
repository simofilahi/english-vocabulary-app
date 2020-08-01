import 'package:flutter/material.dart';
import 'package:lenglish/screens/wordsList.dart';
import 'package:lenglish/ui_elements/infoConatiner.dart';
import 'package:lenglish/widgets/radialProgress.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/widgets/topAppBar.dart';

import '../constants.dart';

class HomeWidget extends StatefulWidget {
  final List<dynamic> globalData;
  final String lang;
  final Function globalDataUpdate;
  final int totalLearningWords;
  final Function getTotalLearningWords;

  HomeWidget({
    this.globalData,
    this.lang,
    this.globalDataUpdate,
    this.totalLearningWords,
    this.getTotalLearningWords,
  });

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  double _level;

  @override
  void initState() {
    super.initState();
    _level = widget.totalLearningWords * 20 / 2265;
  }

  Widget _rowItem(String text, int value, var size) {
    return Container(
      width: size.width * .40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextWidget(
            text: text,
            color: whiteColor,
          ),
          TextWidget(
            text: value.toString(),
            color: whiteColor,
          ),
        ],
      ),
    );
  }

  Widget _progressCard(var size) {
    return Container(
      height: 250,
      width: size.width * .90,
      decoration: BoxDecoration(
        color: primaryBlueColor,
        borderRadius: BorderRadius.circular(
          15.0,
        ),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RadialProgress(
                  goalCompleted: widget.totalLearningWords.toDouble() / 2265,
                  percent: widget.totalLearningWords.toDouble() * 100 / 2265,
                  height: 100,
                  width: 100,
                  color: whiteColor,
                  flag: true,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0XFF7491F0).withOpacity(
                  0.6,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(leftRightTopValue),
                  topRight: Radius.circular(leftRightTopValue),
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
              child: Center(
                child: FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _rowItem(
                        'level',
                        _level.toInt(),
                        size,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      _rowItem('total words', 2265, size),
                      SizedBox(
                        height: 15.0,
                      ),
                      _rowItem(
                          'Learing words', widget.totalLearningWords, size),
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _item(BuildContext context, int index, Color firstColor,
      Color secondColor, var data, int learning_words) {
    print("learning words");
    print(learning_words);
    return InkWell(
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
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: firstColor,
          borderRadius: BorderRadius.circular(
            15.0,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RadialProgress(
                        goalCompleted: learning_words.toDouble() / 50,
                        percent: learning_words.toDouble() * 100 / 50,
                        height: 50,
                        width: 50,
                        color: whiteColor,
                        flag: false,
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
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _wordsItem(BuildContext context) {
    int index = -1;
    var newdata = widget.globalData.map((item) {
      index++;
      return _item(
          context,
          index,
          colors[index]['first_color'],
          colors[index]['second_color'],
          item['set_${index + 1}'].toList(),
          int.parse(item['learning_words']));
    }).toList();
    return newdata;
  }

  Widget _gridList(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.all(20.0),
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      crossAxisCount: 2,
      childAspectRatio: (1 / 1.4),
      controller: new ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: _wordsItem(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            TopAppBar(
              icon_1: crownIcon,
              icon_2: moreIcon,
              text: 'Home',
              textSize: 18.9,
              color: blackColor,
              fontWeight: FontWeight.bold,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    _progressCard(size),
                    SizedBox(
                      height: 10.0,
                    ),
                    _gridList(context),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
