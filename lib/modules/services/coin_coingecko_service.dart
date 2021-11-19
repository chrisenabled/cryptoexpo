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

import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:get/get.dart';

class CoinCoinGeckoService extends GetConnect {

  static CoinCoinGeckoService to = Get.find();

  @override
  void onInit() {
    super.onInit();
    httpClient.defaultDecoder = CoinDataModel.fromJson;
    httpClient.baseUrl = 'https://api.coingecko.com/api/v3';
  }

  Future<CoinDataModel> readJsonTestData() => readJsonTestData();

  Future<CoinMetaData> readJsonCoinIds() => readJsonCoinIds();

  Stream<CoinDataModel?> coinDataChanges(String path, {CoinDataModel? coin}) {
    return _getCoinDataStream(path).map((response) {
      if(response.hasError) {
        printError(info: '${response.statusCode}');
        return null;
      }
      printInfo(info: '${response.statusCode}');
      return response.body;
    });
  }

  Stream<Response<CoinDataModel>> _getCoinDataStream(String path) =>
      Stream.periodic(Duration(minutes: 30))
      .asyncMap((event) => _getCoinData(path))
          .asBroadcastStream(onCancel: (sub) => sub.cancel()) ;

  Future<Response<CoinDataModel>> _getCoinData(String path) => get(path);

  Future<CoinDataModel?> getCoinData(String uri) async =>
      (await _getCoinData(uri)).body;

  Stream<CoinDataModel?> priceDataChanges(String path, {CoinDataModel? coin}) {
    return _getPriceDataStream(path).map((response) {
      if(response.hasError) {
        printError(info: '${response.statusCode}');
        return coin;
      }
      printInfo(info: '${response.statusCode}');

      printInfo(info: '${response.body!.usd.toString()}');

      if(coin != null) return coin.copyWith(priceData: response.body);

      return CoinDataModel(priceData: response.body);
    });
  }

  Stream<Response<CoinPriceData>> _getPriceDataStream(String path) =>
      Stream.periodic(Duration(seconds: 30))
          .asyncMap((event) => getPriceData(path))
          .asBroadcastStream(onCancel: (sub) => sub.cancel()) ;

  Future<Response<CoinPriceData>> getPriceData(String path) =>
      get(path,
        decoder: (priceData) => CoinPriceData.fromJson(priceData));

}

typedef StreamData =  Response<T> Function<T>(String);

typedef F<T> = T Function(T);