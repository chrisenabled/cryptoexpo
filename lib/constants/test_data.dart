

import 'dart:math';

import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:cryptoexpo/modules/models/trading_pair_list_item_model.dart';
import 'package:cryptoexpo/widgets/signals_tab_bar_view.dart';
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


final List<SignalsTabBarViewModel> myTabBarViewModels = [
  SignalsTabBarViewModel('Derivative', [
    SignalListItemModel('BTC/USDT', 'Sell', Colors.redAccent, Colors.green,
        getRandomPrice(), getRandomPrice(), getFreq() ),
     SignalListItemModel('ETH/USDT', 'Buy', Colors.green, Colors.green,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     SignalListItemModel('BIT/USDT',  'Sell',  Colors.redAccent, Colors.redAccent,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     SignalListItemModel('ADA', 'Buy',  Colors.green, Colors.green,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     SignalListItemModel( 'XRP/USDT',  'Sell',  Colors.redAccent,Colors.redAccent,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     SignalListItemModel( 'DOT/USDT',  'Sell',  Colors.redAccent,Colors.redAccent,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     SignalListItemModel( 'BTC/USDT',  'Buy',  Colors.green, Colors.green,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     SignalListItemModel( 'ETH/USDT',  'Buy',  Colors.green, Colors.green,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     SignalListItemModel( 'BIT/USDT',  'Sell',  Colors.redAccent,Colors.redAccent,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     SignalListItemModel( 'ADA',  'Buy',  Colors.green, Colors.green,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     SignalListItemModel( 'XRP/USDT',  'Sell',  Colors.redAccent,Colors.redAccent,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     SignalListItemModel( 'DOT/USDT',  'Sell',  Colors.redAccent,Colors.redAccent,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     SignalListItemModel( 'BTC/USDT',  'Buy',  Colors.green, Colors.green,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     SignalListItemModel( 'ETH/USDT',  'Buy',  Colors.green, Colors.green,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     SignalListItemModel( 'BIT/USDT',  'Sell',  Colors.redAccent,Colors.redAccent,
         getRandomPrice(), getRandomPrice(), getFreq() ),
  ]),
  SignalsTabBarViewModel('Spot', [
     SignalListItemModel( 'ADA',  'Buy',  Colors.green,Colors.green,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     SignalListItemModel( 'XRP/USDT',  'Sell',  Colors.redAccent,Colors.redAccent,
         getRandomPrice(), getRandomPrice(), getFreq() ),
     SignalListItemModel( 'DOT/USDT',  'Sell',  Colors.redAccent,Colors.redAccent,
         getRandomPrice(), getRandomPrice(), getFreq() )
  ]),
];