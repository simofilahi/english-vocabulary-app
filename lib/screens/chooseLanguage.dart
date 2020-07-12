import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/models/languages.dart';
import 'package:lenglish/screens/home.dart';
import 'package:lenglish/widgets/customButton.dart';
import 'package:lenglish/widgets/textWidget.dart';

class ChooseLanguage extends StatelessWidget {
  Widget _item(LanguagesList item) {
    return Container(
      decoration: BoxDecoration(
        color: item.isActive ? primaryBlueColor : whiteColor,
        borderRadius: BorderRadius.circular(
          10.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            item.icon,
            height: 30.0,
            width: 30.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          TextWidget(
            text: item.name,
            size: 18.0,
            color: item.isActive ? whiteColor : blackColor,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double left_right_padding = size.width * .10;
    final double top_bottom_padding = size.width * .15;

    return Scaffold(
      backgroundColor: primaryColor,
      body: OrientationBuilder(builder: (context, orientation) {
        return Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Align(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: size.height * .20,
                  ),
                  TextWidget(
                    text: 'Choose Language',
                    size: 30.0,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    height: size.height * .50,
                    width: size.width,
                    child: GridView.count(
                      padding: EdgeInsets.only(
                        left: left_right_padding,
                        right: left_right_padding,
                        top: top_bottom_padding,
                        bottom: top_bottom_padding,
                      ),
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      crossAxisCount: 2,
                      childAspectRatio: orientation == Orientation.portrait
                          ? (1.2 / 1)
                          : (2 / 1),
                      controller: new ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children:
                          languagesList.map((item) => _item(item)).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  CustomButton(
                    text: 'Continue',
                    screen: Home(),
                    navFlag: true,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
