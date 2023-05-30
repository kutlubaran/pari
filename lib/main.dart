import 'package:flutter/material.dart';
import 'package:flutter_coin/Network/Repos/coin_list.dart';
import 'package:flutter_coin/Provider/coin_list_provider.dart';
import 'package:flutter_coin/Provider/coin_market_provider.dart';
import 'package:flutter_coin/tabs/tab_bar_five.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'Models/coin_list_model.dart';

void main() {
  // coinListV = CoinListRepo.getCoins();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CoinListProvider()),
        ChangeNotifierProvider(create: (context) => CoinMarketProvider()),
      ],
      child: MaterialApp(
        home: TabBarFive(),
        darkTheme: ThemeData.dark(),
      ),
    );
  }
}

late Future<List<CoinListModel>> coinListV;
