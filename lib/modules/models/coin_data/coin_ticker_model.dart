
import 'coin_data.dart';

class CoinTickerModel {
  final String? name;
  final String? base;
  final String? target;
  final CoinTickerMarket? market;
  final num? last;
  final num? volume;
  final CoinTickerConvertedLast? convertedLast;
  final CoinTickerConvertedVolume? convertedVolume;
  final String? trustScore;
  final num? bidAskSpreadPercentage;
  final String? lastTradedAt;
  final bool? isAnomaly;
  final bool? isStale;
  final String? tradeUrl;
  final String? tokenInfoUrl;
  final String? coinId;
  final String? targetCoinId;

  CoinTickerModel({
    this.name,
    this.base,
    this.target,
    this.volume,
    this.market,
    this.last,
    this.convertedLast,
    this.convertedVolume,
    this.trustScore,
    this.bidAskSpreadPercentage,
    this.lastTradedAt,
    this.isAnomaly,
    this.isStale,
    this.tradeUrl,
    this.tokenInfoUrl,
    this.coinId,
    this.targetCoinId,
  });

  static List<CoinTickerModel> listFromJson(List<dynamic> json) {
    final tickers = json.cast<Map<String, dynamic>>();
    return tickers.map((j) => CoinTickerModel.fromJson(j)).toList();
  }

  static CoinTickerModel fromJson(dynamic _json) {
    final json = _json as Map<String, dynamic>;
    return CoinTickerModel(
      base: json['base'],
      target: json['target'],
      volume: json['volume'],
      market: CoinTickerMarket.fromJson( json['market']),
      last: json['last'],
      convertedLast: CoinTickerConvertedLast.fromJson((json['converted_last'])),
      convertedVolume: CoinTickerConvertedVolume.fromJson(json['converted_volume']),
      trustScore: json['trust_score'],
      bidAskSpreadPercentage: json['bid_ask_spread_percentage'],
      lastTradedAt: json['last_traded_at'],
      isAnomaly: json['is_anomaly'],
      isStale: json['is_stale'],
      tradeUrl: json['trade_url'],
      tokenInfoUrl: json['token_info_url'],
      coinId: json['coin_id'],
      targetCoinId: json['target_coin_id'],
    );
  }
}