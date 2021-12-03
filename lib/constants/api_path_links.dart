
class ApiPathLinks {

  static const String coinGeckoApiV3Url = 'https://api.coingecko.com/api/v3';

  static const String trendingCoinsUri = '/search/trending';

  static String coinIconPath(String symbol) {
    return 'assets/coin_icons/${symbol.toLowerCase()}.png';
  }

  static String coinDataUriNoMarket(String coinId) {
    return '/coins/$coinId?market_data=false';
  }

  static String coinDataUriNoTickers(String coinId) {
    return '/coins/$coinId?tickers=false&market_data'
        '=true&community_data=true&developer_data=false&sparkline=true';
  }

  static String coinUsdPriceUri(String coinId) {
    return '/simple/price?ids=$coinId&vs_currencies=usd&include_market_cap'
        '=true&include_24hr_vol=true&include_24hr_change=true&include_last_updated_at=true';
  }

  static String coinUsdMarketUri(String coinId) {
    return '/coins/markets?vs_currency=usd&ids=$coinId&order'
        '=market_cap_desc&per_page=100&page=1&sparkline=true';
  }
}