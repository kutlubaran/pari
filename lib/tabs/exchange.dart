import 'package:flutter/material.dart';
import 'package:flutter_coin/Helpers/color_select.dart';

class EasyExchange extends StatefulWidget {
  const EasyExchange({super.key});

  @override
  State<EasyExchange> createState() => _EasyExchangeState();
}

class _EasyExchangeState extends State<EasyExchange> {
  bool _buySell = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorSelect.background,
      child: Column(children: [topButton(), coinInfos(), easyExchangeView()]),
    );
  }

  Widget topButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 30, 30, 30),
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
                height: MediaQuery.of(context).size.height * 0.74,
                child: Center(
                  child: Text(
                    'I am bottom sheet',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          );
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: ColorSelect.middleBackground,
          ),
          width: 200,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Container(
                height: 40,
                width: 40,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
                child: FlutterLogo(),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Bitcoin',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'TL',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Spacer(),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget coinInfos() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'BTC - TL',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '554,028.00',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    'TL',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '-10,972.00',
                  style: TextStyle(color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    '½-1.94',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget easyExchangeView() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
              color: ColorSelect.middleBackground,
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: ColorSelect.upperBackground,
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: _buySell
                                  ? Colors.grey.withOpacity(0.1)
                                  : ColorSelect.upperBackground,
                              borderRadius: BorderRadius.circular(12)),
                          child: TextButton(
                            style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.transparent)),
                            onPressed: () {
                              setState(() {
                                _buySell = true;
                              });
                            },
                            child: Text(
                              'Kolay al',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: _buySell
                                  ? ColorSelect.upperBackground
                                  : Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12)),
                          child: TextButton(
                            style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.transparent)),
                            onPressed: () {
                              setState(() {
                                _buySell = false;
                              });
                            },
                            child: Text(
                              'Kolay sat',
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(36.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        '0.00',
                        style: TextStyle(color: Colors.grey, fontSize: 44),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        _buySell ? 'TL' : 'BTC',
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              _buySell
                  ? Container()
                  : Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: ColorSelect.upperBackground
                                    .withOpacity(0.6),
                              ),
                              // height: 40,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, top: 8, bottom: 8, right: 8),
                                child: Center(
                                  child: Text(
                                    'Satış emri verebileceğiniz BTC varlığınız bulunmuyor.',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color:
                        _buySell ? Colors.green : ColorSelect.upperBackground,
                  ),
                  width: double.infinity,
                  child: TextButton(
                    onPressed: null,
                    child: Text(
                      _buySell ? 'BTC al' : 'BTC sat',
                      style: TextStyle(
                        fontSize: 16,
                        color: _buySell ? Colors.white : Colors.grey,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
