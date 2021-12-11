import 'dart:convert';

import 'package:country_codes/country_codes.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data.dart';
import 'package:cryptoexpo/modules/models/coin_data/coin_data_model.dart';
import 'package:cryptoexpo/modules/models/country_model.dart';
import 'package:flutter/services.dart';

final List<CountryModel> countryModels = CountryCodes.countryCodes().map((countryDetails) =>
    CountryModel(countryDetails: countryDetails!,)).toList();

Future<CoinDataModel?> readJsonTestData() async {
  final String response = await rootBundle.loadString('assets/json/coins_test_response.json');
  final data = await json.decode(response);
  print(data);
  return CoinDataModel.fromJson(data);
}

Future <List<CoinMetaData>> readJsonCoinIds() async {
  final String response = await rootBundle.loadString('assets/json/coin_ids.json');
  final data = await json.decode(response);
  print(data);
  return CoinMetaData().listFromJson(data);
}
