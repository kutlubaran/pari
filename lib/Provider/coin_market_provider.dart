import 'package:flutter/material.dart';
import 'package:flutter_coin/Models/coin_market_model.dart';
import 'package:flutter_coin/Network/coin_market_service.dart';

class CoinMarketProvider with ChangeNotifier {
  CoinMarketService _service = CoinMarketService();
  bool isLoading = false;
  List<CoinMarketModel> _coinMarket = [];
  List<CoinMarketModel> get coinMarket => _coinMarket;

  Future<void> getAllCoinMarket(String currency) async {
    isLoading = true;
    notifyListeners();
    _coinMarket = await _service.fetchAllCoins(currency);
    isLoading = false;
    notifyListeners();
  }
}
