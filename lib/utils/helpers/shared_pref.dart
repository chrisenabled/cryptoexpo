
import 'package:cryptoexpo/modules/interfaces/json_serialized.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/modules/models/signal_indicator.dart';
import 'package:get_storage/get_storage.dart';

class SharedPref {

  static final box = GetStorage();

  static const signalDurationIndexKey = 'signal_duration_index';

  static const isBackGroundBarKey = 'is_background_bar';

  static const marketsKey = 'markets';

  static const indicatorsKey = 'indicators';

  static List<SignalIndicator>? getOrSetSignalIndicator
      ({List<SignalIndicator>? indicators}) {

    if(_saveListObjectsToStorage(list: indicators, key: indicatorsKey)) {
      return indicators;
    } else {
      return _getListObjectsFromStorage(indicatorsKey, SignalIndicator());
    }
  }

  static List<CoinMetaData>? getOrSetMarkets({List<CoinMetaData>? markets}) {

    if(_saveListObjectsToStorage(list: markets, key: marketsKey)) {
      return markets;
    } else {
      return _getListObjectsFromStorage(marketsKey, CoinMetaData());
    }
  }

  static bool getOrSetIsBackGroundBar({bool? isBackgroundBar}) {
    return _readOrWrite<bool>(isBackGroundBarKey, isBackgroundBar, false)!;
  }

  static num getOrSetSignalDurationIndex({num? duration}) {
    return _readOrWrite<num>(signalDurationIndexKey, duration, 5)!;
  }

  static List<T>? _getListObjectsFromStorage
  <T extends JsonSerialized>(String key, T creator) {
    // List<MyClass>() is T
    List<T>? list;

    final jsonList =
    _readOrWrite <List<Map<String, dynamic>>>(key, null, null);

    if(jsonList != null && jsonList.length > 0) {
      list = jsonList
          .map((json) => creator.fromJson(json)).cast<T>().toList();
    }
    return list;
  }

  static bool _saveListObjectsToStorage({
    required List<JsonSerialized>? list,
    required String key,
  }) {
    if(list != null && list.length > 0) {
      final jsonList = list.map((element) => element.toJson()).toList();
      _readOrWrite <List<Map<String, dynamic>>>(key, jsonList, null);
      return true;
    }
    return false;
  }


  static T? _readOrWrite<T>(String key, T? value, T? defaultVal) {
    if(value != null) {
      box.write(key, value);
      return value;
    } else {
      var r = box.read(key);
      if(r is T) {
        return r;
      } else {
        if(defaultVal != null) {
          box.write(key, value);
          return defaultVal;
        }
        return null;
      }
    }
  }

}