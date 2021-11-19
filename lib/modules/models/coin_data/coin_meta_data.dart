
import 'package:cryptoexpo/constants/constants.dart';

class CoinMetaData {
  final String? id, symbol, name;
  final Map<String, dynamic>? platforms;

  String get assetPath => ApiPathLinks.coinIconPath(symbol!);

  String get coinUri => ApiPathLinks.coinDataUriNoMarket(id!);

  String get priceUri => ApiPathLinks.coinUsdPriceUri(id!);

  CoinMetaData({
    this.id,
    this.symbol,
    this.name,
    this.platforms,
  });

  static List<CoinMetaData> listFromJson(List<dynamic> json) {
    final tickers = json.cast<Map<String, dynamic>>();
    return tickers.map((j) => CoinMetaData.fromJson(j)).toList();
  }

  static CoinMetaData fromJson(dynamic _json) {
    final json = _json as Map<String, dynamic>;
    return CoinMetaData(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      platforms: (json['platforms']) as Map<String, dynamic>,
    );
  }
}