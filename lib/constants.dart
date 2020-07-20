import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

// Colors
const Color primaryColor = Color(0XFFEBEFF8);
const Color whiteColor = Color(0XFFFFFFFF);
const Color blackColor = Color(0XFF000000);
const Color primaryBlueColor = Color(0XFF5E81F4);
const Color primaryYellow = Color(0xFFF9A825);
const Color primaryGreyColor = Color(0xFF616161);
const linearGradiantColor =
    LinearGradient(colors: [Color(0XFF09C6F9), Color(0XFF045DE9)]);
const Color darkGreyColor = Color(0XFF808080);

// icons
const String buyIcon = 'assets/icons/buy.svg';
const String gearIcon = 'assets/icons/gear.svg';
const String rocketIcon = 'assets/icons/speed.svg';
const String backArrowIcon = 'assets/icons/arrows.svg';
const String ballonIcon = 'assets/icons/balloon.svg';
const String moreIcon = 'assets/icons/more.svg';
const String crownIcon = 'assets/icons/crown.svg';
const String hourIcon = 'assets/icons/hour.svg';
const String closeIcon = 'assets/icons/close.svg';
const String validateIcon = 'assets/icons/validate.svg';
const String speakerIcon = 'assets/icons/speaker.svg';
const String rightArrowtIcon = 'assets/icons/next.svg';
const String menuIcon = 'assets/icons/open-menu.svg';
const String languagesIcon = 'assets/icons/languages.svg';
const String sleepModesIcon = 'assets/icons/sleep-mode.svg';
const String restoreIcon = 'assets/icons/restore.svg';
const String shareIcon = 'assets/icons/share.svg';
const String heartIcon = 'assets/icons/heart.svg';
// radius

const double radiusValue = 15.0;
const double leftRightTopValue = 30.0;

// Array of colors
final List<Map<String, Color>> colors = [
  {
    "first_color": Colors.deepOrange[200],
    "second_color": Colors.deepOrange[400],
  },
  {
    "first_color": Colors.deepPurple[200],
    "second_color": Colors.deepPurple[400],
  },
  {
    "first_color": Colors.green[200],
    "second_color": Colors.green[400],
  },
  {
    "first_color": Colors.red[400],
    "second_color": Colors.red[200],
  },
  {
    "first_color": Colors.pink[400],
    "second_color": Colors.pink[200],
  },
  {
    "first_color": Colors.deepOrange[200],
    "second_color": Colors.deepOrange[400],
  },
  {
    "first_color": Colors.deepPurple[200],
    "second_color": Colors.deepPurple[400],
  },
  {
    "first_color": Colors.green[200],
    "second_color": Colors.green[400],
  },
  {
    "first_color": Colors.red[400],
    "second_color": Colors.red[200],
  },
  {
    "first_color": Colors.pink[400],
    "second_color": Colors.pink[200],
  },
  {
    "first_color": Colors.deepOrange[200],
    "second_color": Colors.deepOrange[400],
  },
  {
    "first_color": Colors.deepPurple[200],
    "second_color": Colors.deepPurple[400],
  },
  {
    "first_color": Colors.green[200],
    "second_color": Colors.green[400],
  },
  {
    "first_color": Colors.red[400],
    "second_color": Colors.red[200],
  },
  {
    "first_color": Colors.pink[400],
    "second_color": Colors.pink[200],
  },
  {
    "first_color": Colors.deepOrange[200],
    "second_color": Colors.deepOrange[400],
  },
  {
    "first_color": Colors.deepPurple[200],
    "second_color": Colors.deepPurple[400],
  },
  {
    "first_color": Colors.green[200],
    "second_color": Colors.green[400],
  },
  {
    "first_color": Colors.red[400],
    "second_color": Colors.red[200],
  },
  {
    "first_color": Colors.blue[400],
    "second_color": Colors.blue[200],
  },
  {
    "first_color": Colors.deepOrange[200],
    "second_color": Colors.deepOrange[400],
  },
  {
    "first_color": Colors.deepPurple[200],
    "second_color": Colors.deepPurple[400],
  },
  {
    "first_color": Colors.green[200],
    "second_color": Colors.green[400],
  },
  {
    "first_color": Colors.red[400],
    "second_color": Colors.red[200],
  },
  {
    "first_color": Colors.pink[400],
    "second_color": Colors.pink[200],
  },
  {
    "first_color": Colors.deepOrange[200],
    "second_color": Colors.deepOrange[400],
  },
  {
    "first_color": Colors.deepPurple[200],
    "second_color": Colors.deepPurple[400],
  },
  {
    "first_color": Colors.green[200],
    "second_color": Colors.green[400],
  },
  {
    "first_color": Colors.red[400],
    "second_color": Colors.red[200],
  },
  {
    "first_color": Colors.pink[400],
    "second_color": Colors.pink[200],
  },
  {
    "first_color": Colors.deepOrange[200],
    "second_color": Colors.deepOrange[400],
  },
  {
    "first_color": Colors.deepPurple[200],
    "second_color": Colors.deepPurple[400],
  },
  {
    "first_color": Colors.green[200],
    "second_color": Colors.green[400],
  },
  {
    "first_color": Colors.red[400],
    "second_color": Colors.red[200],
  },
  {
    "first_color": Colors.pink[400],
    "second_color": Colors.pink[200],
  },
  {
    "first_color": Colors.deepOrange[200],
    "second_color": Colors.deepOrange[400],
  },
  {
    "first_color": Colors.deepPurple[200],
    "second_color": Colors.deepPurple[400],
  },
  {
    "first_color": Colors.green[200],
    "second_color": Colors.green[400],
  },
  {
    "first_color": Colors.red[400],
    "second_color": Colors.red[200],
  },
  {
    "first_color": Colors.blue[400],
    "second_color": Colors.blue[200],
  },
  {
    "first_color": Colors.deepOrange[200],
    "second_color": Colors.deepOrange[400],
  },
  {
    "first_color": Colors.deepPurple[200],
    "second_color": Colors.deepPurple[400],
  },
  {
    "first_color": Colors.green[200],
    "second_color": Colors.green[400],
  },
  {
    "first_color": Colors.red[400],
    "second_color": Colors.red[200],
  },
  {
    "first_color": Colors.pink[400],
    "second_color": Colors.pink[200],
  },
  {
    "first_color": Colors.deepOrange[200],
    "second_color": Colors.deepOrange[400],
  },
  {
    "first_color": Colors.deepPurple[200],
    "second_color": Colors.deepPurple[400],
  },
  {
    "first_color": Colors.green[200],
    "second_color": Colors.green[400],
  },
  {
    "first_color": Colors.red[400],
    "second_color": Colors.red[200],
  },
  {
    "first_color": Colors.pink[400],
    "second_color": Colors.pink[200],
  },
  {
    "first_color": Colors.deepOrange[200],
    "second_color": Colors.deepOrange[400],
  },
  {
    "first_color": Colors.deepPurple[200],
    "second_color": Colors.deepPurple[400],
  },
  {
    "first_color": Colors.green[200],
    "second_color": Colors.green[400],
  },
  {
    "first_color": Colors.red[400],
    "second_color": Colors.red[200],
  },
  {
    "first_color": Colors.pink[400],
    "second_color": Colors.pink[200],
  },
  {
    "first_color": Colors.deepOrange[200],
    "second_color": Colors.deepOrange[400],
  },
  {
    "first_color": Colors.deepPurple[200],
    "second_color": Colors.deepPurple[400],
  },
  {
    "first_color": Colors.green[200],
    "second_color": Colors.green[400],
  },
  {
    "first_color": Colors.red[400],
    "second_color": Colors.red[200],
  },
  {
    "first_color": Colors.blue[400],
    "second_color": Colors.blue[200],
  },
];
