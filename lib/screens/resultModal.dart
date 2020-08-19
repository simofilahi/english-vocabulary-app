import 'package:flutter/material.dart';
import 'package:lenglish/models/responsive.dart';
import 'package:lenglish/widgets/linearProgress.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:lenglish/widgets/topAppBar.dart';
import '../constants.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lenglish/widgets/customButton.dart';

class ResultModal extends StatefulWidget {
  final List<dynamic> data;
  final String lang;
  final Function dismiss;
  final Function dismssAllAds;
  ResultModal({this.data, this.lang, this.dismiss, this.dismssAllAds});

  @override
  _ResultModalState createState() => _ResultModalState();
}

class _ResultModalState extends State<ResultModal> {
  int _unknownWordsCount() {
    int count = 0;
    for (int i = 0; i < widget.data.length; i++) {
      if (widget.data[i]['isUnknown'] == "true") count++;
    }
    return count;
  }

  int _excellentWordsCount() {
    int count = 0;
    for (int i = 0; i < widget.data.length; i++) {
      if (widget.data[i]['isExcellent'] == "true") count++;
    }
    return count;
  }

  int _familiarWordsCount() {
    int count = 0;
    for (int i = 0; i < widget.data.length; i++) {
      if (widget.data[i]['isFamiliar'] == "true") count++;
    }
    return count;
  }

  playLocal(path) async {
    final player = AudioCache();

    // call this method when desired
    player.play(path);
  }

  Widget _listItems(
    BuildContext context,
    Map item,
    var size,
    Responsive res,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        top: res.topPaddingSize,
        bottom: res.bottomPaddingSize,
        left: res.leftPaddingSize,
        right: res.rightPaddingSize,
      ),
      child: Container(
        height: size.height * .08,
        width: size.width * .90,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(
            res.borderRadiusSize,
          ),
          boxShadow: [
            shadow(Theme.of(context).cardColor),
          ],
        ),
        child: _rowItems(context, item, res),
      ),
    );
  }

  Widget _rowItems(BuildContext context, Map item, Responsive res) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.only(
              left: res.leftPaddingSize * 4,
            ),
            child: Text(
              item['en'],
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
            getRightTranslate(null, item, 0, widget.lang),
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
              playLocal('audio/${item['en']}.mp3');
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
        ),
      ],
    );
  }

  Widget _listOfWords(BuildContext context, var size, Responsive res) {
    return ListView(
        children: widget.data
            .map(
              (item) => _listItems(context, item, size, res),
            )
            .toList());
  }

  Widget _item(
      BuildContext context, var size, Responsive res, String text, int number) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.only(
              top: res.topPaddingSize * 4,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextWidget(
                  text: number.toString(),
                  size: res.textSize * 1.5,
                  color: Theme.of(context).textSelectionColor,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: res.sizedBoxHeightSize * 0.5,
                ),
                TextWidget(
                  text: text,
                  color: Theme.of(context).indicatorColor,
                  size: res.textSize * 0.8,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: LinearProgress(value: number),
          ),
        )
      ],
    );
  }

  Widget _progress(BuildContext context, var size, Responsive res) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: res.verticalPaddingSize * 2.5,
              bottom: res.verticalPaddingSize * 2.5,
              right: res.leftPaddingSize,
              left: res.leftPaddingSize,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(
                  res.borderRadiusSize * 0.5,
                ),
                boxShadow: [
                  shadow(
                    Theme.of(context).cardColor,
                  ),
                ],
              ),
              child: _item(
                  context, size, res, 'Excellent', _excellentWordsCount()),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: res.verticalPaddingSize * 2.5,
              bottom: res.verticalPaddingSize * 2.5,
              right: res.leftPaddingSize,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(
                  res.borderRadiusSize * 0.5,
                ),
                boxShadow: [
                  shadow(
                    Theme.of(context).cardColor,
                  ),
                ],
              ),
              child:
                  _item(context, size, res, 'Familiar', _familiarWordsCount()),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: res.verticalPaddingSize * 2.5,
              bottom: res.verticalPaddingSize * 2.5,
              right: res.leftPaddingSize,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(
                  res.borderRadiusSize * 0.5,
                ),
                boxShadow: [
                  shadow(
                    Theme.of(context).cardColor,
                  ),
                ],
              ),
              child: _item(context, size, res, 'Unknown', _unknownWordsCount()),
            ),
          ),
        ),
      ],
    );
  }

  _handleBack() {
    widget.dismssAllAds();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
      buttonHeightSize: size.height * 0.06,
      buttonWidthSize: size.width * 0.4,
    );
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        height: size.height,
        width: size.width,
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                TopAppBar(
                  icon_2: closeIcon,
                  text: 'Result',
                  color: primaryGreyColor,
                  icon_2_flag: 3,
                  clickHandler: _handleBack,
                ),
                SizedBox(
                  height: res.sizedBoxHeightSize,
                ),
                Container(
                  height: res.sizedBoxHeightSize,
                  width: res.containerWidthSize,
                  child: Padding(
                    padding: EdgeInsets.only(left: res.leftPaddingSize * 2.5),
                    child: Row(
                      children: <Widget>[
                        TextWidget(
                          text: 'Learning words',
                          color: Theme.of(context).textSelectionColor,
                          size: res.textSize * 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: res.sizedBoxHeightSize * 0.5,
                ),
                Container(
                  height: size.height * .36,
                  width: res.containerWidthSize,
                  child: _listOfWords(context, size, res),
                ),
                SizedBox(
                  height: res.sizedBoxHeightSize * 0.5,
                ),
                Container(
                  height: res.sizedBoxHeightSize,
                  width: res.containerWidthSize,
                  child: Padding(
                    padding: EdgeInsets.only(left: res.leftPaddingSize * 2.5),
                    child: Row(
                      children: <Widget>[
                        TextWidget(
                          text: 'Info',
                          color: Theme.of(context).textSelectionColor,
                          size: res.textSize * 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: res.sizedBoxHeightSize * 0.08,
                ),
                Container(
                  height: size.height * .30,
                  width: res.containerWidthSize,
                  child: _progress(context, size, res),
                ),
                Container(
                  height: size.height * .12,
                  child: Center(
                    child: CustomButton(
                      text: 'Continue',
                      textSize: res.textSize,
                      buttonHeightSize: size.height * 0.08,
                      buttonWidthSize: res.containerWidthSize,
                      res: res,
                      clickHandler: widget.dismiss,
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
}
