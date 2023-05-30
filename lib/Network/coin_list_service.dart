import 'dart:convert';

import '../Models/coin_list_model.dart';
import 'endpoints.dart';
import 'package:http/http.dart' as http;

class CoinListService {
  // Future<List<CoinListModel>> fetchCoins() async {
  //   try {
  //     print('insssss');
  //     final response = await http.get(Uri.parse(Endpoints.coinList));
  //     // final decoded = jsonDecode(response.body);
  //     // final coinX = decoded.toString;
  //     print('res bod: ${response.body}');

  //     var data = json.decode(response.body);
  //     print('data: ${data}');
  //     final coins =
  //         (data as List).map((e) => CoinListModel.fromJson(e)).toList();

  //     return coins;
  //   } catch (e) {
  //     print('errorM: $e');
  //     throw e;
  //   }
  // }

  Future<List<CoinListModel>> fetchOnes() async {
    const url = Endpoints.coinList;
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final coins = json.map((e) {
        return CoinListModel(id: e['id'], symbol: e['symbol'], name: e['name']);
      }).toList();
      return coins;
    }
    return [];
  }
}
