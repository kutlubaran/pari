import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coin/HelperWidgets/coin_row.dart';
import 'package:flutter_coin/Helpers/color_select.dart';
import 'package:flutter_coin/Models/coin_list_model.dart';
import 'package:flutter_coin/Network/Repos/coin_list.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:http/http.dart' as http;
import '../Network/endpoints.dart';
import '../Provider/coin_list_provider.dart';
import '../main.dart';

class Market extends StatefulWidget {
  const Market({super.key});

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  int _marketTapIndex = 999;

  Future<List<CoinListModel>> fetchCoinListX() async {
    var response = await http.get(Uri.parse(Endpoints.coinList));

    List<CoinListModel> coins = [];

    List data = jsonDecode(response.body);
    data.forEach((element) {
      Map obj = element;
      String id = obj['id'];
      String symbol = obj['symbol'];
      String name = obj['name'];
      coins.add(CoinListModel(id: id, symbol: symbol, name: name));
    });
    // var coinX = coins.first.name;
    // print('coins: $coinX');
    return coins;
  }

  Future<List<CoinListModel>> fetchCoinz() async {
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

  late Future<List<CoinListModel>> coinList;

  @override
  void initState() {
    super.initState();
    // coinList = CoinListRepo.getCoins();
    // coinList = coinListV;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final coinListModel =
          Provider.of<CoinListProvider>(context, listen: false);
      coinListModel.getAllCoins();
    });
  }

  @override
  Widget build(BuildContext context) {
    final coinListModel = Provider.of<CoinListProvider>(context);
    return Scaffold(
      body: Container(
        color: ColorSelect.bars,
        child: CustomScrollView(
          physics: BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.normal),
          slivers: [
            SliverAppBar(
              elevation: 0,
              backgroundColor: ColorSelect.background,
              bottom: PreferredSize(
                preferredSize: Size(12, 0),
                child: Container(
                  color: ColorSelect.bars,
                  height: 20,
                ),
              ),
              pinned: _pinned,
              snap: _snap,
              floating: _floating,
              expandedHeight: 180.0,
              collapsedHeight: 100,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.none,
                expandedTitleScale: 1.0,
                title: Container(
                  decoration: BoxDecoration(
                    color: ColorSelect.bars,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    border: Border.all(
                      width: 3,
                      color: ColorSelect.bars.withOpacity(0.2),
                      style: BorderStyle.solid,
                    ),
                  ),
                  // color: Colors.red.withOpacity(0.2),
                  height: 80,
                  child: stickyHeaderView(),
                ),
                background: Padding(
                  padding: EdgeInsets.fromLTRB(24, 0, 24, 60),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Piyasalar',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorSelect.middleBackground,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.search,
                              size: 28,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (context, index) {
            //       return Container(
            //         color: ColorSelect.bars,
            //         height: 80.0,
            //         child: Center(
            // child: coinRow(
            //   name: 'Bitcoin',
            //   volume: '123K BTC',
            //   price: '21.231\$',
            //   percentageChange: '%-12',
            // ),
            //         ),
            //       );
            //     },
            //     childCount: 20,
            //   ),
            // )
            coinListModel.isLoading
                ? SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        var indexS = coinListModel.coinList[index];
                        return Container(
                          color: ColorSelect.bars,
                          height: 80,
                          child: Center(
                            child: coinRow(
                              name: indexS.name ?? 'a',
                              volume: '${indexS.symbol}',
                              price: '21.231\$',
                              percentageChange: '%-12',
                            ),
                          ),
                        );
                      },
                      childCount: coinListModel.coinList.length,
                      // childCount: ,
                    ),
                  ),

            // FutureBuilder(
            //   future: coinListV,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return SliverList(
            //         delegate: SliverChildBuilderDelegate(
            //           (context, index) {
            //             return Container(
            //               color: ColorSelect.bars,
            //               height: 80,
            //               child: Center(
            //                 child: coinRow(
            //                   name: snapshot.data?[index].name ?? 'a',
            //                   volume: '123K BTC',
            //                   price: '21.231\$',
            //                   percentageChange: '%-12',
            //                 ),
            //               ),
            //             );
            //           },
            //           childCount: snapshot.data?.length ?? 10,
            //         ),
            //       );
            //     } else if (snapshot.hasError) {
            //       return SliverToBoxAdapter(
            //         child: Center(
            //           child: Text('No data to shown'),
            //         ),
            //       );
            //     } else {
            //       return SliverToBoxAdapter();
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget stickyHeaderView() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorSelect.middleBackground,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.star_border_outlined,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              middleContainer(),
              Container(
                child: Container(
                  height: 36,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.2),
                      border: Border.all(color: Colors.white.withOpacity(0.1))),
                  child: IconButton(
                    icon: Icon(
                      Icons.swap_vert_outlined,
                      size: 20,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 70, 70, 70),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40),
                                    topLeft: Radius.circular(40),
                                  ),
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.transparent,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.74,
                                child: Center(
                                  child: Text(
                                    'I am bottom sheet',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  Widget middleContainer() {
    return Container(
      color: ColorSelect.bars,
      width: 240,
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: horizontalTextList2.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(
                () {
                  if (_marketTapIndex == index) {
                    index = 999;
                    _marketTapIndex = 999;
                  } else {
                    _marketTapIndex = index;
                  }
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: (index == _marketTapIndex)
                    ? Colors.green
                    : ColorSelect.middleBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.only(left: 4, right: 4),
              margin: EdgeInsets.all(8.0),
              // color: Colors.blue,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    horizontalTextList2[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// return Container(
//       child: Stack(
//         children: [
//           Positioned(
//             left: 0,
//             right: 0,
//             top: 0,
//             child: AppBar(
//               title: Text('title'),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 150),
//             child: SingleChildScrollView(
//               child: Container(
//                 color: Colors.green,
//                 height: 1000,
//                 child: MediaQuery.removePadding(
//                   context: context,
//                   removeTop: true,
//                   child: ListView.builder(
//                     // physics: const NeverScrollableScrollPhysics(
//                     //     parent: NeverScrollableScrollPhysics()),
//                     shrinkWrap: true,
//                     itemCount: 20,
//                     itemBuilder: (context, index) {
//                       return StickyHeader(
//                         header: Container(
//                           height: 50.0,
//                           color: Colors.blueGrey[700],
//                           padding: EdgeInsets.symmetric(horizontal: 16.0),
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             'Header #$index',
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                         ),
//                         content: Container(
//                           color: Colors.lightBlue,
//                           height: 200,
//                           child: Text('text index: $index'),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );

List horizontalTextList = [
  'En çok işlem görenler',
  'Favoriler',
  'En çok değişenler'
];

List horizontalTextList2 = ['TL', 'USDT', 'FAN', 'BOX', 'BTC', 'PEPE'];
