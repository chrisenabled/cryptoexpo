

import 'package:cryptoexpo/constants/api_path_links.dart';
import 'package:cryptoexpo/modules/controllers/coin_controller.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/modules/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrendingCoinsController extends GetxController {

  final CoinGeckoService _coinGeckoService = CoinGeckoService.to;

  final _trendingCoinsStream = Rxn<List<CoinMetaData>>();
  
  final _trendingCoins = <CoinMetaData>[].obs;

  List<CoinMetaData> get trendingCoins => _trendingCoins;

  final currentPage = 0.obs;

  late final pageController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    pageController = PageController(initialPage: currentPage.value);
  }

  @override
  void onReady() {
    super.onReady();

    ever(_trendingCoinsStream, _callback);

    _trendingCoinsStream.bindStream(
        _coinGeckoService.trendingCoinMetaDataChanges(
            ApiPathLinks.trendingCoinsUri)
    );
  }

  void onPageChanged(int page) {
    print('page selected is: $page');
    currentPage.value = page;
  }


  _callback(List<CoinMetaData>? newTrendingList) {

    print('we have a new list of trending coins of: ${newTrendingList?.length}');

    if(newTrendingList != null && newTrendingList.isNotEmpty) {
      
      final addAndRemoveList = List.from(_trendingCoins);

      if(_trendingCoins.isNotEmpty) {
        _trendingCoins.forEach((coin) { 
          if(!newTrendingList.contains(coin)) {
            addAndRemoveList.remove(coin);
          }
        });
      }
      
      newTrendingList.forEach((coin) { 
        if(!addAndRemoveList.contains(coin)) {
          addAndRemoveList.add(coin);
          Get.put(CoinController(coinMeta: coin), tag: 'trending-${coin.id}');

        }
      });

      _trendingCoins.value = List.from(addAndRemoveList);
    }

    update();
  }
}