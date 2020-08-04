import 'localStorage.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

LocalStorage allData = new LocalStorage('globalData');
LocalStorage indexFile = new LocalStorage('IndexData');
LocalStorage indexFile_2 = new LocalStorage('IndexData2');
LocalStorage favFile = new LocalStorage('FavoriteeData');
LocalStorage langFile = new LocalStorage('LangData');
LocalStorage hintPointsFile = new LocalStorage('hintPoints');

final assetsAudioPlayer = AssetsAudioPlayer();
