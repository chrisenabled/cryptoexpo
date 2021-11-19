
class ApiPathLinks {

  static const String coinGeckoApiV3Url = 'https://api.coingecko.com/api/v3';

  static String coinIconPath(String symbol) {
    return 'assets/coin_icons/${symbol.toLowerCase()}.png';
  }

  static String coinDataUriNoMarket(String coinId) {
    return '/coins/$coinId?market_data=false';
  }

  static String coinDataUriNoTickers(String coinId) {
    return '/coins/bitcoin?tickers=false';
  }

  static String coinUsdPriceUri(String coinId) {
    return '/simple/price?ids=$coinId&vs_currencies=usd&include_market_cap'
        '=true&include_24hr_vol=true&include_24hr_change=true&include_last_updated_at=true';
  }
}