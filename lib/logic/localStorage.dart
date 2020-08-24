import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  final String fileName;
  LocalStorage(this.fileName);

  File file;
  var fileContent;

  Future<bool> createFile() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    file = File(appDocPath + '/' + this.fileName);
    if (file == null) {
      return false;
    }
    return true;
  }

  Future<bool> setItem(String key, dynamic data) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    file = File(appDocPath + '/' + this.fileName);
    print('inside set items');
    print(file);
    if (file != null) {
      file.writeAsStringSync('');
      file.writeAsStringSync(jsonEncode(data));
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> getItem() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    file = File(appDocPath + '/' + this.fileName);
    if (file != null) {
      var data = file.readAsStringSync();
      List<dynamic> newData = jsonDecode(data);
      return newData;
    } else {
      return null;
    }
  }

  Future<bool> isExist() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    if (File(appDocPath + '/' + this.fileName).existsSync() == false) {
      return false;
    } else
      return true;
  }
}
