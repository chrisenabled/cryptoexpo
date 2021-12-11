// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class ExamplePage extends StatelessWidget {
//   Future<String> getSakaryaAir() async {
//     String url =
//         'https://www.random.org/integers/?num=1&min=1&max=6&col=1&base=10&format=plain&rnd=new';
//     final response =
//     await http.get(url, headers: {"Accept": "application/json"});
//
//     return response.body;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: Stream.periodic(Duration(seconds: 5))
//           .asyncMap((i) => getSakaryaAir()), // i is null here (check periodic docs)
//       builder: (context, snapshot) => Text(snapshot.data.toString()), // builder should also handle the case when data is not fetched yet
//     );
//   }
// }

import 'dart:convert';

import 'package:cryptoexpo/constants/api_path_links.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/modules/models/signal_indicator.dart';
import 'package:cryptoexpo/utils/helpers/helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CoinCoinGeckoService extends GetConnect {

  static CoinCoinGeckoService to = Get.find();

  @override
  void onInit() {
    super.onInit();
    httpClient.defaultDecoder = CoinDataModel.fromJson;
    httpClient.baseUrl = ApiPathLinks.coinGeckoApiV3Url;
  }

  Future <List<CoinMetaData>> readJsonCoinIds() async {
    final String response = await rootBundle.loadString('assets/json/coin_ids.json');
    final data = await json.decode(response);
    print(data);
    return CoinMetaData().listFromJson(data);
  }

  Future<CoinDataModel?> readJsonTestData() async {
    final String response = await rootBundle.loadString('assets/json/coins_test_response.json');
    final data = await json.decode(response);
    return CoinDataModel.fromJson(data);
  }

  Future<List<SignalIndicator>?> readJsonIndicators() async {
    final String response =
    await rootBundle.loadString('assets/json/signal_indicators.json');
    return deserialize<SignalIndicator>(response, SignalIndicator());
  }

  Stream<CoinDataModel?> coinDataChanges(String path) {
    return _getCoinDataStream(path).map((response) {
      if(response.hasError) {
        printError(info: '${response.statusCode}');
        return null;
      }
      // printInfo(info: '${response.statusCode}');
      return response.body;
    });
  }

  Stream<Response<CoinDataModel?>> _getCoinDataStream(String path) =>
      Stream.periodic(Duration(minutes: 30))
      .asyncMap((event) => _getCoinData(path))
          .asBroadcastStream(onCancel: (sub) => sub.cancel()) ;

  Future<Response<CoinDataModel?>> _getCoinData(String path) =>
      get(path,
          decoder: (coinData) {
            if (coinData is Map<String, dynamic>) {
              return CoinDataModel.fromJson(coinData);
            }
            return null;
          });

  Future<CoinDataModel?> getCoinData(CoinMetaData meta) async =>
      (await _getCoinData(meta.coinUriNoTickers)).body;

  Stream<CoinDataModel?> priceDataChanges(String path) {
    return _getPriceDataStream(path).map((response) {
      if(response.hasError) {
        printError(info: 'error: ${response.statusCode}');
        return null;
      } else {
        // printInfo(info:'${response.statusCode} coinId: ${response.body?.coinId}'
        //     ' price: ${response.body?.usd.toString()}');
        return CoinDataModel(priceData: response.body);
      }
    });
  }

  Stream<Response<CoinPriceData?>> _getPriceDataStream(String path) =>
      Stream.periodic(Duration(seconds: getRandomNum(45, 120)))
          .asyncMap((event) => getPriceData(path))
          .asBroadcastStream(onCancel: (sub) => sub.cancel()) ;

  Future<Response<CoinPriceData?>> getPriceData(String path) =>
      get(path,
        decoder: (priceData) {
        if (priceData is Map<String, dynamic>) {
          return CoinPriceData.fromJson(priceData);
        }
        return null;
      });

  Stream<CoinDataModel?> marketDataChanges(String path) {
    return _getMarketDataStream(path).map((response) {
      if(response.hasError) {
        printError(info: 'error: ${response.statusCode}');
        return null;
      } else {
        printInfo(info:'${response.statusCode} coinId: ${response.body?.id}'
            ' price: ${response.body?.currentPrice}');
        return CoinDataModel(coinMarketData: response.body);
      }
    });
  }

  Stream<Response<CoinMarketData?>> _getMarketDataStream(String path) =>
      onceAndPeriodic<Response<CoinMarketData?>>
        (Duration(hours: 24), getMarketData, path);

  Future<Response<CoinMarketData?>> getMarketData(String path) =>
      get(path,
          decoder: (marketData) {
            if (marketData is List<Map<String, dynamic>>) {
              return CoinMarketData.fromJson(marketData[0]);
            }
            return null;
          });

  Stream<List<CoinMetaData>?> trendingCoinMetaDataChanges(String path) {
    return _getTrendingCoinMetaDataStream(path).map((response) {
      if(response.hasError) {
        printError(info: 'error: ${response.statusCode}');
        return null;
      } else {
        printInfo(info:'${response.statusCode} '
            'coinId: ${response.body?[0].id}');
        return response.body;
      }
    });
  }

  Stream<Response<List<CoinMetaData>?>> _getTrendingCoinMetaDataStream(String path) =>
      onceAndPeriodic<Response<List<CoinMetaData>?>>
        (Duration(minutes: 24), getTrendingCoinMetaData, path);

  Future<Response<List<CoinMetaData>?>> getTrendingCoinMetaData(String path) =>
      get(path,
          decoder: (trendingCoin) {
            if (trendingCoin is Map<String, dynamic>) {
              if( trendingCoin['coins'] is List) {
                final tc = (trendingCoin['coins']) as List;
                final coins = <CoinMetaData>[];
                var hasCoins = false;
                tc.forEach((map) {
                  if(map['item'] is Map<String, dynamic>) {
                    if(hasCoins == false) hasCoins = true;
                    final item = map['item'];
                    final coin = CoinMetaData(
                      id: item['id'],
                      symbol: item['symbol'],
                      name: item['name'],
                    );
                    coins.add(coin);
                  }
                });
                return coins;
              }
            }
            return null;
          });

  Stream<T> onceAndPeriodic<T>(
      Duration period,
      Future<T> Function(String) computation,
      String path
      ) async* {
    yield  await computation(path);
    yield* Stream.periodic(period).asyncMap((event) => computation(path));
  }

}