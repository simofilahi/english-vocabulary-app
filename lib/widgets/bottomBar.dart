import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lenglish/models/responsive.dart';
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
    var size = MediaQuery.of(context).size;

    Responsive res = Responsive(
      containerHeightSize: size.height * 0.07,
      iconSize: size.height * 0.04,
    );
    print("fofofo ==> ${res.iconSize}");
    return Container(
      height: res.containerHeightSize,
      child: CurvedNavigationBar(
        initialIndex: widget.currentIndex,
        color: Theme.of(context).cardColor,
        buttonBackgroundColor: Theme.of(context).cardColor,
        backgroundColor: Theme.of(context).backgroundColor,
        items: <Widget>[
          Icon(
            Icons.home,
            size: res.iconSize,
            color: primaryBlueColor,
            // widget.currentIndex == 0 ? primaryBlueColor : primaryGreyColor,
          ),
          Icon(
            Icons.games, size: res.iconSize, color: primaryBlueColor,
            // widget.currentIndex == 1 ? primaryBlueColor : primaryGreyColor,
          ),
          Icon(
            Icons.menu, size: res.iconSize, color: primaryBlueColor,
            // widget.currentIndex == 2 ? primaryBlueColor : primaryGreyColor,
          ),
          Icon(
            Icons.settings, size: res.iconSize, color: primaryBlueColor,
            // widget.currentIndex == 3 ? primaryBlueColor : primaryGreyColor,
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
