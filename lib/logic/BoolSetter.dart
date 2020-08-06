import 'initalizeFiles.dart';

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
  langFile.setItem('Lang', langData).then((v) {
    if (v == true)
      return true;
    else
      return false;
  });
}

Future<bool> verfieLangFile() async {
  // if (allData.getItem('Lang') == null) {
  //   return false;
  // }
  return true;
}

String getTheSelectedLang() {}

String getRightTranslate(List data, Map item, int index, lang) {
  print("ttttttttttt");
  print(lang);
  if (data == null) {
    if (lang == 'sp') {
      return item['sp'];
    } else if (lang == 'fr') {
      return item['fr'];
    } else if (lang == 'ar') {
      return item['ar'];
    } else if (lang == 'ch') {
      return item['ch'];
    }
  } else {
    if (lang == 'sp') {
      return data[index]['sp'];
    } else if (lang == 'fr') {
      return data[index]['fr'];
    } else if (lang == 'ar') {
      return data[index]['ar'];
    } else if (lang == 'ch') {
      return data[index]['ch'];
    } else if (lang == 'hi') {
      return data[index]['hi'];
    } else if (lang == 'ur') {
      return data[index]['ur'];
    } else if (lang == 'fi') {
      return data[index]['fi'];
    } else if (lang == 'ge') {
      return data[index]['ge'];
    } else if (lang == 'ru') {
      return data[index]['ru'];
    } else if (lang == 'tu') {
      return data[index]['tu'];
    } else if (lang == 'be') {
      return data[index]['be'];
    } else if (lang == 'ja') {
      return data[index]['ja'];
    } else if (lang == 'pr') {
      return data[index]['pr'];
    } else if (lang == 'ko') {
      return data[index]['ko'];
    } else if (lang == 'it') {
      return data[index]['it'];
    }
  }
  return data[index]['en'];
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
  // List<dynamic> data = allData.getItem('words');
  // if (data == null) {
  //   return null;
  // }
  // return data;
}

Future<dynamic> storeGlobalData() async {
  // allData.setItem('words', words);
  // List<dynamic> data = allData.getItem('words');
  // if (data == null) {
  //   return null;
  // }
  // return data;
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
    List<dynamic> newData = localData.map((f) {
      if (f['en'] == word) {
        if (flag == 0) {
          if (f['isFavorite'] == "true")
            f['isFavorite'] = "false";
          else
            f['isFavorite'] = "true";
        } else if (flag == 1) {
          f['isExcellent'] = "true";
          f['isFamiliar'] = "false";
          f['isFavorite'] = "false";
          f['isUnknown'] = "false";
        } else if (flag == 2) {
          f['isFamiliar'] = "true";
          f['isFavorite'] = "false";
          f['isUnknown'] = "false";
        } else if (flag == 3) {
          f['isUnknown'] = "true";
          f['isFavorite'] = "false";
          f['isFamiliar'] = "false";
        }
      }
      return f;
    }).toList();
    updateGlobalData(globalData, objIndex, wordObjIndex, word, newData)
        .then((v) {
      return true;
    });
  } catch (onError) {
    print("onError");
    print(onError);
    return false;
  }
  return false;
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
  print("new Data =======>");
  print(newData);
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

List<Map> getFavoriteFile() {
  // List<Map> data = allData.getItem('Favorite');
  // return data;
}

updataFavoriteFile(Map newData) {
  // List<Map> data = allData.getItem('Favorite');
  // data.add(newData);
  // allData.setItem('Favorite', data);
}

createUnknownFile(List<Map> initialData) {
  allData.setItem('Favorite', initialData);
}

List<Map> getUnknownFile() {
  // List<Map> data = allData.getItem('Favorite');
  // return data;
}

updataUnknownFile(Map newData) {
  // List<Map> data = allData.getItem('Favorite');
  // data.add(newData);
  // allData.setItem('Favorite', data);
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
}

addinghintPoints() {
  List<Map> newData = [];
  int number = 0;
  hintPointsFile.getItem().then((value) {
    number = int.parse(value[0]['points']) + 3;
    newData = [
      {
        'points': number.toString(),
      }
    ];
    hintPointsFile.setItem('Index', newData);
  });
  print("here is value down");
  hintPointsFile.getItem().then((value) => print(value));
}

Future<bool> resetItemHomeWidget(
    List<dynamic> globalData, List<dynamic> data, int index) async {
  print("uuuuuuu");
  print("index ======>");
  // print(index);
  print(data);
  // print(data[index]);
  data.forEach((elem) {
    // print(elem);
    elem['isFavorite'] = "false";
    elem['isExcellent'] = "false";
    elem['isExcellent'] = "false";
    elem['isUnknown'] = "false";
  });
  print("new data");
  print(data);
  for (int i = 0; i < globalData.length; i++) {
    if (i == index) {
      globalData[i]['learning_words'] = "0";
      globalData[i]['Favorite'] = "0";
      globalData[i]['Excellent'] = "0";
      globalData[i]['Familiar'] = "0";
      globalData[i]['set_${index + 1}'] = data;
    }
  }
  allData.setItem('words', globalData).then((value) => true);
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

resetAll(Function globalDataUpdate) {
  allData.getItem().then((value) {
    for (int i = 0; i < value.length; i++) {
      value[i]['learning_words'] = "0";
      value[i]['Favorite'] = "0";
      value[i]['Excellent'] = "0";
      value[i]['Familiar'] = "0";
      value[i]['Unknown'] = "0";
      value[i]['set_${i + 1}'] = _newData(value[i]['set_${i + 1}']);
    }
    allData.setItem('AllData', value).then((value) => globalDataUpdate());
  });
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
