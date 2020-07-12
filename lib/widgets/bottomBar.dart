import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class BottomBar extends StatefulWidget {
  final int currentIndex;
  final Function updateIndex;

  BottomBar({this.currentIndex, this.updateIndex});
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: CurvedNavigationBar(
        initialIndex: widget.currentIndex,
        color: whiteColor,
        buttonBackgroundColor: whiteColor,
        // animationCurve: Curves.easeInOut,
        backgroundColor: primaryColor,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: primaryBlueColor,
          ),
          Icon(
            Icons.games,
            size: 30,
            color: primaryBlueColor,
          ),
          Icon(
            Icons.shopping_cart,
            size: 30,
            color: primaryBlueColor,
          ),
          Icon(
            Icons.settings,
            size: 30,
            color: primaryBlueColor,
          ),
        ],
        onTap: (index) {
          //Handle button tap
          if (widget.currentIndex != index) {
            widget.updateIndex(index);
          }
        },
      ),
    );
  }
}
