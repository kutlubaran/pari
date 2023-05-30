import 'dart:convert';
import 'package:flutter_coin/Models/coin_market_model.dart';
import '../Models/coin_list_model.dart';
import 'endpoints.dart';
import 'package:http/http.dart' as http;

class CoinMarketService {
  Future<List<CoinMarketModel>> fetchAllCoins(String currency) async {
    const url = Endpoints.coinMarket;
    // final queryParameters = {
    //   'vs_currency': '$currency',
    // };
    // final uri = Uri.https(url, '', queryParameters);
    // https: //api.coingecko.com/api/v3/coins/markets?vs_currency=usd
    final uri = Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final coins = json.map((e) {
        return CoinMarketModel(
          id: e['id'],
          symbol: e['symbol'],
          name: e['name'],
          image: e['image'],
          currentPrice: e['current_price'],
          // marketCap: e['marketCap'],
          // marketCapRank: e['marketCapRank'],
          // fullyDilutedValuation: e['fullyDilutedValuation'],
          totalVolume: e['total_volume'],
          // high24h: e['high24h'],
          // low24h: e['low24h'],
          // priceChange24h: e['price_change_24h'],
          priceChangePercentage24h: e['price_change_percentage_24h'],
          // marketCapChange24h: e['marketCapChange24h'],
          // marketCapChangePercentage24h: e['marketCapChangePercentage24h'],
          // circulatingSupply: e['circulatingSupply'],
          // totalSupply: e['totalSupply'],
          // maxSupply: e['maxSupply'],
          // ath: e['ath'],
          // athChangePercentage: e['athChangePercentage'],
          // athDate: e['athDate'],
          // atl: e['atl'],
          // atlChangePercentage: e['atlChangePercentage'],
          // atlDate: e['atlDate'],
          // roi: e['roi'],
          // lastUpdated: e['lastUpdated'],
        );
      }).toList();
      return coins;
    }
    return [];
  }
}
