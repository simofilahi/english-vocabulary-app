import 'dart:ui';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/widgets/topAppBar.dart';
import 'package:search_widget/search_widget.dart';
import 'package:lenglish/models/responsive.dart';

class MyWords extends StatefulWidget {
  final List<dynamic> globalData;
  final String lang;
  final Function globalDataUpdate;

  MyWords({this.globalData, this.lang, this.globalDataUpdate});
  @override
  _MyWordsState createState() => _MyWordsState();
}

class _MyWordsState extends State<MyWords> {
  static AudioCache player = AudioCache();
  List<dynamic> _favList = [];
  List<dynamic> _unkList = [];
  List<dynamic> _favData = [];
  List<dynamic> _unkData = [];
  bool _searchBool = false;

  @override
  void initState() {
    super.initState();
    _getFavo();
  }

  playLocal(path) async {
    final player = AudioCache();

    // call this method when desired
    player.play(path);
  }

  int _defaultIndex = 0;

  _getFavo() {
    List<dynamic> tmp = [];
    List<dynamic> favData = [];
    List<dynamic> unkData = [];

    for (int i = 0; i < widget.globalData.length; i++) {
      tmp = widget.globalData[i]['set_${i + 1}'];
      for (int j = 0; j < tmp.length; j++) {
        if (tmp[j]['isFavorite'] == "true") {
          tmp[j]['flag'] = "false";
          favData.add(tmp[j]);
        } else if (tmp[j]['isUnknown'] == "true") {
          tmp[j]['flag'] = "false";
          unkData.add(tmp[j]);
        }
      }
    }
    setState(() {
      _favData = favData;
      _unkData = unkData;
      _favList = favData.map((e) {
        return e['en'];
      }).toList();
      _unkList = unkData.map((e) {
        return e['en'];
      }).toList();
    });
  }

  _setSearchFlagToTrue(dynamic selectedItem) {
    List<dynamic> newData = [];

    if (_defaultIndex == 0) {
      newData = List<dynamic>.from(_favData);
      for (int i = 0; i < newData.length; i++) {
        newData[i]['flag'] = "false";
      }
      newData[_getIndexOfSelectedWord(selectedItem)]['flag'] = "true";
      setState(() {
        _favData = newData;
        _searchBool = true;
      });
    } else {
      print("boboboboboobob");
      newData = List<dynamic>.from(_unkData);
      for (int i = 0; i < newData.length; i++) {
        newData[i]['flag'] = "false";
      }
      newData[_getIndexOfSelectedWord(selectedItem)]['flag'] = "true";
      print(newData);
      setState(() {
        _unkData = newData;
        _searchBool = true;
      });
    }
  }

  Widget _unk(Map item, var size, Responsive res) {
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
            (shadow(
              Theme.of(context).cardColor,
            )),
          ],
        ),
        child: _rowItems(item, res),
      ),
    );
  }

  Widget _rowItems(Map item, Responsive res) {
    print("UUUUUUUUU =>  ${res.leftPaddingSize}");
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

  Widget _fav(
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
        child: _rowItems(item, res),
      ),
    );
  }

  Widget _listItem(Map item, var size, Responsive res) {
    if (item['isFavorite'] == "true" && _defaultIndex == 0) {
      if (_searchBool == true && item['flag'] == "true") {
        return _fav(item, size, res);
      } else if (_searchBool == false) {
        return _fav(item, size, res);
      } else
        return Container();
    } else if (item['isUnknown'] == "true" && _defaultIndex == 1) {
      if (_searchBool == true && item['flag'] == "true")
        return _unk(item, size, res);
      else if (_searchBool == false) {
        return _unk(item, size, res);
      } else
        return Container();
    } else
      return Container();
  }

  int _getIndexOfSelectedWord(String selectedWord) {
    if (_defaultIndex == 0) {
      for (int i = 0; i < _favData.length; i++) {
        if (_favData[i]['en'] == selectedWord) return i;
      }
    } else {
      for (int i = 0; i < _unkData.length; i++) {
        if (_unkData[i]['en'] == selectedWord) return i;
      }
    }

    return 0;
  }

  Widget _myTextField(var size, var controller, var focusNode, Responsive res) {
    var height_2 = size.height * 0.07;
    return Padding(
      padding: EdgeInsets.only(
        left: res.leftPaddingSize,
        right: res.rightPaddingSize,
      ),
      child: Container(
        height: height_2,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(
            res.borderRadiusSize * 0.8,
          ),
        ),
        child: Center(
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            style: TextStyle(
              fontSize: res.textSize,
              color: Colors.grey[600],
            ),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    res.borderRadiusSize * 0.6,
                  ),
                ),
                borderSide: BorderSide(
                  color: Color(0x4437474F),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    res.borderRadiusSize * 0.6,
                  ),
                ),
                borderSide: BorderSide(
                  color: primaryBlueColor,
                ),
              ),
              suffixIcon: _searchBool == false
                  ? Padding(
                      padding: EdgeInsets.only(
                        right: res.rightPaddingSize * 0.6,
                      ),
                      child: InkWell(
                        onTap: () {
                          // setState(() {});
                        },
                        child: Icon(
                          Icons.search,
                          size: res.iconSize * 1.2,
                          color: primaryBlueColor,
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                        right: res.rightPaddingSize * 0.6,
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _searchBool = false;
                            _favData = _favData.map((e) {
                              e['flag'] = "false";
                              return e;
                            }).toList();
                            _unkData = _unkData.map((e) {
                              e['flag'] = "false";
                              return e;
                            }).toList();
                          });
                        },
                        child: Icon(
                          Icons.cancel,
                          size: res.iconSize * 1.2,
                          color: primaryBlueColor,
                        ),
                      ),
                    ),
              border: InputBorder.none,
              hintText: "Search here...",
              hintStyle: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontSize: res.textSize * 0.8,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _searchBar(var size, Responsive res) {
    return SearchWidget(
      dataList: _defaultIndex == 0 ? _favList : _unkList,
      popupListItemBuilder: (dynamic item) {
        return Container(
          padding: EdgeInsets.only(
            left: res.leftPaddingSize * 2,
          ),
          height: size.height * 0.06,
          width: size.width,
          color: Theme.of(context).cardColor,
          child: Row(
            children: <Widget>[
              Text(
                item,
                style: TextStyle(
                  fontSize: res.textSize,
                  color: Theme.of(context).textSelectionColor,
                ),
              ),
            ],
          ),
        );
      },
      onItemSelected: (dynamic selectedItem) {
        _setSearchFlagToTrue(selectedItem);
      },
      selectedItemBuilder: (selectedItem, deleteSelectedItem) {
        return Container();
      },
      queryBuilder: (query, list) {
        if (_defaultIndex == 0)
          return _favList
              .where((item) => item.toLowerCase().contains(query.toLowerCase()))
              .toList();
        return _unkList
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      },
      textFieldBuilder: (controller, focusNode) {
        return _myTextField(
          size,
          controller,
          focusNode,
          res,
        );
      },
    );
  }

  Widget _switcher(var size, Responsive res) {
    return Container(
      height: res.containerHeightSize,
      width: size.width * .70,
      decoration: BoxDecoration(
        color: primaryColor,
        border: Border.all(
          color: Theme.of(context).cardColor,
          width: 1.0,
        ),
        boxShadow: [
          shadow(Theme.of(context).cardColor),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _defaultIndex = 0;
                  _searchBool = false;
                });
              },
              child: Container(
                color: _defaultIndex == 0
                    ? primaryBlueColor
                    : Theme.of(context).cardColor,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextWidget(
                      text: 'Favorites',
                      size: res.textSize,
                      color: _defaultIndex == 0 ? whiteColor : primaryGreyColor,
                    ),
                  ],
                )),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _defaultIndex = 1;
                  _searchBool = false;
                });
              },
              child: Container(
                color: _defaultIndex == 1
                    ? primaryBlueColor
                    : Theme.of(context).cardColor,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextWidget(
                        text: 'Unknowns',
                        size: res.textSize,
                        color:
                            _defaultIndex == 1 ? whiteColor : primaryGreyColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listBuilder(var size, Responsive res) {
    return Expanded(
      child: ListView(
          children: _defaultIndex == 0
              ? _favData
                  .map(
                    (item) => _listItem(item, size, res),
                  )
                  .toList()
              : _unkData
                  .map(
                    (item) => _listItem(item, size, res),
                  )
                  .toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Responsive res = Responsive(
      containerHeightSize: size.height * 0.054,
      sizedBoxHeightSize: size.height * 0.028,
      horizontalPaddingSize: size.width * 0.06,
      verticalPaddingSize: size.height * 0.0055,
      textSize: size.width * 0.05,
      borderRadiusSize: size.width * 0.0469,
      bottomPaddingSize: size.height * 0.0055,
      topPaddingSize: size.height * 0.0055,
      rightPaddingSize: size.width * 0.0085,
      iconSize: size.height * 0.032,
      leftPaddingSize: size.width * 0.0085,
    );
    if (!_searchBool) FocusScope.of(context).requestFocus(new FocusNode());
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        height: size.height,
        width: size.width,
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Column(
              children: <Widget>[
                TopAppBar(
                  text: 'My words',
                ),
                SizedBox(
                  height: res.sizedBoxHeightSize,
                ),
                _switcher(size, res),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: res.horizontalPaddingSize,
                      vertical: res.verticalPaddingSize,
                    ),
                    child: Column(
                      children: <Widget>[
                        _searchBar(size, res),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        _listBuilder(size, res),
                      ],
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
