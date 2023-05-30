import 'package:flutter/material.dart';
import '../Helpers/color_select.dart';

class AppBarWidget extends StatefulWidget {
  final String text;
  final bool centerTitle;

  const AppBarWidget({
    Key? key,
    required this.text,
    this.centerTitle = false,
  })  : assert(text != null),
        super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // title: Text(
      //   text,
      //   style: const TextStyle(
      //     fontSize: 30,
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
      backgroundColor: ColorSelect.bars,
      centerTitle: widget.centerTitle,
      expandedHeight: 200.0,
      collapsedHeight: 0,
      toolbarHeight: 0,
      pinned: true,
      // floating: true,
      // snap: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.none,
        background: Container(
          color: ColorSelect.bars,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(24, 50, 24, 0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cüzdan',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                        Icon(
                          Icons.history,
                          size: 28,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                allHavings(),
              ]),
        ),
      ),
    );
  }

  Widget allHavings() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 0),
          child: Text(
            'Toplam varlıklar',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 50),
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
    );
  }
}
