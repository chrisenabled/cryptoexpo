

import 'package:cryptoexpo/utils/helpers/util.dart';

class CoinMarketData {
  final String? id;
  final String? symbol;
  final String? name;
  final num? currentPrice;
  final num? ath;
  final num? athChangePercentage;
  final String? athDate;
  final num? atl;
  final num? atlChangePercentage;
  final String? atlDate;
  final num? marketCap;
  final num? marketCapRank;
  final num? totalVolume;
  final num? high24h;
  final num? low24h;
  final num? priceChange24h;
  final num? priceChangePercentage24h;
  final num? marketCapChange24h;
  final num? marketCapChangePercentage24h;
  final num? priceChange24hInCurrency;
  final num? priceChangePercentage24hInCurrency;
  final num? totalSupply;
  final num? maxSupply;
  final num? circulatingSupply;
  final String? lastUpdated;
  final List<num>? sparkLineIn7d;

  CoinMarketData({
    this.id,
    this.symbol,
    this.name,
    this.currentPrice,
    this.ath,
    this.athChangePercentage,
    this.athDate,
    this.atl,
    this.atlChangePercentage,
    this.atlDate,
    this.marketCap,
    this.marketCapRank,
    this.totalVolume,
    this.high24h,
    this.low24h,
    this.priceChange24h,
    this.priceChangePercentage24h,
    this.marketCapChange24h,
    this.marketCapChangePercentage24h,
    this.priceChange24hInCurrency,
    this.priceChangePercentage24hInCurrency,
    this.totalSupply,
    this.maxSupply,
    this.circulatingSupply,
    this.lastUpdated,
    this.sparkLineIn7d,
  });

  static CoinMarketData fromJson(dynamic _json) {
    final json = _json as Map<String, dynamic>;
    return CoinMarketData(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      currentPrice: json['current_price']?['usd']
          ?? getTypeFromJson<num>(json['current_price']),
      ath: json['ath']?['usd']
          ?? getTypeFromJson<num>(json['ath']),
      athChangePercentage: json['ath_change_percentage']?['usd']
          ?? getTypeFromJson<num>(json['ath_change_percentage']),
      athDate: json['ath_date']?['usd']
          ?? getTypeFromJson<String>(json['ath_date']),
      atl: json['atl']?['usd']
          ?? getTypeFromJson<num>(json['atl']),
      atlChangePercentage: json['atl_change_percentage']?['usd']
          ?? getTypeFromJson<num>(json['atl_change_percentage']),
      atlDate: json['atl_date']?['usd']
          ?? getTypeFromJson<String>(json['atl_date']),
      marketCap: json['market_cap']?['usd']
          ?? getTypeFromJson<num>(json['market_cap']),
      marketCapRank: json['market_cap_rank'],
      totalVolume: json['total_volume']?['usd']
          ?? getTypeFromJson<num>(json['total_volume']),
      high24h: json['high_24h']?['usd']
          ?? getTypeFromJson<num>(json['high_24h']),
      low24h: json['low_24h']?['usd']
          ?? getTypeFromJson<num>(json['low_24h']),
      priceChange24h: json['price_change_24h'],
      priceChangePercentage24h: json['price_change_percentage_24h'],
      marketCapChange24h: json['market_cap_change_24h'],
      marketCapChangePercentage24h: json['market_cap_change_percentage_24h'],
      priceChange24hInCurrency: json['price_change_24h_in_currency']?['usd']
          ?? getTypeFromJson<num>(json['price_change_24h_in_currency']),
      priceChangePercentage24hInCurrency:
      json['price_change_percentage_24h_in_currency']?['usd']
          ?? getTypeFromJson<num>(json['price_change_percentage_24h_in_currency']),
      totalSupply: json['total_supply'],
      maxSupply: json['max_supply'],
      circulatingSupply: json['circulating_supply'],
      sparkLineIn7d: json['sparkline_7d']?['price']?.cast<num>()
          ?? json['sparkline_in_7d']?['price']?.cast<num>(),
    );
  }

}