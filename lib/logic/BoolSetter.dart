import 'initalizeFiles.dart';
import 'package:Steria/models/data.dart';

Future<void> updateSelectedLanguage(String selectedLang) async {
  String lang;
  var wordsInfo = [{}];
  if (selectedLang == null) lang = 'en';
  if (selectedLang == 'French') {
    lang = 'fr';
  } else if (selectedLang == 'Spanich') {
    lang = 'sp';
  } else if (selectedLang == 'Arabic') {
    lang = 'ar';
  } else if (selectedLang == 'Chinese') {
    lang = 'ch';
  } else if (selectedLang == 'Italian') {
    lang = 'it';
  } else if (selectedLang == 'Hindi') {
    lang = 'hi';
  } else if (selectedLang == 'Urdu') {
    lang = 'ur';
  } else if (selectedLang == 'Filipino') {
    lang = 'fi';
  } else if (selectedLang == 'German') {
    lang = 'ge';
  } else if (selectedLang == 'Russian') {
    lang = 'ru';
  } else if (selectedLang == 'Turkish') {
    lang = 'tu';
  } else if (selectedLang == 'Bengali') {
    lang = 'be';
  } else if (selectedLang == 'Japanese') {
    lang = 'ja';
  } else if (selectedLang == 'Portuguese') {
    lang = 'po';
  } else if (selectedLang == 'Korean') {
    lang = 'ko';
  }
  wordsInfo[0]['selected_lang'] = lang;
  saveChosenLang(wordsInfo);
  return;
}

Future<bool> saveChosenLang(langData) async {
  bool ret = await langFile.setItem('Lang', langData);
  if (ret == true)
    return true;
  else
    return false;
}

Future<bool> getDarkModeStatus() async {
  dynamic ret = await darkMode.getItem();
  if (ret == null) return false;
  if (ret[0]['darkMode'] == 'false') return false;
  return true;
}

Future<bool> setDarkModeStatus(bool status) async {
  dynamic ret = await darkMode.setItem(
    'DarkMode',
    [
      {
        "darkMode": status.toString(),
      }
    ],
  );
  if (!ret) return false;
  return true;
}

String getRightTranslateHelper(String lang, Map item) {
  if (lang == 'sp') {
    return item['sp'];
  } else if (lang == 'fr') {
    return item['fr'];
  } else if (lang == 'ar') {
    return item['ar'];
  } else if (lang == 'ch') {
    return item['ch'];
  } else if (lang == 'hi') {
    return item['hi'];
  } else if (lang == 'ur') {
    return item['ur'];
  } else if (lang == 'fi') {
    return item['fi'];
  } else if (lang == 'ge') {
    return item['ge'];
  } else if (lang == 'ru') {
    return item['ru'];
  } else if (lang == 'tu') {
    return item['tu'];
  } else if (lang == 'be') {
    return item['be'];
  } else if (lang == 'ja') {
    return item['ja'];
  } else if (lang == 'pr') {
    return item['pr'];
  } else if (lang == 'ko') {
    return item['ko'];
  } else if (lang == 'it') {
    return item['it'];
  }
  return item['en'];
}

String getRightTranslate(List data, Map item, int index, lang) {
  if (data == null) {
    return getRightTranslateHelper(lang, item);
  } else {
    return getRightTranslateHelper(lang, data[index]);
  }
}

String getNameOfLang(String lang) {
  if (lang == 'ar') {
    return 'Arabic';
  } else if (lang == 'fr') {
    return 'French';
  } else if (lang == 'sp') {
    return 'Spanich';
  } else if (lang == 'ch') {
    return 'Chinese';
  } else if (lang == 'hi') {
    return 'Hindi';
  } else if (lang == 'ur') {
    return "Urdu";
  } else if (lang == 'fi') {
    return "Filipino";
  } else if (lang == 'ge') {
    return "German";
  } else if (lang == 'ru') {
    return "Russian";
  } else if (lang == 'tu') {
    return "Turkish";
  } else if (lang == 'be') {
    return "Bengali";
  } else if (lang == 'ja') {
    return "Japanese";
  } else if (lang == 'pr') {
    return "Portuguese";
  } else if (lang == 'ko') {
    return "Korea";
  } else if (lang == 'it') {
    return "Italian";
  }
  return 'English';
}

Future<dynamic> getGlobalData() async {
  List<dynamic> data = await allData.getItem();
  if (data == null) {
    return null;
  }
  return data;
}

Future<bool> creationOfFiles() async {
  try {
    var value;
    value = await langFile.createFile();
    if (value == true)
      allData.setItem('data', words);
    else
      return false;
    value = await indexFile.createFile();
    if (value == true)
      indexFile.setItem('index', [
        {"index": "0"}
      ]);
    else
      return false;
    value = await indexFile_2.createFile();
    if (value == true)
      indexFile_2.setItem('index', [
        {"index": "0"}
      ]);
    else
      return false;
    value = await hintPointsFile.createFile();
    if (value == true)
      hintPointsFile.setItem('points', [
        {"points": "3"}
      ]);
    else
      return false;
    value = await answerPointsFile.createFile();
    if (value == true)
      answerPointsFile.setItem('points', [
        {"points": "3"}
      ]);
    else
      return false;
    value = await langFile.createFile();
    if (value == true)
      langFile.setItem('Lang', [
        {"selected_lang": "en"}
      ]);
    else
      return false;
    value = await nextSetIndex.createFile();
    if (value == true)
      nextSetIndex.setItem('nextSetIndex', [
        {"nextSetIndex": "0"}
      ]);
    else
      return false;
    value = await darkMode.createFile();
    if (value == true)
      darkMode.setItem(
        'DarkMode',
        [
          {"darkMode": "false"}
        ],
      );
    else
      return false;
    return true;
  } catch (onError) {
    return false;
  }
}

Future<bool> updateGlobalData(List<dynamic> globalData, int objIndex,
    int wordObjIndex, String word, List<dynamic> newData) async {
  globalData[objIndex]['set_${objIndex + 1}'] = newData;
  allData.setItem('words', globalData);
  return true;
}

Future<bool> setTrue(int objIndex, int wordObjIndex, String word,
    List<dynamic> localData, List<dynamic> globalData, int flag) async {
  try {
    if (flag == 1 || flag == 0) {
      int number = int.parse(globalData[objIndex]['learning_words']);
      if (number < 50) {
        number += 1;
        globalData[objIndex]['learning_words'] = number.toString();
      }
    }
    for (int i = 0; i < localData.length; i++) {
      if (localData[i]['en'] == word) {
        if (flag == 0) {
          localData[i]['isFavorite'] = "true";
          localData[i]['isFamiliar'] = "false";
          localData[i]['isUnknown'] = "false";
        } else if (flag == 1) {
          localData[i]['isExcellent'] = "true";
          localData[i]['isFamiliar'] = "false";
          localData[i]['isFavorite'] = "false";
          localData[i]['isUnknown'] = "false";
        } else if (flag == 2) {
          localData[i]['isFamiliar'] = "true";
          localData[i]['isFavorite'] = "false";
          localData[i]['isUnknown'] = "false";
        } else if (flag == 3) {
          localData[i]['isUnknown'] = "true";
          localData[i]['isFavorite'] = "false";
          localData[i]['isFamiliar'] = "false";
        }
      }
    }
    bool res = await updateGlobalData(
        globalData, objIndex, wordObjIndex, word, localData);
    if (res) return true;
    return false;
  } catch (onError) {
    return false;
  }
}

List<dynamic> getWords(List<dynamic> item) {
  List<dynamic> newData = [];
  item.forEach((f) {
    if (f['isFavorite'] == "false" &&
        f['isUnknown'] == "false" &&
        f['isFamiliar'] == "false" &&
        f['isExcellent'] == "false") {
      newData.add(f);
    }
  });
  return newData;
}

List<dynamic> getFamiliarWord(List<dynamic> item) {
  List<dynamic> newData = [];
  item.forEach((f) {
    if (f['isFamiliar'] == "true" && f['isFavorite'] == "false") {
      newData.add(f);
    }
  });
  return newData;
}

List<dynamic> getUnknownWord(List<dynamic> item) {
  List<dynamic> newData = [];
  item.forEach((f) {
    if (f['isUnknown'] == "true" && f['isFavorite'] == "false") {
      newData.add(f);
    }
  });
  return newData;
}

createFavoriteFile(List<Map> initialData) {
  allData.setItem('Favorite', initialData);
}

createUnknownFile(List<Map> initialData) {
  allData.setItem('Favorite', initialData);
}

int totoalLearningWords(List<dynamic> globalData) {
  int count = 0;
  for (int i = 0; i < globalData.length; i++) {
    count += int.parse(globalData[i]['learning_words']);
  }
  return count;
}

Future<int> updateIndexOfFlyingSquare(int index) async {
  List<Map> newData = [
    {'index': index.toString()}
  ];
  indexFile.setItem('Index', newData).then((value) {
    if (value == true) {
      return index;
    } else
      return 0;
  });
  return 0;
}

Future<int> updateIndexOfSpellingWords(int index) async {
  List<Map> newData = [
    {'index': index.toString()}
  ];
  indexFile_2.setItem('Index', newData).then((value) {
    if (value == true) {
      return index;
    } else
      return 0;
  });
  return 0;
}

addingAnswerPoints(int points) {
  List<Map> newData = [];
  int number = 0;
  answerPointsFile.getItem().then((value) {
    number = int.parse(value[0]['points']) + points;

    newData = [
      {
        'points': number.toString(),
      }
    ];
    answerPointsFile.setItem('points', newData);
  });
}

addinghintPoints(int points) {
  List<Map> newData = [];
  int number = 0;
  hintPointsFile.getItem().then((value) {
    number = int.parse(value[0]['points']) + points;
    newData = [
      {
        'points': number.toString(),
      }
    ];
    hintPointsFile.setItem('Index', newData);
  });
}

Future<bool> resetItemHomeWidget(
    List<dynamic> globalData, List<dynamic> data, int index) async {
  for (int j = 0; j < data.length; j++) {
    data[j]['isFavorite'] = "false";
    data[j]['isExcellent'] = "false";
    data[j]['isFamiliar'] = "false";
    data[j]['isUnknown'] = "false";
  }
  for (int i = 0; i < globalData.length; i++) {
    if (i == index) {
      globalData[i]['learning_words'] = "0";
      globalData[i]['Favorite'] = "0";
      globalData[i]['Excellent'] = "0";
      globalData[i]['Familiar'] = "0";
      globalData[i]['set_${index + 1}'] = data;
    }
  }
  bool ret = await allData.setItem('words', globalData);
  if (ret) return true;
  return false;
}

List<dynamic> _newData(List<dynamic> data) {
  for (int i = 0; i < data.length; i++) {
    data[i]['isFavorite'] = "false";
    data[i]['isExcellent'] = "false";
    data[i]['isFamiliar'] = "false";
    data[i]['isUnknown'] = "false";
  }
  return data;
}

Future<bool> resetAll() async {
  dynamic value = await allData.getItem();
  if (value != null) {
    for (int i = 0; i < value.length; i++) {
      value[i]['learning_words'] = "0";
      value[i]['Favorite'] = "0";
      value[i]['Excellent'] = "0";
      value[i]['Familiar'] = "0";
      value[i]['Unknown'] = "0";
      value[i]['set_${i + 1}'] = _newData(value[i]['set_${i + 1}']);
    }
    dynamic ret = await allData.setItem('AllData', value);
    if (ret) {
      return true;
    } else
      return false;
  }
  return false;
}

Future<int> getIndexOfSqaureFlying() async {
  return indexFile.getItem().then((value) {
    if (value != null) {
      return int.parse(value[0]['index']);
    } else
      return 0;
  }).catchError((onError) {
    return 0;
  });
}

Future<int> getIndexOfSpellingWords() async {
  return indexFile_2.getItem().then((value) {
    if (value != null) {
      return int.parse(value[0]['index']);
    } else
      return 0;
  }).catchError((onError) {
    return 0;
  });
}

Future<int> getAnswerPoints() async {
  return answerPointsFile.getItem().then((onValue) {
    if (onValue != null) {
      return int.parse(onValue[0]['points']);
    } else
      return 0;
  }).catchError((onError) {
    return 0;
  });
}

Future<int> getHintPoints() async {
  return hintPointsFile.getItem().then((onValue) {
    if (onValue != null) {
      return int.parse(onValue[0]['points']);
    } else
      return 0;
  }).catchError((onError) {
    return 0;
  });
}

// works perfect;
Future<Map<dynamic, dynamic>> searchForWordByIndex(
    List<dynamic> globalData, int index, String lang) async {
  int j = 0;
  Map<dynamic, dynamic> data = {};
  List<dynamic> tmp = [];

  for (int i = 0; i < globalData.length; i++) {
    tmp = globalData[i]['set_${i + 1}'];
    for (int f = 0; f < tmp.length; f++) {
      if (j == index) {
        data['enWord'] = tmp[f]['en'];
        data['translatedWord'] = getRightTranslate(null, tmp[f], 0, lang);
      }
      j++;
    }
  }
  return data;
}

resetFlyingSquaresGame() {
  indexFile.setItem('index', [
    {"index": "0"}
  ]);
}

resetSpellingGame() {
  indexFile_2.setItem('index', [
    {"index": "0"}
  ]);
}

Future<bool> substractAnswerPoints(int point) async {
  int number = await getAnswerPoints();

  if (number < point) {
    return false;
  } else {
    int total = number - point;
    bool ret = await answerPointsFile.setItem('points', [
      {"points": total.toString()}
    ]);
    if (ret) {
      return true;
    }
  }
  return false;
}

Future<bool> substractHintPoints(int point) async {
  int number = await getHintPoints();

  if (number < point) {
    return false;
  } else {
    int total = number - point;
    bool ret = await hintPointsFile.setItem('points', [
      {"points": total.toString()}
    ]);
    if (ret) {
      return true;
    }
  }
  return false;
}

Future<int> searchForSetByIndex(int index, List<dynamic> globalData) async {
  int j = 0;
  List<dynamic> tmp = [];

  for (int i = 0; i < globalData.length; i++) {
    tmp = globalData[i]['set_${i + 1}'];
    for (int f = 0; f < tmp.length; f++) {
      if (j == index) {
        return i + 1;
      }
      j++;
    }
  }
  return 1;
}
