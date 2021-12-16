
import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/modules/interfaces/json_serialized.dart';
import 'package:quiver/core.dart';

class CoinMetaData implements JsonSerialized<CoinMetaData> {

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

  List<CoinMetaData>? listFromJson(List<dynamic>? json) {
    if(json == null || json.length == 0) return null;

    final tickers = json.cast<Map<String, dynamic>>();
    return tickers.map((j) => CoinMetaData().fromJson(j)).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'platforms': platforms

    };
  }

  @override
  CoinMetaData fromJson(dynamic _json) {
    final json = _json as Map<String, dynamic>;
    return CoinMetaData(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      platforms: (json['platforms']) as Map<String, dynamic>,
    );
  }
}