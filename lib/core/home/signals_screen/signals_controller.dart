

import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_meta_data.dart';
import 'package:cryptoexpo/utils/helpers/shared_pref.dart';
import 'package:get/get.dart';

class SignalsController extends GetxController {

  final RxBool _isBackgroundBar = SharedPref.getOrSetIsBackGroundBar().obs;
  
  RxBool get isBackgroundBar => _isBackgroundBar;

  final Rx<num> _currentDuration = SharedPref.getOrSetSignalDurationIndex().obs;

  Rx<num> get currentDuration => _currentDuration;

  Rx<List<CoinMetaData>?> _followedMarkets = SharedPref.getOrSetMarkets().obs;

  Rx<List<CoinMetaData>?> get followedMarkets => _followedMarkets;

  
  
  @override
  void onReady() {
    super.onReady();

    SharedPref.box.listenKey(
        SharedPref.isBackGroundBarKey, onSetIsBackGroundBar);

  }

  @override
  void onClose() {
    super.onClose();
  }

  onSetIsBackGroundBar(dynamic isBackgroundBar) {
    if(isBackgroundBar is bool) {
      _isBackgroundBar.value = isBackgroundBar;
    }
  }
  
  setDuration(num duration) {
    SharedPref.getOrSetSignalDurationIndex(duration: duration);
    _currentDuration.value = duration;
  }
  
  int getSelectedIndex() {
    return Globals.durations.indexOf(currentDuration.value);
  }
  
}