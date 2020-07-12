import 'package:flutter/material.dart';
import 'package:lenglish/screens/wordsList.dart';
import 'package:lenglish/ui_elements/infoConatiner.dart';
import 'package:lenglish/widgets/radialProgress.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/widgets/topAppBar.dart';

import '../constants.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key key}) : super(key: key);

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RadialProgress(
                height: 120,
                width: 120,
                color: whiteColor,
                flag: true,
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[300].withOpacity(
                  0.6,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(leftRightTopValue),
                  topRight: Radius.circular(leftRightTopValue),
                ),
              ),
              child: Center(),
            ),
          )
        ],
      ),
    );
  }

  Widget _item(Color firstColor, Color secondColor, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext ctx) => WordsList(),
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
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 80.0,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RadialProgress(
                      height: 50,
                      width: 50,
                      color: whiteColor,
                      flag: false,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: InfoContainer(
                  firstColor: firstColor,
                  secondColor: secondColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
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
      children: <Widget>[
        _item(Colors.blue[400], Colors.blue[200], context),
        _item(Colors.deepOrange[400], Colors.deepOrange[200], context),
        _item(Colors.deepPurple[400], Colors.deepPurple[200], context),
        _item(Colors.green[400], Colors.green[200], context),
        _item(Colors.red[400], Colors.red[200], context),
        _item(Colors.pink[400], Colors.pink[200], context),
      ],
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
              textSize: 18,
            ),
            SizedBox(
              height: 20.0,
            ),
            _progressCard(size),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: _gridList(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
