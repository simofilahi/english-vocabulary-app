import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/widgets/topAppBar.dart';

class MyWords extends StatefulWidget {
  final List<dynamic> globalData;
  final String lang;
  MyWords({this.globalData, this.lang});

  @override
  _MyWordsState createState() => _MyWordsState();
}

class _MyWordsState extends State<MyWords> {
  static AudioCache player = AudioCache();

  @override
  void initState() {
    super.initState();
    print(widget.lang);
  }

  playLocal(path) async {
    final player = AudioCache();

    // call this method when desired
    player.play(path);
  }

  int _defaultIndex = 0;

  Widget _listItem(var size, Map item) {
    if (item['isFavorite'] == "true" && _defaultIndex == 0) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          height: 60.0,
          width: size.width * .90,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(
              15.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: TextWidget(
                    text: item['en'],
                    size: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextWidget(
                  text: getRightTranslate(null, item, 0, widget.lang),
                  size: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    playLocal('audio/${item['en']}.mp3');
                  },
                  child: SvgPicture.asset(
                    speakerIcon,
                    height: 25.0,
                    width: 25.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (item['isUnknown'] == "true" && _defaultIndex == 1) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          height: 60.0,
          width: size.width * .90,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(
              15.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: TextWidget(
                    text: item['en'],
                    size: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextWidget(
                  text: getRightTranslate(null, item, 0, widget.lang),
                  size: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    playLocal('audio/${item['en']}.mp3');
                  },
                  child: SvgPicture.asset(
                    speakerIcon,
                    height: 25.0,
                    width: 25.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else
      return Container();
  }

  List<Widget> _wordList(var size) {
    int i = 0;
    List<Widget> widgets = [Container(), Container()];

    widget.globalData.forEach((item) {
      item['set_${i + 1}'].forEach((f) {
        widgets.add(_listItem(size, f));
      });
      i++;
    });
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        height: size.height,
        width: size.width,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              TopAppBar(
                text: 'MyWords',
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                height: 40.0,
                width: size.width * .70,
                decoration: BoxDecoration(
                  color: primaryColor,
                  border: Border.all(
                    color: whiteColor,
                    width: 1.0,
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _defaultIndex = 0;
                          });
                        },
                        child: Container(
                          color: _defaultIndex == 0
                              ? primaryBlueColor
                              : whiteColor,
                          child: Center(
                            child: TextWidget(
                              text: 'Favorites',
                              size: 18.0,
                              color: _defaultIndex == 0
                                  ? whiteColor
                                  : primaryGreyColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _defaultIndex = 1;
                          });
                        },
                        child: Container(
                          color: _defaultIndex == 1
                              ? primaryBlueColor
                              : whiteColor,
                          child: Center(
                            child: TextWidget(
                              text: 'Unknown',
                              size: 18.0,
                              color: _defaultIndex == 1
                                  ? whiteColor
                                  : primaryGreyColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 50.0,
                  ),
                  child: ListView(
                    children: _wordList(size),
                    // children: <Widget>[
                    //   ...widget.globalData
                    //       .asMap()
                    //       .map(
                    //         (index, element) => MapEntry(
                    //           index,
                    //           _listItem(size, widget.globalData, index),
                    //         ),
                    //       )
                    //       .values
                    //       .toList(),
                    // ],
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
