import 'package:flutter/Material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:lenglish/ui_elements/circleWithIcon.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/widgets/topAppBar.dart';
import 'package:snaplist/size_providers.dart';
import 'package:snaplist/snaplist_view.dart';
import '../constants.dart';

class FlashCards extends StatefulWidget {
  @override
  _FlashCardsState createState() => _FlashCardsState();
}

class _FlashCardsState extends State<FlashCards> with TickerProviderStateMixin {
  List<String> welcomeImages = [
    "assets/icons/gear.svg",
    "assets/icons/gear.svg",
    "assets/icons/gear.svg",
  ];
  var controller;

  var _index = 0;

  Widget _item(var size) {
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
              Expanded(
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        TextWidget(
                          text: 'hello',
                          size: 24.0,
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextWidget(
                          text: 'hello',
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
                child: Container(
                  child: Center(
                    child: CircleWithIcon(
                      color: primaryGreyColor,
                      iconName: gearIcon,
                      iconHeight: 60.0,
                      iconWidth: 60.0,
                    ),
                  ),
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
                          ),
                          CircleWithIcon(
                            color: Colors.blue,
                            iconName: hourIcon,
                            iconHeight: 20.0,
                            iconWidth: 10.0,
                          ),
                          CircleWithIcon(
                            color: Colors.green,
                            iconName: validateIcon,
                            iconHeight: 20.0,
                            iconWidth: 20.0,
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
                  text: '10/100',
                  color: primaryGreyColor,
                ),
                SizedBox(
                  height: 40.0,
                ),
                Container(
                  height: size.height * .70,
                  width: double.infinity,
                  child: PageView.builder(
                    itemCount: 10,
                    controller: PageController(viewportFraction: 0.7),
                    onPageChanged: (int index) =>
                        setState(() => _index = index),
                    itemBuilder: (_, i) {
                      return Transform.scale(
                        scale: i == _index ? 1 : 0.9,
                        child: _item(size),
                      );
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
