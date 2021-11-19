
class CoinTickerConvertedVolume {
  final num? btc;
  final num? eth;
  final num? usd;

  CoinTickerConvertedVolume({this.btc, this.eth, this.usd});

  static CoinTickerConvertedVolume fromJson(dynamic _json) {
    final json = _json as Map<String, dynamic>;
    return CoinTickerConvertedVolume(
      btc: json['btc'],
      eth: json['eth'],
      usd: json['usd'],
    );
  }

}