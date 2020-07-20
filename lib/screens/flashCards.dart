import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:lenglish/models/data.dart';
import 'package:lenglish/ui_elements/circleWithIcon.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/widgets/topAppBar.dart';
import 'package:localstorage/localstorage.dart';
import '../constants.dart';

class FlashCards extends StatefulWidget {
  final List data;
  final int objIndex;

  final List<dynamic> allData;
  final String lang;

  FlashCards(this.data, this.objIndex, this.allData, this.lang);
  @override
  _FlashCardsState createState() => _FlashCardsState();
}

class _FlashCardsState extends State<FlashCards> with TickerProviderStateMixin {
  var controller;
  var _index = 0;
  List<dynamic> data;
  static AudioCache player = AudioCache();
  SwiperController swiperController;

  @override
  void initState() {
    super.initState();
    data = widget.data;
    swiperController = SwiperController();
  }

  _isFavorite(int wordObjIndex, String word) {
    setState(() {
      data =
          setTrue(widget.objIndex, wordObjIndex, word, data, widget.allData, 0);
    });
    swiperController.next();
  }

  _excellent(int wordObjIndex, String word) {
    setState(() {
      data =
          setTrue(widget.objIndex, wordObjIndex, word, data, widget.allData, 1);
    });
    swiperController.next();
  }

  _familiar(int wordObjIndex, String word) {
    setState(() {
      data =
          setTrue(widget.objIndex, wordObjIndex, word, data, widget.allData, 2);
    });
    swiperController.next();
  }

  _unknown(int wordObjIndex, String word) {
    setState(() {
      data =
          setTrue(widget.objIndex, wordObjIndex, word, data, widget.allData, 3);
    });
    swiperController.next();
  }

  Widget _item(var size, int index) {
    if (data[index]['isFavorite'] == "true" ||
        data[index]['isExcellent'] == "true" ||
        data[index]['isFamiliar'] == "true" ||
        data[index]['isUnknown'] == "true") {
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
                            _isFavorite(index, data[index]['en']);
                          },
                          child: SvgPicture.asset(
                            heartIcon,
                            height: 20.0,
                            width: 20.0,
                            color: data[index]['isFavorite'] == "true"
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
                            text: data[index]['en'],
                            size: 24.0,
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextWidget(
                            text: getRightTranslate(
                                data, null, index, widget.lang),
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
                            // playLocal('audio/${data[index]['en']}.mp3');
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
                            text: data[index]['pronunciation'],
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
                                word: data[index]['en']),
                            CircleWithIcon(
                                color: Colors.blue,
                                iconName: hourIcon,
                                iconHeight: 20.0,
                                iconWidth: 10.0,
                                func: _familiar,
                                wordObjIndex: index,
                                word: data[index]['en']),
                            CircleWithIcon(
                                color: Colors.green,
                                iconName: validateIcon,
                                iconHeight: 20.0,
                                iconWidth: 20.0,
                                func: _excellent,
                                wordObjIndex: index,
                                word: data[index]['en']),
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
                  text: '0/50',
                  color: primaryGreyColor,
                ),
                SizedBox(
                  height: 40.0,
                ),
                Container(
                  height: size.height * .70,
                  child: Swiper(
                    itemHeight: size.height * .70,
                    itemWidth: size.width * .50,
                    itemCount: widget.data.length,
                    viewportFraction: 0.7,
                    scale: 0.8,
                    itemBuilder: (BuildContext ctx, int index) {
                      return _item(size, index);
                    },
                    loop: false,
                    duration: 1000,
                    controller: swiperController,
                    index: _index,
                    onIndexChanged: (int index) {
                      print(index);
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
