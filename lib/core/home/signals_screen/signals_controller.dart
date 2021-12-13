

import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/core/home/home_controller.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_meta_data.dart';
import 'package:cryptoexpo/modules/models/signal_indicator.dart';
import 'package:cryptoexpo/utils/helpers/local_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignalsController extends GetxController {

  HomeController _homeController = HomeController.to;

  final RxBool _isBackgroundBar = LocalStore.getOrSetIsBackGroundBar().obs;
  
  RxBool get isBackgroundBar => _isBackgroundBar;

  Rx<List<CoinMetaData>?> get followedMarkets =>
      _homeController.followedMarkets;

  TabController? _tabController;

  final Rx<int> _tabIndex = 0.obs;

  Rx<int> get tabIndex => _tabIndex;

  List<SignalIndicator>? get indicators => _homeController.indicators;

  SignalIndicator get selectedIndicator => indicators![_tabIndex.value];

  final Map<String, Rx<int>> selectedDurationIndexPerIndicator
  = <String, Rx<int>>{} ;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    indicators!.forEach((indicator) {
      selectedDurationIndexPerIndicator[indicator.name!] = 0.obs;
    });
  }

  
  
  @override
  void onReady() {
    super.onReady();

    LocalStore.box.listenKey(
        LocalStore.isBackGroundBarKey, onSetIsBackGroundBar);
  }

  @override
  void onClose() {
    super.onClose();
  }

  setTabController(BuildContext context) {
    _tabController = DefaultTabController.of(context)!;
    _tabController!.addListener(_onTabChanged);
  }

  _onTabChanged() {
    _tabIndex.value = _tabController!.index;
  }

  onSetIsBackGroundBar(dynamic isBackgroundBar) {
    if(isBackgroundBar is bool) {
      _isBackgroundBar.value = isBackgroundBar;
    }
  }
  
  setDurationIndex(int durationIndex) {
    selectedDurationIndexPerIndicator[selectedIndicator.name!]!.value
    = durationIndex;
  }
  
  int getSelectedIndex() {
    return selectedDurationIndexPerIndicator[selectedIndicator.name!]!.value;
  }
  
}