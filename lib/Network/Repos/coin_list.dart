import 'dart:convert';
import 'package:flutter_coin/Models/coin_list_model.dart';
import 'package:flutter_coin/Network/endpoints.dart';
import 'package:http/http.dart' as http;

class CoinList {
  static late List<CoinListModel> coinList;

  factory CoinList() => CoinList._internal();
  CoinList._internal();

  static Future<List<CoinListModel>> fetchCoins() async {
    try {
      print('insssss');
      final response = await http.get(Uri.parse(Endpoints.coinList));
      // final decoded = jsonDecode(response.body);
      // final coinX = decoded.toString;
      print('res bod: ${response.body}');

      var data = json.decode(response.body);
      print('data: ${data}');
      final coins =
          (data as List).map((e) => CoinListModel.fromJson(e)).toList();

      return coins;
    } catch (e) {
      print('errorM: $e');
      throw e;
    }
  }
}

class CoinListRepo {
  static Future<List<CoinListModel>> getCoins() async {
    final coins = await CoinList.fetchCoins();
    return coins;
  }
}
