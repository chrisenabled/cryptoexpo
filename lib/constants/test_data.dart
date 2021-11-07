

import 'dart:math';

import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:cryptoexpo/modules/models/trading_pair_list_item_model.dart';
import 'package:cryptoexpo/widgets/my_tab_bar_view.dart';
import 'package:cryptoexpo/widgets/trading_pair_list_item.dart';
import 'package:flutter/material.dart';

final int minPrice = 2;

final int maxPrice = 1000;

final int minFreq = 1;

final int maxFreq = 20;

double getRandomPrice() {
  return double.parse((minPrice + new Random().nextInt(maxPrice - minPrice)).toStringAsFixed(2));
}

int getFreq() {
  return minFreq + new Random().nextInt(maxFreq - minFreq);
}


final List<MyTabBarViewModel> myTabBarViewModels = [
  MyTabBarViewModel('Derivative', [
    TradingPairListItemModel('BTC/USDT', 'Sell', Colors.redAccent, Colors.green,
        getRandomPrice(), getRandomPrice(), getFreq() ),
     TradingPairListItemModel('ETH/USDT', 'Buy', Colors.green, Colors.green,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     TradingPairListItemModel('BIT/USDT',  'Sell',  Colors.redAccent, Colors.redAccent,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     TradingPairListItemModel('ADA', 'Buy',  Colors.green, Colors.green,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     TradingPairListItemModel( 'XRP/USDT',  'Sell',  Colors.redAccent,Colors.redAccent,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     TradingPairListItemModel( 'DOT/USDT',  'Sell',  Colors.redAccent,Colors.redAccent,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     TradingPairListItemModel( 'BTC/USDT',  'Buy',  Colors.green, Colors.green,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     TradingPairListItemModel( 'ETH/USDT',  'Buy',  Colors.green, Colors.green,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     TradingPairListItemModel( 'BIT/USDT',  'Sell',  Colors.redAccent,Colors.redAccent,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     TradingPairListItemModel( 'ADA',  'Buy',  Colors.green, Colors.green,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     TradingPairListItemModel( 'XRP/USDT',  'Sell',  Colors.redAccent,Colors.redAccent,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     TradingPairListItemModel( 'DOT/USDT',  'Sell',  Colors.redAccent,Colors.redAccent,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     TradingPairListItemModel( 'BTC/USDT',  'Buy',  Colors.green, Colors.green,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     TradingPairListItemModel( 'ETH/USDT',  'Buy',  Colors.green, Colors.green,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     TradingPairListItemModel( 'BIT/USDT',  'Sell',  Colors.redAccent,Colors.redAccent,
         getRandomPrice(), getRandomPrice(), getFreq() ),
  ]),
  MyTabBarViewModel('Spot', [
     TradingPairListItemModel( 'ADA',  'Buy',  Colors.green,Colors.green,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     TradingPairListItemModel( 'XRP/USDT',  'Sell',  Colors.redAccent,Colors.redAccent,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     TradingPairListItemModel( 'DOT/USDT',  'Sell',  Colors.redAccent,Colors.redAccent,
         getRandomPrice(), getRandomPrice(), getFreq() )
  ]),
];