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
const Color greenColor = Color(0XFF03CD54);
const Color blackGrey = Color(0XFF464646);
const Color silverColor = Color(0XFFE5E5E5);
const Color goldColor = Color(0XFFFEE333);
const Color platinumColor = Color(0XFFe5e4e2);

// shadow effect
shadow(Color color) => BoxShadow(
      blurRadius: 5.0,
      spreadRadius: 1.0,
      color: Colors.grey[600].withOpacity(0.2),
      offset: Offset(3, 3),
    );

final shadow_1 = BoxShadow(
  blurRadius: 2.0,
  spreadRadius: 1.0,
  color: Colors.grey[300].withOpacity(0.8),
  offset: Offset(3, 3),
);

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
const String sleepModesIcon = 'assets/icons/night-mode.svg';
const String restoreIcon = 'assets/icons/restore.svg';
const String shareIcon = 'assets/icons/share.svg';
const String heartIcon = 'assets/icons/heart.svg';
const String rightSwitch = 'assets/icons/Right_switch.svg';
const String leftSwitch = 'assets/icons/Left_switch.svg';
const String privacyIcon = 'assets/icons/privacy.svg';
const String starIcon = 'assets/icons/star_icon.svg';
const String aboutIcon = 'assets/icons/about.svg';
const String wordsIcon = 'assets/icons/words.svg';
const String familliarIcon = 'assets/icons/familliar.svg';
const String unknownIcon = 'assets/icons/unknown.svg';
const String enterIcon = 'assets/icons/enter.svg';
const String deleteIcon = 'assets/icons/delete.svg';
const String watchIcon = 'assets/icons/watch.svg';
const String hintIcon = 'assets/icons/idea.svg';
const String forwardIcon = 'assets/icons/forward.svg';
const String keyBoardIcon = 'assets/icons/hardware.svg';
const String cubeIcon = 'assets/icons/cube.svg';
const String abcIcon = 'assets/icons/abc.svg';
const String handTapIcon = 'assets/icons/touch.svg';
const String answerIcon = 'assets/icons/faq.svg';
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

// 50 /

// [                  ]

// [][][][][][][]  []
// [][][][][][][]  []
// [][][][][][][]
// [][][][][][][]
// [][][][][][][]

// []

// []
