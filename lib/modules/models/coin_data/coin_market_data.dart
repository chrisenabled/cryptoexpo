

class CoinMarketData {
  final num? currentPrice;
  final num? ath;
  final num? athChangePercentage;
  final num? athDate;
  final num? atl;
  final num? atlChangePercentage;
  final num? atlDate;
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
  final num? circulatingSupply;

  CoinMarketData({
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
    this.circulatingSupply
  });

  static CoinMarketData fromJson(dynamic _json) {
    final json = _json as Map<String, dynamic>;
    return CoinMarketData(
      currentPrice: json['current_price']['usd'],
      ath: json['ath']['usd'],
      athChangePercentage: json['ath_change_percentage']['usd'],
      athDate: json['ath_date']['usd'],
      atl: json['atl']['usd'],
      atlChangePercentage: json['atl_change_percentage']['usd'],
      atlDate: json['atl_date']['usd'],
      marketCap: json['market_cap']['usd'],
      marketCapRank: json['market_cap_rank'],
      totalVolume: json['total_volume']['usd'],
      high24h: json['high_24h']['usd'],
      low24h: json['low_24h']['usd'],
      priceChange24h: json['price_change_24h'],
      priceChangePercentage24h: json['price_change_percentage_24h'],
      marketCapChange24h: json['market_cap_change_24h'],
      marketCapChangePercentage24h: json['market_cap_change_percentage_24h'],
      priceChange24hInCurrency: json['price_change_24h_in_currency']['usd'],
      priceChangePercentage24hInCurrency: json['price_change_percentage_24h_in_currency']['usd'],
      totalSupply: json['total_supply'],
      circulatingSupply: json['circulating_supply'],
    );
  }

}