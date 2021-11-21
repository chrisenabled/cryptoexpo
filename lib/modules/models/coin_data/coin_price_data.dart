
class CoinPriceData {
  final String? coinId;
  final num? usd;
  final num? usdMarketCap;
  final num? usd24hVol;
  final num? usd24hChange;
  final int? lastUpdatedAt;

  CoinPriceData({
    this.coinId,
    this.usd,
    this.usdMarketCap,
    this.usd24hVol,
    this.usd24hChange,
    this.lastUpdatedAt
  });

  static CoinPriceData fromJson(dynamic _json) {
    final json = _json as Map<String, dynamic>;
    final priceJson = json.values.first;
    final coinId = json.keys.first;

    return CoinPriceData(
      coinId: coinId,
      usd: priceJson['usd'],
      usdMarketCap: priceJson['usd_market_cap'],
      usd24hVol: priceJson['usd_24_vol'],
      usd24hChange: priceJson['usd_24_change'],
      lastUpdatedAt: priceJson['last_updated_at'],
    );
  }

}