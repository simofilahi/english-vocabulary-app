import 'package:audioplayers/audio_cache.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:lenglish/ui_elements/circleWithIcon.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/widgets/topAppBar.dart';
import 'package:like_button/like_button.dart';
import '../constants.dart';
import 'package:lenglish/logic/initalizeFiles.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'dart:async';

class FlashCards extends StatefulWidget {
  final List<dynamic> item;
  final int objIndex;
  final List<dynamic> allData;
  final String lang;
  final Function updateFalshCarsWords;
  final Function updateFamiliarWords;
  final Function updateUnknownWords;
  final Function globalDataUpdate;
  // final Function _updateCountOfWords;
  final Function getTotalLearningWords;
  final int flag;
  final int len;

  FlashCards(
    this.item,
    this.objIndex,
    this.allData,
    this.lang,
    this.updateFalshCarsWords,
    this.updateFamiliarWords,
    this.updateUnknownWords,
    this.globalDataUpdate,
    // this._updateCountOfWords,
    this.getTotalLearningWords,
    this.flag,
    this.len,
  );
  @override
  _FlashCardsState createState() => _FlashCardsState();
}

class _FlashCardsState extends State<FlashCards> with TickerProviderStateMixin {
  var controller;
  var _index = 0;
  BannerAd _bannerAd;

  static AudioCache player = AudioCache();
  SwiperController swiperController;

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _bannerAd = createBannerAd()
      ..load()
      ..show(horizontalCenterOffset: 0, anchorOffset: 10);
    swiperController = SwiperController();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
    // widget._updateCountOfWords();
  }

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      // targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  _updateFun() {
    widget.updateFalshCarsWords();
    widget.updateFamiliarWords();
    widget.updateUnknownWords();
    widget.getTotalLearningWords();
    swiperController.next();
  }

  _isFavorite(int wordObjIndex, String word) {
    setTrue(widget.objIndex, wordObjIndex, word, widget.item, widget.allData, 0)
        .then((v) {
      _updateFun();
    });
  }

  _excellent(int wordObjIndex, String word) {
    setTrue(widget.objIndex, wordObjIndex, word, widget.item, widget.allData, 1)
        .then((v) {
      _updateFun();
    });
  }

  _familiar(int wordObjIndex, String word) {
    setTrue(widget.objIndex, wordObjIndex, word, widget.item, widget.allData, 2)
        .then((v) {
      _updateFun();
    });
  }

  _unknown(int wordObjIndex, String word) {
    setTrue(widget.objIndex, wordObjIndex, word, widget.item, widget.allData, 3)
        .then((v) {
      _updateFun();
    });
  }

  playLocal(path) async {
    assetsAudioPlayer.open(
      Audio(path),
    );
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    Timer(Duration(seconds: 1), () {
      _isFavorite(0, widget.item[0]['en']);
    });

    return !isLiked;
  }

  Widget itemRender(BuildContext context, var size, int index) {
    var padidng = size.width * .10;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: size.height * .65,
        width: size.width * .80,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(
            15.0,
          ),
          boxShadow: [
            shadow(Theme.of(context).cardColor),
          ],
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
                    LikeButton(
                      onTap: (bool isLiked) async {
                        Timer(Duration(milliseconds: 900), () {
                          _isFavorite(index, widget.item[index]['en']);
                        });
                        return true;
                      },
                      size: size.width * .08,
                      circleColor: CircleColor(
                          start: Color(0xff00ddff), end: Color(0xff0099cc)),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: Color(0xff33b5e5),
                        dotSecondaryColor: Color(0xff0099cc),
                      ),
                      likeBuilder: (bool isLiked) {
                        // print("Hello");
                        if (widget.item[index]['isFavorite'] == "true") {
                          return Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 30,
                          );
                        }
                        // // timer.cancel();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        TextWidget(
                          text: widget.item[index]['en'],
                          size: size.width * .08,
                          color: Theme.of(context).textSelectionColor,
                          fontWeight: FontWeight.bold,
                        ),
                        TextWidget(
                          text: getRightTranslate(
                              widget.item, null, index, widget.lang),
                          color: Theme.of(context).cursorColor,
                          size: size.width * .056,
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
                      height: 20.0,
                    ),
                    FittedBox(
                      child: TextWidget(
                        text: 'Examples',
                        size: size.width * .06,
                        color: Theme.of(context).textSelectionColor,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: padidng,
                        right: padidng,
                      ),
                      child: SingleChildScrollView(
                        controller: controller,
                        child: Column(
                          children: <Widget>[
                            TextWidget(
                              text: widget.item[index]['examples'],
                              size: size.width * .056,
                              color: Theme.of(context).cursorColor,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
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
                          playLocal(
                            'assets/audio/${widget.item[index]['audioPath']}',
                          );
                        },
                        child: FittedBox(
                          child: SvgPicture.asset(
                            speakerIcon,
                            height: size.height * .04,
                            width: size.height * .04,
                            color: Theme.of(context).indicatorColor,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 5.0,
                        ),
                        child: TextWidget(
                          text: widget.item[index]['pronunciation'],
                          color: Theme.of(context).cursorColor,
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
                            iconHeight: size.height * 0.025,
                            iconWidth: size.height * 0.025,
                            func: _unknown,
                            wordObjIndex: index,
                            word: widget.item[index]['en'],
                          ),
                          CircleWithIcon(
                            color: Colors.blue,
                            iconName: hourIcon,
                            iconHeight: size.height * 0.025,
                            iconWidth: size.height * 0.025,
                            func: _familiar,
                            wordObjIndex: index,
                            word: widget.item[index]['en'],
                          ),
                          CircleWithIcon(
                            color: Colors.green,
                            iconName: validateIcon,
                            iconHeight: size.height * 0.025,
                            iconWidth: size.height * 0.025,
                            func: _excellent,
                            wordObjIndex: index,
                            word: widget.item[index]['en'],
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

  Widget _listItem(BuildContext context, var size, int index) {
    return itemRender(context, size, index);
  }

  Widget _swiperBuilder(var size) {
    return Container(
      height: size.height * .70,
      child: Swiper(
        duration: 1000,
        itemHeight: size.height * .70,
        itemWidth: size.width * .50,
        itemCount: widget.item.length,
        viewportFraction: 0.7,
        scale: 0.8,
        itemBuilder: (BuildContext ctx, int index) {
          return _listItem(context, size, index);
        },
        controller: swiperController,
        onIndexChanged: (int index) {
          // print(_index);
          if (widget.len == _index + 1) {
            setState(() {
              _index += 1;
            });
          } else {
            setState(() {
              _index = index;
            });
          }
        },
        index: _index,
        loop: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
                  text: _index + 1 > widget.len
                      ? '${widget.len}/${widget.len}'
                      : '${_index + 1}/${widget.len}',
                  color: primaryGreyColor,
                ),
                SizedBox(
                  height: size.height * .09,
                ),
                widget.len == _index
                    ? Container(
                        // child: TextWidget(text: 'finish'),
                        )
                    : _swiperBuilder(size),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
