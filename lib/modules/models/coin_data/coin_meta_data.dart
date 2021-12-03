
import 'package:cryptoexpo/constants/constants.dart';
import 'package:quiver/core.dart';

class CoinMetaData {
  final String? id, symbol, name;
  final Map<String, dynamic>? platforms;

  String get assetPath => ApiPathLinks.coinIconPath(symbol!);

  String get coinUriNoMarket => ApiPathLinks.coinDataUriNoMarket(id!);

  String get coinUriNoTickers => ApiPathLinks.coinDataUriNoTickers(id!);

  String get priceUri => ApiPathLinks.coinUsdPriceUri(id!);

  CoinMetaData({
    this.id,
    this.symbol,
    this.name,
    this.platforms,
  });

  bool operator ==(o) => o is CoinMetaData
      && id == o.id
      && symbol == o.symbol
      && name == o.name;

  int get hashCode => hash2(name.hashCode, id.hashCode);

  static List<CoinMetaData> listFromJson(List<dynamic> json) {
    final tickers = json.cast<Map<String, dynamic>>();
    return tickers.map((j) => CoinMetaData.fromJson(j)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'platforms': platforms

    };
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