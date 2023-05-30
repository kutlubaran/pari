class Endpoints {
  Endpoints._();

  static const String baseUrl = "https://api.coingecko.com/api/v3";

  static const String coinList = '$baseUrl/coins/list';

  // static const String coinList =
  //     'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=100&page=1&sparkline=false&locale=en';

  static const String coinMarket = '$baseUrl/coins/markets';
}
