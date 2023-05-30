import 'package:flutter/material.dart';

class coinRow extends StatefulWidget {
  const coinRow(
      {super.key,
      required this.name,
      required this.volume,
      required this.price,
      required this.percentageChange,
      this.pColor = const Color.fromARGB(255, 195, 204, 203)});

  final String name;
  final String volume;
  final String price;
  final String percentageChange;
  final Color pColor;

  @override
  State<coinRow> createState() => _coinRowState();
}

class _coinRowState extends State<coinRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(16),
      // decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      widget.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      widget.volume,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(8),
              child: Image.asset(
                'assets/images/iconfl.png',
                width: 100,
                height: 40,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      widget.price,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      widget.percentageChange,
                      style: TextStyle(
                          color: widget.pColor, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
