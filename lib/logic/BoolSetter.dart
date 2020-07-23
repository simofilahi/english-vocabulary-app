import 'package:lenglish/models/data.dart';

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
    }
  }
  return data[index]['en'];
}

// saveDataIntoLocalStorage(List<dynamic> data) {
//   LocalStorage storage = new LocalStorage('wordsData');
//   storage.setItem('words', data);
// }

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

updateGlobalData(List<dynamic> globalData, int objIndex, int wordObjIndex,
    String word, List<dynamic> newData) {
  // globalData[objIndex]['set_${objIndex + 1}'] = newData;
  // allData.setItem('words', globalData);
}

List<dynamic> setTrue(int objIndex, int wordObjIndex, String word,
    List<dynamic> localData, List<dynamic> globalData, flag) {
  if (flag == 1) {
    int number = int.parse(globalData[objIndex]['learning_words']);
    if (number < 50) {
      number += 1;
      globalData[objIndex]['learning_words'] = number.toString();
      print(globalData[objIndex]['learning_words']);
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
      } else if (flag == 2) {
        f['isFamiliar'] = "true";
      } else if (flag == 3) {
        f['isUnknown'] = "true";
      }
    }
    return f;
  }).toList();
  updateGlobalData(globalData, objIndex, wordObjIndex, word, newData);
  return newData;
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
    if (f['isFamiliar'] == "true") {
      newData.add(f);
    }
  });
  return newData;
}

List<dynamic> getUnknownWord(List<dynamic> item) {
  List<dynamic> newData = [];
  item.forEach((f) {
    if (f['isUnknown'] == "true") {
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

void createIndexOfFlyingSquare() {
  indexFile.setItem('Index', {"index": "0"});
  // var data = indexFile.getItem('Index');
  // print(
  //   "Index data ==> ",
  // );
  // print(data);
}

int updateIndexOfFlyingSquare(int index) {
  // print("INDEX ==> ");
  // print(index);
  // // var data = indexFile.getItem('Index');

  // data['index'] = index.toString();
  // indexFile.setItem('Index', data);
}

int getIndexOfFlyingSquare() {
  // var data = indexFile.getItem('Index');
  // print("HollaAAAAAA");
  // print(data);
  // if (data['index'] != null) {
  //   print("holla_1");
  //   return int.parse(data['index']);
  // }
  // print("holla");
  // return 0;
}
