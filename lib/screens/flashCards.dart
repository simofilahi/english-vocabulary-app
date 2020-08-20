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
import 'package:lenglish/screens/resultModal.dart';

class FlashCards extends StatefulWidget {
  final List<dynamic> item;
  final int objIndex;
  final List<dynamic> allData;
  final List<dynamic> originItem;
  final String lang;
  final Function updateFalshCarsWords;
  final Function updateFamiliarWords;
  final Function updateUnknownWords;
  final Function globalDataUpdate;
  final Function getTotalLearningWords;
  final int flag;
  final int len;
  final Function initialAds;
  final double height;

  FlashCards(
    this.item,
    this.objIndex,
    this.allData,
    this.originItem,
    this.lang,
    this.updateFalshCarsWords,
    this.updateFamiliarWords,
    this.updateUnknownWords,
    this.globalDataUpdate,
    this.getTotalLearningWords,
    this.flag,
    this.len,
    this.initialAds,
    this.height,
  );
  @override
  _FlashCardsState createState() => _FlashCardsState();
}

class _FlashCardsState extends State<FlashCards> with TickerProviderStateMixin {
  var controller;
  var _index = 0;
  BannerAd _bannerAd;
  int _realIndex = 0;
  static AudioCache player = AudioCache();
  SwiperController swiperController;

  List<dynamic> _teenWords = [];
  dynamic _dataCpy = [];
  int _initIndex = 0;
  int _counter = 0;
  int adcounter = 0;
  InterstitialAd _myInterstitial;

  @override
  void initState() {
    super.initState();
    _getTeenNextWords();

    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _initialBannerAds();
    _initialIntAds();
    swiperController = SwiperController();
  }

  _loadInte() {
    _myInterstitial.load();
  }

  _showInte() {
    _myInterstitial.show(
      anchorType: AnchorType.bottom,
      anchorOffset: 0.0,
      horizontalCenterOffset: 0.0,
    );
  }

  _loadBannerAd() {
    _bannerAd.load();
  }

  _showBannerAd() {
    _bannerAd.show(
        horizontalCenterOffset: 0, anchorOffset: widget.height * 0.01);
  }

  _initialIntAds() {
    _myInterstitial = null;
    _myInterstitial = createInterstitialAd();
  }

  _initialBannerAds() async {
    try {
      await _bannerAd.dispose();
    } catch (_) {}
    _bannerAd = null;
    _bannerAd = createBannerAd();
    _loadBannerAd();
  }

  _dismissModal() {
    Navigator.pop(context);
    _initialBannerAds();
    if (adcounter == 0 || adcounter == 2 || adcounter == 4) {
      _loadInte();
    }
    setState(() {
      adcounter += 1;
    });
    _getTeenNextWords();
  }

  dismssAllAds() async {
    try {
      await _bannerAd.dispose();
    } catch (_) {}
    try {
      await _myInterstitial.dispose();
    } catch (_) {}
    widget.initialAds();
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      // Replace the testAdUnitId with an ad unit id from the AdMob dash.
      // https://developers.google.com/admob/android/test-ads
      // https://developers.google.com/admob/ios/test-ads
      adUnitId: InterstitialAd.testAdUnitId,
      listener: (MobileAdEvent event) async {
        if (event == MobileAdEvent.loaded) {
          _showInte();
        }
        if (event == MobileAdEvent.closed) {
          await _myInterstitial.dispose();
          _initialIntAds();
        }
        print("InterstitialAd event is $event");
      },
    );
  }

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.smartBanner,
      // targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
        if (event == MobileAdEvent.loaded) {
          _showBannerAd();
        }
      },
    );
  }

  @override
  void dispose() async {
    super.dispose();
    try {
      await _bannerAd.dispose();
    } catch (_) {}
    try {
      await _myInterstitial.dispose();
    } catch (_) {}
    widget.initialAds();
    swiperController.dispose();
  }

  _getTeenNextWords() {
    List<dynamic> newArr = [];
    int j = 0;
    for (int i = _initIndex; i < widget.item.length; i++) {
      newArr.add(widget.item[i]);
      if (j == 9) break;
      j++;
    }
    setState(() {
      _dataCpy = newArr;
      _teenWords = newArr;
      _initIndex += j + 1;
      _index = 0;
    });
  }

  _updateFun(int index) {
    _dropItemFromList(index);
    setState(() {
      _counter += 1;
    });
    if (_dataCpy.isEmpty) {
      setState(() {
        _index = 0;
      });
      _showModal(context);
      widget.updateFalshCarsWords();
      widget.updateFamiliarWords();
      widget.updateUnknownWords();
      widget.getTotalLearningWords();
    }
  }

  _dropItemFromList(int index) {
    List<dynamic> newData = List<dynamic>.from(_dataCpy);

    newData.removeAt(index);
    setState(() {
      _dataCpy = newData;
      _index = index;
    });
  }

  Future<int> getIndexOfLocalUpdate(String word) async {
    int index = 0;
    for (int j = 0; j < _teenWords.length; j++) {
      if (_teenWords[j]['en'] == word) return index;
      index++;
    }

    return -1;
  }

  Future<int> getIndexOfWord(String word) async {
    int index = 0;
    for (int j = 0; j < widget.originItem.length; j++) {
      if (widget.originItem[j]['en'] == word) return index;
      index++;
    }

    return -1;
  }

  isFavoriteLocal(int index) {
    List<dynamic> newData = List<dynamic>.from(_teenWords);
    newData[index]['isExcellent'] = "false";
    newData[index]['isFamiliar'] = "false";
    newData[index]['isFavorite'] = "true";
    newData[index]['isUnknown'] = "false";

    setState(() {
      _teenWords = newData;
    });
  }

  _isExcellentLocal(int index) {
    List<dynamic> newData = List<dynamic>.from(_teenWords);
    newData[index]['isExcellent'] = "true";
    newData[index]['isFamiliar'] = "false";
    newData[index]['isFavorite'] = "false";
    newData[index]['isUnknown'] = "false";
    setState(() {
      _teenWords = newData;
    });
  }

  _isFamiliarLocal(int index) {
    List<dynamic> newData = List<dynamic>.from(_teenWords);
    newData[index]['isExcellent'] = "false";
    newData[index]['isFamiliar'] = "true";
    newData[index]['isFavorite'] = "false";
    newData[index]['isUnknown'] = "false";
    setState(() {
      _teenWords = newData;
    });
  }

  _isUnknownLocal(int index) {
    List<dynamic> newData = List<dynamic>.from(_teenWords);
    newData[index]['isExcellent'] = "false";
    newData[index]['isFamiliar'] = "false";
    newData[index]['isFavorite'] = "false";
    newData[index]['isUnknown'] = "true";
    setState(() {
      _teenWords = newData;
    });
  }

  _isFavorite(int index, String word) async {
    isFavoriteLocal(await getIndexOfLocalUpdate(word));
    int wordObjIndex = await getIndexOfWord(word);
    setTrue(widget.objIndex, wordObjIndex, word, widget.originItem,
            widget.allData, 0)
        .then((v) {
      _updateFun(index);
    });
  }

  _excellent(int index, String word) async {
    _isExcellentLocal(await getIndexOfLocalUpdate(word));
    int wordObjIndex = await getIndexOfWord(word);
    setTrue(widget.objIndex, wordObjIndex, word, widget.originItem,
            widget.allData, 1)
        .then((v) {
      _updateFun(index);
    });
  }

  _familiar(int index, String word) async {
    _isFamiliarLocal(await getIndexOfLocalUpdate(word));
    int wordObjIndex = await getIndexOfWord(word);
    setTrue(widget.objIndex, wordObjIndex, word, widget.originItem,
            widget.allData, 2)
        .then((v) {
      _updateFun(index);
    });
  }

  _unknown(int index, String word) async {
    _isUnknownLocal(await getIndexOfLocalUpdate(word));
    int wordObjIndex = await getIndexOfWord(word);
    setTrue(widget.objIndex, wordObjIndex, word, widget.originItem,
            widget.allData, 3)
        .then((v) {
      _updateFun(index);
    });
  }

  playLocal(path) async {
    assetsAudioPlayer.open(
      Audio(path),
    );
  }

  Widget _likeButtonBuild(var size, int index) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: size.width * 0.0085 * 4,
            bottom: size.height * 0.006,
          ),
          child: LikeButton(
            onTap: (bool isLiked) async {
              Timer(Duration(milliseconds: 900), () {
                _isFavorite(index, _dataCpy[index]['en']);
              });
              return true;
            },
            size: size.width * .08,
            circleColor:
                CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
            bubblesColor: BubblesColor(
              dotPrimaryColor: Color(0xff33b5e5),
              dotSecondaryColor: Color(0xff0099cc),
            ),
            likeBuilder: (bool isLiked) {
              if (_dataCpy[index]['isFavorite'] == "true") {
                return Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: size.height * 0.038,
                );
              }
              // // timer.cancel();
            },
          ),
        ),
      ],
    );
  }

  Widget _wordBuild(var size, int index) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: TextWidget(
              text: _dataCpy[index]['en'],
              size: size.width * .08,
              color: Theme.of(context).textSelectionColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: TextWidget(
              text: getRightTranslate(_dataCpy, null, index, widget.lang),
              color: Theme.of(context).cursorColor,
              size: size.width * .05,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }

  Widget _exampleBuild(var size, int index, double padding) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: size.height * 0.05,
        ),
        FittedBox(
          child: TextWidget(
            text: 'Examples',
            size: size.width * .055,
            color: Theme.of(context).textSelectionColor,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: padding * 0.5,
            right: padding * 0.5,
          ),
          child: Container(
            height: size.height * 0.1,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  Text(
                    _dataCpy[index]['examples'],
                    maxLines: 10,
                    style: TextStyle(
                      fontSize: size.width * .036,
                      color: Theme.of(context).cursorColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _speakerBuild(var size, int index) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: size.height * 0.0055,
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () {
                playLocal(
                  'assets/audio/${_dataCpy[index]['audioPath']}',
                );
              },
              borderRadius: BorderRadius.circular(
                size.width * 0.0469 * 6,
              ),
              highlightColor: rippleColor,
              child: Padding(
                padding: EdgeInsets.all(
                  size.width * 0.01,
                ),
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
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.01,
              ),
              child: Text(
                _dataCpy[index]['pronunciation'],
                style: TextStyle(
                  color: Theme.of(context).cursorColor,
                  fontSize: size.width * .04,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _choosenButton(var size, int index) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CircleWithIcon(
              color: Colors.red,
              iconName: closeIcon,
              iconHeight: size.height * 0.025,
              iconWidth: size.height * 0.025,
              index: index,
              func: _unknown,
              word: _dataCpy[index]['en'],
            ),
            CircleWithIcon(
              color: Colors.blue,
              iconName: hourIcon,
              iconHeight: size.height * 0.025,
              iconWidth: size.height * 0.025,
              index: index,
              func: _familiar,
              word: _dataCpy[index]['en'],
            ),
            CircleWithIcon(
              color: Colors.green,
              iconName: validateIcon,
              iconHeight: size.height * 0.025,
              iconWidth: size.height * 0.025,
              index: index,
              func: _excellent,
              word: _dataCpy[index]['en'],
            ),
          ],
        ),
      ),
    );
  }

  Widget itemRender(BuildContext context, var size, int index) {
    var padding = size.width * .10;
    return Padding(
      padding: EdgeInsets.all(
        size.width * 0.02,
      ),
      child: Container(
        height: size.height * .65,
        width: size.width * .80,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(
            size.width * 0.0469,
          ),
          boxShadow: [
            shadow(
              Theme.of(context).cardColor,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.0055 * 4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: size.height * 0.05,
                child: _likeButtonBuild(size, index),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: _wordBuild(size, index),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: _exampleBuild(size, index, padding),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: _speakerBuild(size, index),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: _choosenButton(size, index),
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

  _showModal(BuildContext context) async {
    await _bannerAd?.dispose();
    showGeneralDialog(
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 200),
      context: context,
      pageBuilder:
          (BuildContext _, Animation animation, Animation secondaryAnimation) {
        return ResultModal(
          data: _teenWords,
          lang: widget.lang,
          dismiss: _dismissModal,
          dismssAllAds: dismssAllAds,
        );
      },
    );
  }

  Widget _swiperBuilder(var size) {
    return Container(
      height: size.height * .70,
      child: Swiper(
        duration: 500,
        itemHeight: size.height * .70,
        itemWidth: size.width * .50,
        itemCount: _dataCpy.length,
        viewportFraction: 0.7,
        scale: 0.8,
        itemBuilder: (BuildContext _, int index) {
          return _listItem(context, size, index);
        },
        controller: swiperController,
        onIndexChanged: (int index) {
          setState(() {
            _index = index;
          });
        },
        index: _index,
        loop: false,
      ),
    );
  }

  setDismissedToFalse() {}

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
                  text: _counter == widget.item.length
                      ? "${_counter} / ${widget.item.length}"
                      : "${_counter + 1} / ${widget.item.length}",
                  color: primaryGreyColor,
                  clickHandler: setDismissedToFalse,
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
