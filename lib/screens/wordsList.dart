import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Steria/logic/BoolSetter.dart';
import 'package:Steria/logic/initalizeFiles.dart';
import 'package:Steria/widgets/textWidget.dart';
import 'package:Steria/widgets/topAppBar.dart';
import 'package:firebase_admob/firebase_admob.dart';
import '../constants.dart';
import 'package:Steria/models/responsive.dart';
import 'flashCards.dart';

class WordsList extends StatefulWidget {
  final List data;
  final int objIndex;
  final List<dynamic> allData;
  final String lang;
  final Function globalDataUpdate;
  final Function getTotalLearningWords;
  final Function updatingData;
  final double height;

  WordsList(
    this.data,
    this.objIndex,
    this.allData,
    this.lang,
    this.globalDataUpdate,
    this.getTotalLearningWords,
    this.updatingData,
    this.height,
  );

  @override
  _WordsListState createState() => _WordsListState();
}

class _WordsListState extends State<WordsList> {
  List<dynamic> _flashCardWords = [];
  List<dynamic> _familiarWords = [];
  List<dynamic> _unknowWords = [];
  BannerAd _bannerAd;
  List<dynamic> _originItem = [];
  String bannerId = 'ca-app-pub-2078580912080341/6114178796';

  @override
  void initState() {
    super.initState();
    setState(() {
      _originItem = widget.data;
    });
    _initialAds();
    _updateFalshCarsWords();
    _updateFamiliarWords();
    _updateUnknownWords();
  }

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: bannerId,
      size: AdSize.smartBanner,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
        if (event == MobileAdEvent.loaded) {
          _showBannerAd();
        }
        if (event == MobileAdEvent.failedToLoad) {
          _initialAds();
        }
      },
    );
  }

  _loadBannerAd() {
    _bannerAd.load();
  }

  _showBannerAd() {
    _bannerAd.show(
        horizontalCenterOffset: 0, anchorOffset: widget.height * 0.01);
  }

  _initialAds() async {
    try {
      await _bannerAd.dispose();
    } catch (_) {}
    _bannerAd = null;
    _bannerAd = createBannerAd();
    _loadBannerAd();
  }

  @override
  void dispose() async {
    super.dispose();
    try {
      await _bannerAd.dispose();
      widget.updatingData();
    } catch (_) {}
  }

  _updateFalshCarsWords() {
    setState(() {
      _flashCardWords = getWords(widget.data);
    });
  }

  _updateFamiliarWords() {
    setState(() {
      _familiarWords = getFamiliarWord(widget.data);
    });
  }

  _updateUnknownWords() {
    setState(() {
      _unknowWords = getUnknownWord(widget.data);
    });
  }

  playLocal(path) async {
    assetsAudioPlayer.open(
      Audio(path),
    );
  }

  Widget _cardItem(BuildContext context, var size, String title, String icon,
      String subtitle, List<dynamic> item, int flag, int len, Responsive res) {
    return Material(
      borderRadius: BorderRadius.circular(
        res.borderRadiusSize,
      ),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(
          res.borderRadiusSize,
        ),
        highlightColor: rippleColor,
        onTap: () {
          try {
            _bannerAd.dispose();
          } catch (_) {}
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext ctx) => FlashCards(
                item,
                widget.objIndex,
                widget.allData,
                _originItem,
                widget.lang,
                _updateFalshCarsWords,
                _updateFamiliarWords,
                _updateUnknownWords,
                widget.globalDataUpdate,
                widget.getTotalLearningWords,
                flag,
                len,
                _initialAds,
                size.height,
              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: res.verticalPaddingSize,
            horizontal: res.horizontalPaddingSize * 0.2,
          ),
          child: Container(
            height: size.height * .10,
            width: size.width * 90.0,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(
                res.borderRadiusSize,
              ),
              boxShadow: [
                shadow(Theme.of(context).cardColor),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: res.leftPaddingSize * 4,
                  ),
                  child: Row(
                    children: <Widget>[
                      FittedBox(
                        child: SvgPicture.asset(
                          icon,
                          height: res.iconSize * 2,
                          width: res.iconSize * 2,
                        ),
                      ),
                      SizedBox(
                        width: res.sizedBoxWidthSize,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextWidget(
                            text: title,
                            size: size.width * 0.048,
                            color: Theme.of(context).textSelectionColor,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: res.sizedBoxHeightSize * 0.1,
                          ),
                          TextWidget(
                            text: subtitle,
                            color: Theme.of(context).cursorColor,
                            size: size.width * 0.045,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: res.rightPaddingSize * 4,
                  ),
                  child: FittedBox(
                    child: SvgPicture.asset(
                      rightArrowtIcon,
                      height: size.height * .02,
                      width: size.height * .02,
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listItem(
      BuildContext context, var size, List data, int index, Responsive res) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: res.verticalPaddingSize,
        horizontal: res.horizontalPaddingSize * 0.2,
      ),
      child: Container(
        height: size.height * .08,
        width: size.width * .90,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(
            // check here
            res.borderRadiusSize,
          ),
          boxShadow: [
            shadow(Theme.of(context).cardColor),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(
                  left: res.rightPaddingSize * 4,
                ),
                child: Text(
                  data[index]['en'],
                  style: TextStyle(
                    fontSize: res.textSize,
                    color: Theme.of(context).textSelectionColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                getRightTranslate(data, null, index, widget.lang),
                style: TextStyle(
                  fontSize: res.textSize,
                  color: Theme.of(context).textSelectionColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  playLocal('assets/audio/${widget.data[index]['audioPath']}');
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    left: res.leftPaddingSize * 6,
                  ),
                  child: SvgPicture.asset(
                    speakerIcon,
                    height: res.iconSize,
                    width: res.iconSize,
                    color: Theme.of(context).indicatorColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textDivder(final size, Responsive res) {
    final containerHeight = size.height * .07;
    final textSize = size.width * .05;
    final leftPadding = size.width * 0.025;

    return Container(
      height: containerHeight,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: leftPadding),
            child: TextWidget(
              text: 'All words',
              size: textSize,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textSelectionColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Responsive res = Responsive(
      containerHeightSize: size.height * .08,
      containerWidthSize: size.width * .90,
      sizedBoxHeightSize: size.height * 0.028,
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
    );
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        height: size.height,
        width: size.width,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              TopAppBar(
                icon_1: backArrowIcon,
                icon_2: null,
                text: 'Words',
              ),
              SizedBox(
                height: res.sizedBoxHeightSize,
              ),
              Container(
                height: size.height * .78,
                width: size.width * .95,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: res.horizontalPaddingSize * 0.5,
                  ),
                  child: ListView(
                    children: <Widget>[
                      _cardItem(
                        context,
                        size,
                        'Words',
                        wordsIcon,
                        _flashCardWords == [] || _flashCardWords == null
                            ? '0 words'
                            : '${_flashCardWords.length.toString()} words',
                        _flashCardWords,
                        0,
                        _flashCardWords.length,
                        res,
                      ),
                      _cardItem(
                        context,
                        size,
                        'Familiar words',
                        familliarIcon,
                        _familiarWords == [] || _familiarWords == null
                            ? '0 words'
                            : '${_familiarWords.length.toString()} words',
                        _familiarWords,
                        1,
                        _familiarWords.length,
                        res,
                      ),
                      _cardItem(
                        context,
                        size,
                        'Unknown words',
                        unknownIcon,
                        _unknowWords == [] || _unknowWords == null
                            ? '0 words'
                            : '${_unknowWords.length.toString()} words',
                        _unknowWords,
                        2,
                        _unknowWords.length,
                        res,
                      ),
                      _textDivder(size, res),
                      ...widget.data
                          .asMap()
                          .map(
                            (index, element) => MapEntry(
                              index,
                              _listItem(context, size, widget.data, index, res),
                            ),
                          )
                          .values
                          .toList(),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
