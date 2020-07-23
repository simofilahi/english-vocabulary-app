import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:lenglish/ui_elements/circleWithIcon.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/widgets/topAppBar.dart';
import '../constants.dart';

class FlashCards extends StatefulWidget {
  final List<dynamic> item;
  final int objIndex;
  final List<dynamic> allData;
  final String lang;
  final Function updateFalshCarsWords;
  final Function updateFamiliarWords;
  final Function updateUnknownWords;
  final Function globalDataUpdate;
  final Function getTotalLearningWords;

  FlashCards(
      this.item,
      this.objIndex,
      this.allData,
      this.lang,
      this.updateFalshCarsWords,
      this.updateFamiliarWords,
      this.updateUnknownWords,
      this.globalDataUpdate,
      this.getTotalLearningWords);
  @override
  _FlashCardsState createState() => _FlashCardsState();
}

class _FlashCardsState extends State<FlashCards> with TickerProviderStateMixin {
  var controller;
  var _index = 0;
  List<dynamic> _item;
  static AudioCache player = AudioCache();
  SwiperController swiperController;

  @override
  void initState() {
    super.initState();
    setState(() {
      _item = widget.item;
    });
    swiperController = SwiperController();
  }

  _isFavorite(int wordObjIndex, String word) {
    setState(() {
      _item = setTrue(
          widget.objIndex, wordObjIndex, word, _item, widget.allData, 0);
    });
    widget.updateFalshCarsWords();
    widget.globalDataUpdate();
    swiperController.next();
  }

  _excellent(int wordObjIndex, String word) {
    setState(() {
      _item = setTrue(
          widget.objIndex, wordObjIndex, word, _item, widget.allData, 1);
    });
    widget.getTotalLearningWords();
    widget.updateFalshCarsWords();
    widget.globalDataUpdate();
    swiperController.next();
  }

  _familiar(int wordObjIndex, String word) {
    setState(() {
      _item = setTrue(
          widget.objIndex, wordObjIndex, word, _item, widget.allData, 2);
    });
    widget.updateFalshCarsWords();
    widget.updateFamiliarWords();
    widget.globalDataUpdate();
    swiperController.next();
  }

  _unknown(int wordObjIndex, String word) {
    setState(() {
      _item = setTrue(
          widget.objIndex, wordObjIndex, word, _item, widget.allData, 3);
    });
    widget.updateFalshCarsWords();
    widget.updateUnknownWords();
    widget.globalDataUpdate();
    swiperController.next();
  }

  Widget _listItem(var size, int index) {
    if (_item[index]['isFavorite'] == "true" ||
        _item[index]['isExcellent'] == "true" ||
        _item[index]['isFamiliar'] == "true" ||
        _item[index]['isUnknown'] == "true") {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: size.height * .65,
          width: size.width * .80,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(
              15.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: <Widget>[
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            _isFavorite(index, _item[index]['en']);
                          },
                          child: SvgPicture.asset(
                            heartIcon,
                            height: 20.0,
                            width: 20.0,
                            color: _item[index]['isFavorite'] == "true"
                                ? Colors.red
                                : primaryGreyColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),
                          TextWidget(
                            text: _item[index]['en'],
                            size: 24.0,
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextWidget(
                            text: getRightTranslate(
                                _item, null, index, widget.lang),
                            color: primaryGreyColor,
                            size: 20.0,
                            fontWeight: FontWeight.w400,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      TextWidget(
                        text: 'Examples',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // playLocal('audio/${_item[index]['en']}.mp3');
                          },
                          child: SvgPicture.asset(
                            speakerIcon,
                            height: 50,
                            width: 50.0,
                            color: primaryGreyColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 5.0,
                          ),
                          child: TextWidget(
                            text: _item[index]['pronunciation'],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CircleWithIcon(
                              color: Colors.red,
                              iconName: closeIcon,
                              iconHeight: 20.0,
                              iconWidth: 20.0,
                              func: _unknown,
                              wordObjIndex: index,
                              word: _item[index]['en'],
                            ),
                            CircleWithIcon(
                              color: Colors.blue,
                              iconName: hourIcon,
                              iconHeight: 20.0,
                              iconWidth: 10.0,
                              func: _familiar,
                              wordObjIndex: index,
                              word: _item[index]['en'],
                            ),
                            CircleWithIcon(
                              color: Colors.green,
                              iconName: validateIcon,
                              iconHeight: 20.0,
                              iconWidth: 20.0,
                              func: _excellent,
                              wordObjIndex: index,
                              word: _item[index]['en'],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Column(
              children: <Widget>[
                TopAppBar(
                  icon_1: backArrowIcon,
                  icon_2: null,
                  text: '${_index + 1}/${_item.length.toString()}',
                  color: primaryGreyColor,
                ),
                SizedBox(
                  height: 40.0,
                ),
                Container(
                  height: size.height * .70,
                  child: Swiper(
                    duration: 2000,
                    itemHeight: size.height * .70,
                    itemWidth: size.width * .50,
                    itemCount: _item.length,
                    viewportFraction: 0.7,
                    scale: 0.8,
                    itemBuilder: (BuildContext ctx, int index) {
                      return _listItem(size, index);
                    },
                    loop: true,
                    controller: swiperController,
                    index: _index,
                    onIndexChanged: (int index) {
                      // print(_index);
                      setState(() {
                        _index = index;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
