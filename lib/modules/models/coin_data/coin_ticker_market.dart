
class CoinTickerMarket {
  final String? name;
  final String? identifier;
  final bool? hasTradingIncentive;

  CoinTickerMarket({this.name, this.identifier, this.hasTradingIncentive});

  static CoinTickerMarket fromJson(dynamic _json) {
    final json = _json as Map<String, dynamic>;
    return CoinTickerMarket(
      name: json['name'],
      identifier: json['identifier'],
      hasTradingIncentive: json['has_trading_incentive'],
    );
  }

}