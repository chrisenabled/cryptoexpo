import 'dart:convert';
import 'dart:math';

import 'package:country_codes/country_codes.dart';
import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:cryptoexpo/modules/models/asset_model.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data_model.dart';
import 'package:cryptoexpo/modules/models/country_model.dart';
import 'package:cryptoexpo/modules/models/trading_pair_list_item_model.dart';
import 'package:cryptoexpo/widgets/signals_tab_bar_view.dart';
import 'package:cryptoexpo/widgets/trading_pair_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final int minPrice = 2;

final int maxPrice = 1000;

final int minFreq = 1;

final int maxFreq = 20;

double getRandomPrice() {
  return double.parse((minPrice + new Random().nextInt(maxPrice - minPrice))
      .toStringAsFixed(2));
}

int getFreq() {
  return minFreq + new Random().nextInt(maxFreq - minFreq);
}

final List<CountryModel> countryModels = CountryCodes.countryCodes().map((countryDetails) =>
    CountryModel(countryDetails: countryDetails!,)).toList();

final List<Asset> myAssets = [
  Asset(assetName: 'Bitcoin', assetTicker: 'BTC', iconAsset: 'assets/images/btc.png'),
  Asset(assetName: 'Action Coin', assetTicker: 'ACTN', iconAsset: 'assets/images/actn.png'),
  Asset(assetName: 'Binance', assetTicker: 'BNB', iconAsset: 'assets/images/bnb.png'),
  Asset(assetName: 'Bancor', assetTicker: 'BNT', iconAsset: 'assets/images/bnt.png'),
  Asset(assetName: 'Bounty0x', assetTicker: 'BNTY', iconAsset: 'assets/images/bnty.png'),
  Asset(assetName: 'Canadian Coin', assetTicker: 'CDN', iconAsset: 'assets/images/cdn.png'),
  Asset(assetName: 'Chain Link', assetTicker: 'CHAIN', iconAsset: 'assets/images/chain.png'),
  Asset(assetName: 'Coqui Coin', assetTicker: 'COQUI', iconAsset: 'assets/images/coqui.png'),
  Asset(assetName: 'Crown', assetTicker: 'CRW', iconAsset: 'assets/images/crw.png'),
  Asset(assetName: 'Civic', assetTicker: 'CVC', iconAsset: 'assets/images/cvc.png'),
  Asset(assetName: 'Datum', assetTicker: 'DAT', iconAsset: 'assets/images/dat.png'),
  Asset(assetName: 'Doge', assetTicker: 'DOGE', iconAsset: 'assets/images/doge.png'),
  Asset(assetName: 'Entropy', assetTicker: 'ENTRP', iconAsset: 'assets/images/entrp.png'),
  Asset(assetName: 'Ethereum', assetTicker: 'ETH', iconAsset: 'assets/images/eth.png'),
  Asset(assetName: 'Flux', assetTicker: 'FLUX', iconAsset: 'assets/images/flux.png'),
];

final List<SignalsTabBarViewModel> myTabBarViewModels = [
  SignalsTabBarViewModel('Derivative', [
    SignalListItemModel(
        'BTC/USDT',
        'Sell',
        Colors.redAccent,
        Colors.green,
        getRandomPrice(),
        getRandomPrice(),
        getFreq()
    ),
    SignalListItemModel(
        'ETH/USDT',
        'Buy',
        Colors.green,
        Colors.green,
        getRandomPrice(),
        getRandomPrice(),
        getFreq()
    ),
    SignalListItemModel(
        'BIT/USDT',
        'Sell',
        Colors.redAccent,
        Colors.redAccent,
        getRandomPrice(),
        getRandomPrice(),
        getFreq()
    ),
    SignalListItemModel('ADA', 'Buy', Colors.green, Colors.green,
        getRandomPrice(), getRandomPrice(), getFreq()),
    SignalListItemModel('XRP/USDT', 'Sell', Colors.redAccent, Colors.redAccent,
        getRandomPrice(), getRandomPrice(), getFreq()),
    SignalListItemModel('DOT/USDT', 'Sell', Colors.redAccent, Colors.redAccent,
        getRandomPrice(), getRandomPrice(), getFreq()),
    SignalListItemModel('BTC/USDT', 'Buy', Colors.green, Colors.green,
        getRandomPrice(), getRandomPrice(), getFreq()),
    SignalListItemModel('ETH/USDT', 'Buy', Colors.green, Colors.green,
        getRandomPrice(), getRandomPrice(), getFreq()),
    SignalListItemModel('BIT/USDT', 'Sell', Colors.redAccent, Colors.redAccent,
        getRandomPrice(), getRandomPrice(), getFreq()),
    SignalListItemModel('ADA', 'Buy', Colors.green, Colors.green,
        getRandomPrice(), getRandomPrice(), getFreq()),
    SignalListItemModel('XRP/USDT', 'Sell', Colors.redAccent, Colors.redAccent,
        getRandomPrice(), getRandomPrice(), getFreq()),
    SignalListItemModel('DOT/USDT', 'Sell', Colors.redAccent, Colors.redAccent,
        getRandomPrice(), getRandomPrice(), getFreq()),
    SignalListItemModel('BTC/USDT', 'Buy', Colors.green, Colors.green,
        getRandomPrice(), getRandomPrice(), getFreq()),
    SignalListItemModel('ETH/USDT', 'Buy', Colors.green, Colors.green,
        getRandomPrice(), getRandomPrice(), getFreq()),
    SignalListItemModel('BIT/USDT', 'Sell', Colors.redAccent, Colors.redAccent,
        getRandomPrice(), getRandomPrice(), getFreq()),
  ]),
  SignalsTabBarViewModel('Spot', [
    SignalListItemModel('ADA', 'Bull', Colors.green, Colors.green,
        getRandomPrice(), getRandomPrice(), getFreq()),
    SignalListItemModel('XRP/USDT', 'Bear', Colors.redAccent, Colors.redAccent,
        getRandomPrice(), getRandomPrice(), getFreq()),
    SignalListItemModel('DOT/USDT', 'Bear', Colors.redAccent, Colors.redAccent,
        getRandomPrice(), getRandomPrice(), getFreq())
  ]),
];

const CoinUrls = [
  '/coins/bitcoin?market_data=false&developer_data=false'
];

Future<CoinDataModel> readJsonTestData() async {
  final String response = await rootBundle.loadString('assets/json/coins_test_response.json');
  final data = await json.decode(response);
  print(data);
  return CoinDataModel.fromJson(data);
}

Future <List<CoinMetaData>> readJsonCoinIds() async {
  final String response = await rootBundle.loadString('assets/json/coin_ids.json');
  final data = await json.decode(response);
  print(data);
  return CoinMetaData.listFromJson(data);
}
