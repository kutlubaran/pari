import 'package:flutter/material.dart';
import 'package:flutter_coin/Helpers/color_select.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
    return Scaffold(
      backgroundColor: ColorSelect.background,
      appBar: PreferredSize(
        preferredSize: const Size(100.0, 40.0),
        child: Stack(
          children: [
            Container(
              color: _scrollPosition <= 0
                  ? ColorSelect.background
                  : _scrollPosition > 30
                      ? ColorSelect.bars
                      : ColorSelect.bars.withOpacity(_scrollPosition / 30),
            ),
            AnimatedOpacity(
              opacity: _scrollPosition <= 0
                  ? 0
                  : _scrollPosition > 30
                      ? 1
                      : _scrollPosition / 30,
              duration: const Duration(milliseconds: 10),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 42, 24, 0),
                child: Center(
                  child: Text(
                    'Hesabım',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: ColorSelect.background,
        height: 1200,
        width: double.infinity,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Hesabım',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: firstContainer(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: secondContainer(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: thirdContainer(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: fourthContainer(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 48),
              child: TextButton(
                onPressed: null,
                child: Text(
                  'Oturumu kapat',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Container firstContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorSelect.middleBackground,
      ),
      width: double.infinity,
      // height: 200,

      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              top: 16,
              bottom: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  child: FlutterLogo(
                    size: 44,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Baran Kutlu',
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Doğrulanmamış hesap',
                        style: TextStyle(color: Colors.redAccent, fontSize: 12),
                      ),
                      Row(
                        children: [
                          Text(
                            'Doğrula',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Icon(
                            Icons.arrow_right,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 8),
            child: textWithIcon('Hesap bilgileri'),
          )
        ],
      ),
    );
  }

  Container secondContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorSelect.middleBackground,
      ),
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: textWithIcon('Güvenlik ayarları'),
          ),
          Divider(
            color: Colors.black,
          ),
          textWithIcon('Bildirim ve duyuru ayarları'),
          Divider(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: textWithIcon('Uygulama teması'),
          ),
        ],
      ),
    );
  }

  Container thirdContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorSelect.upperBackground,
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ColorSelect.middleBackground,
            ),
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: textWithIcon('Açık Emirler'),
                ),
                Divider(
                  color: Colors.black,
                ),
                textWithIcon('Alarmlar'),
                Divider(
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: textWithIcon('Tüm işlemler'),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 48, right: 48, top: 16, bottom: 24),
            child: Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.currency_exchange,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Kolay al/sat',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.schedule,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Alarm kur',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container fourthContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorSelect.middleBackground,
      ),
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: textWithIcon('Paribu Destek Merkezi'),
          ),
          Divider(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: textWithIcon('Yasal metinler'),
          ),
        ],
      ),
    );
  }

  Widget textWithIcon(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
          Spacer(),
          Icon(
            Icons.arrow_right,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
