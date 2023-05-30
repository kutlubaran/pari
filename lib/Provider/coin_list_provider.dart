import 'package:flutter/material.dart';
import 'package:flutter_coin/Models/coin_list_model.dart';
import 'package:flutter_coin/Network/Repos/coin_list.dart';
import 'package:flutter_coin/Network/coin_list_service.dart';

class CoinListProvider with ChangeNotifier {
  CoinListService _service = CoinListService();
  bool isLoading = false;
  List<CoinListModel> _coinList = [];
  List<CoinListModel> get coinList => _coinList;

  Future<void> getAllCoins() async {
    isLoading = true;
    notifyListeners();
    _coinList = await _service.fetchOnes();

    // _coinList = response;
    isLoading = false;
    notifyListeners();
  }
}
