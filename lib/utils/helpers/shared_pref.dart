
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:get_storage/get_storage.dart';

class SharedPref {

  static final box = GetStorage();

  static const signalDurationIndexKey = 'signal_duration_index';

  static const isBackGroundBarKey = 'is_background_bar';

  static const marketsKey = 'markets';

  static List<CoinMetaData>? getOrSetMarkets({List<CoinMetaData>? markets}) {
    if (markets != null && markets.length > 0) {
      final jsonMarkets = markets.map((market) => market.toJson()).toList();
       _readOrWrite <List<Map<String, dynamic>>>(marketsKey, jsonMarkets, null);
       return markets;
    } else {
      List<CoinMetaData>? markets;
      final jsonMarkets =
      _readOrWrite <List<Map<String, dynamic>>>(marketsKey, null, null);
      if(jsonMarkets != null && jsonMarkets.length > 0) {
        markets = jsonMarkets.map((json) =>
            CoinMetaData.fromJson(json)).toList();
      }
      return markets;
    }
  }

  static bool getOrSetIsBackGroundBar({bool? isBackgroundBar}) {
    return _readOrWrite<bool>(isBackGroundBarKey, isBackgroundBar, false)!;
  }

  static num getOrSetSignalDurationIndex({num? duration}) {
    return _readOrWrite<num>(signalDurationIndexKey, duration, 5)!;
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