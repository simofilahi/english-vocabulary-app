import 'package:lenglish/models/data.dart';
import 'package:localstorage/localstorage.dart';

Future<void> updateSelectedLanguage(String selectedLang) async {
  String lang;

  if (selectedLang == 'French') {
    lang = 'fr';
  } else if (selectedLang == 'Spanich') {
    lang = 'sp';
  } else if (selectedLang == 'Arabic') {
    lang = 'ar';
  } else if (selectedLang == 'Chinese') {
    lang = 'ch';
  }
  wordsInfo['selected_lang'] = lang;
  print(wordsInfo['selected_lang']);
  print(wordsInfo);
  saveChosenLang(wordsInfo);
  return;
}

Future<dynamic> saveChosenLang(langData) async {
  LocalStorage storage = new LocalStorage('langData');
  storage.setItem('Lang', langData);
  if (storage.getItem('Lang') == null) {
    print("yeah");
  }
  return;
}

Future<bool> verfieFiles() async {
  LocalStorage file_1 = new LocalStorage('langData');
  LocalStorage file_2 = new LocalStorage('data');

  print("before");
  print(file_1.getItem('Lang'));
  if (file_1.getItem('Lang') == null) {
    return true;
  }
  return false;
}

Future<String> getTheSelectedLang() async {
  LocalStorage file_1 = new LocalStorage('langData');

  print("before");
  print(file_1.getItem('Lang'));
  var data = file_1.getItem('Lang');
  if (data == null) {
    return "en";
  }
  print("here data");
  print(data);
  return data['selected_lang'];
}

saveDataIntoLocalStorage(List<dynamic> data) {
  LocalStorage storage = new LocalStorage('data');
  storage.setItem('my-data', data);
}

List<dynamic> setTrue(int objIndex, int wordObjIndex, String word,
    List<dynamic> localData, List<dynamic> globalData, flag) {
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
  // print(newData);
  // List<dynamic> newData = data[objIndex]['set_${objIndex + 1}'].map((f) {
  //   if (f['en'] == word) {
  //     if (flag == 0) {
  //       f['isFavorite'] = "true";
  //     } else if (flag == 1) {
  //       f['isExcellent'] = "true";
  //     } else if (flag == 2) {
  //       f['isFamiliar'] = "true";
  //     } else if (flag == 3) {
  //       f['isUnknown'] = "true";
  //     }
  //   }
  // }).toList();
  return newData;
}

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
}
