import 'package:flutter/material.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/widgets/shopCard.dart';
import 'package:lenglish/widgets/topAppBar.dart';

class BuyPremium extends StatefulWidget {
  BuyPremium({Key key}) : super(key: key);

  @override
  _BuyPremiumState createState() => _BuyPremiumState();
}

class _BuyPremiumState extends State<BuyPremium> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: primaryColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TopAppBar(
              icon_1: null,
              icon_2: null,
              text: 'Upgrade',
              textSize: 18.9,
              color: blackColor,
              fontWeight: FontWeight.bold,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ShopCard(),
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
