import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_coin/HelperWidgets/announcement_card.dart';
import 'package:flutter_coin/HelperWidgets/coin_row.dart';
import 'package:flutter_coin/Helpers/color_select.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:flutter_coin/HelperWidgets/coin_row.dart';
import 'package:flutter_coin/HelperWidgets/announcement_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _pinned = false;
  bool _snap = false;
  bool _floating = false;

  bool _isVisible = true;
  final PageController pageController = PageController();
  int _dotCurrentIndex = 0;
  int _marketTapIndex = 0;

  late Future future;

  ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(_scrollPosition);
    return Scaffold(
      backgroundColor: ColorSelect.background,
      appBar: PreferredSize(
        preferredSize: const Size(100.0, 40.0),
        child: Stack(
          children: [
            Container(
                color: _scrollPosition <= 60
                    ? ColorSelect.background
                    : (_scrollPosition > 60 && _scrollPosition <= 90)
                        ? ColorSelect.bars.withOpacity(_scrollPosition / 90)
                        : _scrollPosition > 90
                            ? ColorSelect.bars
                            : ColorSelect.background),
            AnimatedOpacity(
              opacity: _scrollPosition <= 60
                  ? 0
                  : (_scrollPosition > 60 && _scrollPosition <= 90)
                      ? _scrollPosition / 90
                      : _scrollPosition > 90
                          ? 1
                          : 0,
              duration: const Duration(milliseconds: 10),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 42, 24, 0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'PARIBU',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Icon(
                        Icons.notifications_outlined,
                        size: 32,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              // const Positioned.fill(
              //   child: Align(
              //       alignment: Alignment.bottomCenter,
              //       child: Padding(
              //         padding: EdgeInsets.all(8.0),
              //         child: Text('My Super App'),
              //       )),
              // ),
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: 1200,
        color: ColorSelect.background,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 30,
              ),
              Text(
                'PARIBU',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                ),
                child: circles(context),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: PageViewDotIndicator(
                    // size: Size(8, 4),
                    size: Size(4, 4),
                    unselectedSize: Size(4, 4),
                    currentItem: _dotCurrentIndex,
                    count: 3,
                    unselectedColor: Colors.white,
                    selectedColor: Colors.green),
              ),
              marketsView(),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: announcementView(),
              ),
              const SizedBox(
                height: 1050,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget marketsView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Piyasalar',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              Row(
                children: [
                  Text(
                    'Tümü',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          color: ColorSelect.middleBackground,
          width: double.infinity,
          height: 40,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: horizontalTextList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(
                    () {
                      _marketTapIndex = index;
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: (index == _marketTapIndex)
                        ? ColorSelect.upperBackground
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.only(left: 12, right: 12),
                  margin: EdgeInsets.only(left: 4, right: 4),
                  // color: Colors.blue,
                  child: Center(
                    child: Text(
                      horizontalTextList[index],
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          // color: Colors.amber,

          width: double.infinity,
          height: 240,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(
                parent: NeverScrollableScrollPhysics()),
            itemCount: 3,
            itemBuilder: (context, index) {
              if (_marketTapIndex == 0) {
                return coinRow(
                  name: 'Bitcoin',
                  volume: '123K BTC',
                  price: '21.231\$',
                  percentageChange: '%-12',
                );
              } else if (_marketTapIndex == 1) {
                return Container();
              } else if (_marketTapIndex == 2) {
                return coinRow(
                  name: 'PepeCoin',
                  volume: '123K PEPE',
                  price: '0.00231\$',
                  percentageChange: '%-55',
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Stack circles(BuildContext context) {
    return Stack(
      children: [
        stackBuild(),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.width) * 0.64,
          child: horizontalCollection(),
        ),
      ],
    );
  }

  Widget announcementView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Duyurular',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              Row(
                children: [
                  Text(
                    'Tümü',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          height: 240,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: announcementCard()),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget pageBuild(HorizontalCollectionModel model) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: ColorSelect.bars,
            shape: BoxShape.circle,
            border: Border.all(color: ColorSelect.middleBackground),
          ),
          child: Icon(
            model.icon,
            color: Colors.lightGreen,
            size: 30,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            model.title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            model.body,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Icon(
          Icons.arrow_forward_rounded,
          color: Colors.green,
        ),
      ],
    );
  }

  Widget horizontalCollection() {
    return Container(
      width: double.infinity,
      height: 200,
      // color: Colors.amber,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: horizontalCollectionList.length,
        controller: pageController,
        onPageChanged: (page) {
          setState(() {
            _dotCurrentIndex = page;
          });
        },
        itemBuilder: (context, index) {
          // return pageBuild(Icon(Icons.abc_outlined), 'title2', 'body2');
          return pageBuild(horizontalCollectionList[index]);

          // pageBuild(Icon(Icons.abc_outlined), 'title3', 'body3'),
        },
      ),
    );
  }

  Stack stackBuild() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.width - 36,
          width: MediaQuery.of(context).size.width - 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // border: Border.all(
            //     width: 1,
            //     color: Color.fromARGB(255, 128, 128, 128)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorSelect.upperBackground.withOpacity(0.2),
                ColorSelect.middleBackground.withOpacity(0.2),
                ColorSelect.background,
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.width - 72,
          width: MediaQuery.of(context).size.width - 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // border: Border.all(
            //     width: 1,
            //     color: Color.fromARGB(255, 128, 128, 128)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorSelect.upperBackground.withOpacity(0.5),
                ColorSelect.middleBackground.withOpacity(0.5),
                ColorSelect.background,
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.width - 108,
          width: MediaQuery.of(context).size.width - 108,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // border: Border.all(
            //     width: 1,
            //     color: Color.fromARGB(255, 128, 128, 128)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorSelect.upperBackground,
                ColorSelect.middleBackground,
                ColorSelect.background,
              ],
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'Toplam varlıklar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 32,
                        right: 4,
                      ),
                      child: Text(
                        _isVisible ? '0.00' : '*****',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'TL',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    Padding(
                      child: IconButton(
                        icon: Icon(
                          _isVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () => setState(
                          () {
                            if (_isVisible == false) {
                              _isVisible = true;
                            } else {
                              _isVisible = false;
                            }
                          },
                        ),
                      ),
                      padding: EdgeInsets.only(left: 0),
                    )
                    // Padding(
                    //   padding: EdgeInsets.only(left: 16),
                    //   child: GestureDetector(
                    //       //child: IconButton
                    //       ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HorizontalCollectionModel {
  final IconData icon;
  final String title;
  final String body;

  HorizontalCollectionModel(this.icon, this.title, this.body);
}

List horizontalCollectionList = [
  HorizontalCollectionModel(Icons.badge, 'Kimlik bilgilerinizi dogrulayın',
      'Kimliğinizi doğrulayarak Paribu hesabınızda yatırım yapmaya başlayabilirsiniz'),
  HorizontalCollectionModel(Icons.book_online, 'Google Authenticatorı kurun',
      'Google auth kurarak hesap guvenliginizi arttırailir ve sms onayi yerine kullanabailirsniz'),
  HorizontalCollectionModel(Icons.monetization_on, 'TL yatırın',
      'Bankanızdan en az 10 tl transfer yaparak yatırım yapmaya başlayabilirnisniz.'),
];

List horizontalTextList = [
  'En çok işlem görenler',
  'Favoriler',
  'En çok değişenler'
];
