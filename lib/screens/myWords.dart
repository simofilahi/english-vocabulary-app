import 'dart:ui';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lenglish/constants.dart';
import 'package:lenglish/logic/BoolSetter.dart';
import 'package:lenglish/widgets/textWidget.dart';
import 'package:lenglish/widgets/topAppBar.dart';
import 'package:search_widget/search_widget.dart';

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
    print("Hoooooooooo");
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
      newData = List<dynamic>.from(_unkData);
      for (int i = 0; i < newData.length; i++) {
        newData[i]['flag'] = "false";
      }
      newData[_getIndexOfSelectedWord(selectedItem)]['flag'] = "true";
      setState(() {
        _unkData = newData;
        _searchBool = true;
      });
    }
  }

  Widget _unk(
    Map item,
    var size,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: 60.0,
        width: size.width * .90,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(
            15.0,
          ),
          boxShadow: [
            (shadow(
              Theme.of(context).cardColor,
            )),
          ],
        ),
        child: _rowItems(item),
      ),
    );
  }

  Widget _rowItems(
    Map item,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 15.0,
          ),
          child: TextWidget(
            text: item['en'],
            size: 18.0,
            color: Theme.of(context).textSelectionColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextWidget(
          text: getRightTranslate(null, item, 0, widget.lang),
          size: 18.0,
          color: Theme.of(context).textSelectionColor,
          fontWeight: FontWeight.w400,
        ),
        GestureDetector(
          onTap: () {
            playLocal('audio/${item['en']}.mp3');
          },
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 15.0,
              ),
              child: SvgPicture.asset(
                speakerIcon,
                height: 25.0,
                width: 25.0,
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
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 4.0,
        bottom: 4.0,
        left: 5.0,
        right: 5.0,
      ),
      child: Container(
        height: 60.0,
        width: size.width * .90,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(
            15.0,
          ),
          boxShadow: [
            shadow(Theme.of(context).cardColor),
          ],
        ),
        child: _rowItems(item),
      ),
    );
  }

  Widget _listItem(
    Map item,
    var size,
  ) {
    if (item['isFavorite'] == "true" && _defaultIndex == 0) {
      if (_searchBool == true && item['flag'] == "true") {
        return _fav(item, size);
      } else if (_searchBool == false) {
        return _fav(item, size);
      } else
        return Container();
    } else if (item['isUnknown'] == "true" && _defaultIndex == 1) {
      if (_searchBool == true && item['flag'] == "true")
        return _unk(item, size);
      else if (_searchBool == false) {
        return _unk(item, size);
      } else
        return Container();
    } else
      return Container();
  }

  int _getIndexOfSelectedWord(String selectedWord) {
    for (int i = 0; i < _favData.length; i++) {
      if (_favData[i]['en'] == selectedWord) return i;
    }
    return 0;
  }

  Widget _myTextField(
    var size,
    var controller,
    var focusNode,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25.0,
      ),
      child: Container(
        height: 45.0,
        width: size.width * .90,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(
            15.0,
          ),
        ),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(15.0),
              ),
              borderSide: BorderSide(
                color: Color(0x4437474F),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(15.0),
              ),
              borderSide: BorderSide(
                color: primaryBlueColor,
              ),
            ),
            suffixIcon: _searchBool == false
                ? InkWell(
                    onTap: () {
                      setState(() {});
                    },
                    child: Icon(
                      Icons.search,
                      color: primaryBlueColor,
                    ),
                  )
                : InkWell(
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
                    child: Icon(Icons.cancel),
                  ),
            border: InputBorder.none,
            hintText: "Search here...",
            hintStyle: TextStyle(
              color: Theme.of(context).textSelectionColor,
            ),
            contentPadding: const EdgeInsets.only(
              left: 16,
              right: 20,
              top: 14,
              bottom: 14,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                  text: 'MyWords',
                ),
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  height: 40.0,
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
                                  size: 18.0,
                                  color: _defaultIndex == 0
                                      ? whiteColor
                                      : primaryGreyColor,
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
                                    text: 'Unknown',
                                    size: 18.0,
                                    color: _defaultIndex == 1
                                        ? whiteColor
                                        : primaryGreyColor,
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
                SizedBox(
                  height: 30.0,
                ),
                SearchWidget(
                  dataList: _defaultIndex == 0 ? _favList : _unkList,
                  popupListItemBuilder: (dynamic item) {
                    return Container(
                      padding: const EdgeInsets.all(12),
                      color: Theme.of(context).cardColor,
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Theme.of(context).textSelectionColor,
                        ),
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
                          .where((item) =>
                              item.toLowerCase().contains(query.toLowerCase()))
                          .toList();
                    return _unkList
                        .where((item) =>
                            item.toLowerCase().contains(query.toLowerCase()))
                        .toList();
                  },
                  textFieldBuilder: (controller, focusNode) {
                    return _myTextField(size, controller, focusNode);
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      bottom: 50.0,
                    ),
                    child: ListView(
                        children: _defaultIndex == 0
                            ? _favData
                                .map(
                                  (item) => _listItem(item, size),
                                )
                                .toList()
                            : _unkData
                                .map(
                                  (item) => _listItem(item, size),
                                )
                                .toList()),
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
