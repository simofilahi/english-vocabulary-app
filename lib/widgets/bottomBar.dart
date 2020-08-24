import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:Steria/models/responsive.dart';
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
          ),
          Icon(
            Icons.games,
            size: res.iconSize,
            color: primaryBlueColor,
          ),
          Icon(
            Icons.menu,
            size: res.iconSize,
            color: primaryBlueColor,
          ),
          Icon(
            Icons.settings,
            size: res.iconSize,
            color: primaryBlueColor,
          ),
        ],
        onTap: (index) {
          if (widget.currentIndex != index) {
            widget.updateIndex(index);
          }
        },
      ),
    );
  }
}
