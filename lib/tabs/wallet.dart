import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_coin/HelperWidgets/app_bar_widget.dart';
import 'package:flutter_coin/Helpers/color_select.dart';
import 'package:flutter_coin/Models/coin_market_model.dart';
import 'package:flutter_coin/Provider/coin_market_provider.dart';
import 'package:provider/provider.dart';

import '../HelperWidgets/coin_row.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool _isVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final coinMarketModel =
          Provider.of<CoinMarketProvider>(context, listen: false);
      coinMarketModel.getAllCoinMarket('usd');
    });
  }

  @override
  Widget build(BuildContext context) {
    final coinMarketModel = Provider.of<CoinMarketProvider>(context);
    return Scaffold(
      backgroundColor: ColorSelect.bars,
      body: CustomScrollView(
        slivers: [
          AppBarWidget(text: 'App bar widget text'),
          SliverToBoxAdapter(),
          SliverSubHeader(
            text: 'Instructions',
            backgroundColor: Colors.blue,
            minHeight: 0,
            firstOrSecond: true,
            maxHeight: 80,
          ),
          SliverToBoxAdapter(
            child: Container(
              color: ColorSelect.upperBackground,
              height: 48,
            ),
          ),
          SliverSubHeader(
            text: 'Instructions',
            backgroundColor: Colors.blue,
            minHeight: 80,
            firstOrSecond: false,
            maxHeight: 80,
          ),
          coinMarketModel.isLoading
              ? SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    var indexS = coinMarketModel.coinMarket[index];
                    var toDec = indexS.priceChangePercentage24h;
                    // print('dec: $toDec');
                    var toTru = 0.0;
                    if (toDec != null) {
                      toTru = truncateToDecimalPlaces(toDec, 2);
                    }

                    var toInt = indexS.totalVolume;
                    var toIntX = 0;
                    var toIntTru = '0';

                    if (toInt != null) {
                      toIntX = toInt.toInt();
                      toIntTru = getShortForm(toIntX);
                    }
                    return coinRow(
                      name: indexS.name ?? 'a',
                      volume: '$toIntTru',
                      price: '${indexS.currentPrice}',
                      percentageChange: '%$toTru',
                      pColor: toTru > 0 ? Colors.green : Colors.red,
                    );
                  }, childCount: coinMarketModel.coinMarket.length),
                )
        ],
      ),
    );
  }

  getShortForm(int number) {
    var shortForm = "";
    if (number != null) {
      if (number < 1000) {
        shortForm = number.toString();
      } else if (number >= 1000 && number < 1000000) {
        shortForm = (number / 1000).toStringAsFixed(1) + "K";
      } else if (number >= 1000000 && number < 1000000000) {
        shortForm = (number / 1000000).toStringAsFixed(1) + "M";
      } else if (number >= 1000000000 && number < 1000000000000) {
        shortForm = (number / 1000000000).toStringAsFixed(1) + "B";
      }
    }
    return shortForm;
  }

  double truncateToDecimalPlaces(num value, int fractionalDigits) =>
      (value * pow(10, fractionalDigits)).truncate() /
      pow(10, fractionalDigits);
}

class SliverSubHeader extends StatefulWidget {
  final String text;
  final Color backgroundColor;
  final double minHeight;
  final double maxHeight;
  final bool firstOrSecond;

  const SliverSubHeader(
      {Key? key,
      required this.text,
      required this.backgroundColor,
      required this.minHeight,
      required this.firstOrSecond,
      required this.maxHeight})
      : assert(text != null),
        assert(backgroundColor != null),
        assert(minHeight != null),
        assert(maxHeight != null),
        super(key: key);

  @override
  State<SliverSubHeader> createState() => _SliverSubHeaderState();
}

class _SliverSubHeaderState extends State<SliverSubHeader> {
  int _marketTapIndex = 999;
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      // floating: firstOrSecond ? true : false,
      pinned: true,
      delegate: _SliverAppBarDelegate(
          minHeight: widget.minHeight,
          maxHeight: widget.maxHeight,
          child: widget.firstOrSecond ? firstContainer() : secondContainer()),
    );
  }

  Widget firstContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        color: ColorSelect.upperBackground,
      ),
      child: ClipRect(
        child: OverflowBox(
          alignment: Alignment.topLeft,
          maxHeight: 80,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 16),
            child: Column(
              children: [
                Spacer(),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.greenAccent,
                      ),
                      height: 30,
                      width: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Türk Lirası',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Kullanılabilir bakiye',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '0.00 TL',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          '0.00 TL',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget secondContainer() {
    return Container(
      color: ColorSelect.upperBackground,
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          color: ColorSelect.bars,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: horizontalTextListX.length,
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

                      margin: EdgeInsets.only(
                          top: 22, bottom: 22, left: 4, right: 4),
                      // color: Colors.blue,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            horizontalTextListX[index],
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
            ),
            Container(
              decoration: BoxDecoration(boxShadow: [
                // BoxShadow(
                //   blurStyle: BlurStyle.normal,
                //   color: ColorSelect.background,
                //   offset: Offset(-16, 0),
                //   spreadRadius: 10,
                //   blurRadius: 24,
                // ),
                // BoxShadow(
                //   blurStyle: BlurStyle.normal,
                //   color: ColorSelect.background,
                //   offset: Offset(-16, -10),
                //   spreadRadius: 10,
                //   blurRadius: 24,
                // ),
                // BoxShadow(
                //   blurStyle: BlurStyle.normal,
                //   color: ColorSelect.background,
                //   offset: Offset(-16, 10),
                //   spreadRadius: 10,
                //   blurRadius: 24,
                // ),
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorSelect.middleBackground,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.search,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorSelect.middleBackground,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.swap_vert_outlined,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

List horizontalTextListX = [
  'Tümü',
  'Kripto varlıklar',
  'Sabit varlıklar',
  'FAN',
  'BOX'
];
