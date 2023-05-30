import 'package:flutter/material.dart';
import 'package:flutter_coin/Helpers/color_select.dart';
import 'package:flutter_coin/Provider/coin_list_provider.dart';
import 'package:flutter_coin/Tabs/exchange.dart';
import 'dart:ui';
import 'package:flutter_coin/Tabs/home.dart';
import 'package:flutter_coin/Tabs/market.dart';
import 'package:flutter_coin/Tabs/profile.dart';
import 'package:flutter_coin/Tabs/wallet.dart';
import 'package:provider/provider.dart';

class TabBarFive extends StatefulWidget {
  const TabBarFive({super.key});

  @override
  State<TabBarFive> createState() => _TabBarFiveState();
}

class _TabBarFiveState extends State<TabBarFive> {
  int _selectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _pages(BuildContext context) {
    switch (_selectedIndex) {
      case 0:
        return Home();
      case 1:
        return Market();
      case 2:
        return Wallet();
      case 3:
        return EasyExchange();
      case 4:
        return Profile();

      default:
        return Text('default');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        CoinListProvider();
      },
      child: Scaffold(
        body: Center(
          child: _pages(context),
          // child: Text('hello'),
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: BottomNavigationBar(
            backgroundColor: ColorSelect.bars,
            type: BottomNavigationBarType.fixed,
            selectedIconTheme:
                IconThemeData(color: Color.fromARGB(255, 30, 192, 35)),
            fixedColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Icon(Icons.home),
                  ),
                  label: 'Ana Sayfa'),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Icon(Icons.leaderboard),
                  ),
                  label: 'Piyasalar'),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Icon(Icons.account_balance_wallet),
                  ),
                  label: 'Cüzdan'),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Icon(Icons.currency_exchange),
                  ),
                  label: 'Kolay Al Sat'),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Icon(Icons.person_outline),
                  ),
                  label: 'Hesabım'),
            ],
            // selectedLabelStyle: TextStyle(color: Colors.blue, fontSize: 12),

            currentIndex: _selectedIndex,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            unselectedItemColor: Colors.white,
            // unselectedLabelStyle: TextStyle(color: Colors.black, fontSize: 12),
            // selectedItemColor: Colors.greenAccent[600],
            onTap: _onTabTapped,
          ),
        ),
      ),
    );
  }
}
