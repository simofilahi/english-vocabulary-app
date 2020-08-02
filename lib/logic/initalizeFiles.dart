import 'localStorage.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

LocalStorage allData = new LocalStorage('globalData');
LocalStorage indexFile = new LocalStorage('IndexData');
LocalStorage indexFile_2 = new LocalStorage('IndexData_2');
LocalStorage favFile = new LocalStorage('FavoriteeData');
LocalStorage langFile = new LocalStorage('LangData');

final assetsAudioPlayer = AssetsAudioPlayer();
