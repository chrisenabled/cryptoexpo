
class CoinTickerConvertedLast {
  final num? btc;
  final num? eth;
  final num? usd;

  CoinTickerConvertedLast({this.btc, this.eth, this.usd});

  static CoinTickerConvertedLast fromJson(dynamic _json) {
    final json = _json as Map<String, dynamic>;
    return CoinTickerConvertedLast(
      btc: json['btc'],
      eth: json['eth'],
      usd: json['usd'],
    );
  }

}