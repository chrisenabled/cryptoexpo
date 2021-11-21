import 'coin_data.dart';

class CoinDataModel {
  final CoinMetaData? metaData;
  final CoinPriceData? priceData;
  final String? id;
  final String? name;
  final String? symbol;
  final String? lastUpdated;
  final num? blockTimeInMinutes;
  final String? hashingAlgorithm;
  final String? publicNotice;
  final List<String>? additionalNotices;
  final CoinLocalization? localization;
  final CoinDescription? description;
  final List<dynamic>? blockchainSite;
  final List<CoinTickerModel>? tickers;
  final num? sentimentVotesUpPercentage;
  final num? sentimentVotesDownPercentage;
  final CoinCommunityData? coinCommunityData;
  final CoinMarketData? coinMarketData;

  CoinDataModel({
    this.metaData, //shouldn't come from json
    this.priceData, //shouldn't come from json
    this.id,
    this.name,
    this.symbol,
    this.lastUpdated,
    this.blockTimeInMinutes,
    this.hashingAlgorithm,
    this.publicNotice,
    this.additionalNotices,
    this.localization,
    this.description,
    this.blockchainSite,
    this.tickers,
    this.sentimentVotesUpPercentage,
    this.sentimentVotesDownPercentage,
    this.coinCommunityData,
    this.coinMarketData,
  });

  CoinDataModel copyWith({
    CoinMetaData? metaData,
    CoinPriceData? priceData,
    String? id,
    String? name,
    String? symbol,
    String? lastUpdated,
    num? blockTimeInMinutes,
    String? hashingAlgorithm,
    String? publicNotice,
    List<String>? additionalNotices,
    CoinLocalization? localization,
    CoinDescription? description,
    List<dynamic>? blockchainSite,
    List<CoinTickerModel>? tickers,
    CoinCommunityData? coinCommunityData,
    CoinMarketData? coinMarketData,
    CoinDataModel? other,
  }) {
    if (other != null) {
      return copyWith(
        metaData: metaData ?? other.metaData,
        priceData: priceData ?? other.priceData,
        id: id ?? other.id,
        name: name ?? other.name,
        symbol: symbol ?? other.symbol,
        lastUpdated: lastUpdated ?? other.lastUpdated,
        blockTimeInMinutes: blockTimeInMinutes ?? other.blockTimeInMinutes,
        hashingAlgorithm: hashingAlgorithm ?? other.hashingAlgorithm,
        publicNotice: publicNotice ?? other.publicNotice,
        additionalNotices: additionalNotices ?? other.additionalNotices,
        localization: localization ?? other.localization,
        description: description ?? other.description,
        blockchainSite: blockchainSite ?? other.blockchainSite,
        tickers: tickers ?? other.tickers,
        coinCommunityData: coinCommunityData ?? other.coinCommunityData,
        coinMarketData: coinMarketData ?? other.coinMarketData,
      );
    }

    return CoinDataModel(
      metaData: metaData ?? this.metaData,
      priceData: priceData ?? this.priceData,
      id: id ?? this.id,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      lastUpdated: lastUpdated ?? lastUpdated,
      blockTimeInMinutes: blockTimeInMinutes ?? this.blockTimeInMinutes,
      hashingAlgorithm: hashingAlgorithm ?? this.hashingAlgorithm,
      publicNotice: publicNotice ?? this.publicNotice,
      additionalNotices: additionalNotices ?? this.additionalNotices,
      localization: localization ?? this.localization,
      description: description ?? this.description,
      blockchainSite: blockchainSite ?? this.blockchainSite,
      tickers: tickers ?? this.tickers,
      coinCommunityData: coinCommunityData ?? this.coinCommunityData,
      coinMarketData: coinMarketData ?? this.coinMarketData,
    );
  }

  static CoinDataModel fromJson(dynamic _json) {

    final json = _json as Map<String, dynamic>;
    return CoinDataModel(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      lastUpdated: json['last_updated'],
      blockTimeInMinutes: json['block_time_in_minutes'],
      hashingAlgorithm: json['hashing_algorithm'],
      publicNotice: json['public_notice'],
      additionalNotices:
          ((json['additional_notices']) as List<dynamic>).cast<String>(),
      localization: json['localization'] == null
          ? null
          : CoinLocalization.fromJson(json['localization']),
      description: json['description'] == null
          ? null
          :  CoinDescription.fromJson(json['description']),
      tickers: json['tickers'] == null
          ? null
          : CoinTickerModel.listFromJson(json['tickers']),
      coinCommunityData: json['community_data'] == null
          ? null
          : CoinCommunityData.fromJson(json['community_data']),
      coinMarketData: json['market_data'] == null
          ? null
          : CoinMarketData.fromJson(json['market_data']),
    );
  }
}
