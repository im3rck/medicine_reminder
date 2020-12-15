import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class MainLog extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainLog> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10; // number that changes when refreshed
  Stream<int> counterStream =
      Stream<int>.periodic(Duration(seconds: 3), (x) => refreshNum);

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
  }

  static final List<String> _items = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N'
  ];

  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 2), () {
      completer.complete();
    });
    setState(() {
      refreshNum = new Random().nextInt(100);
    });
    return completer.future.then<void>((_) {
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
        backgroundColor: Color(0xff121212),
        content: const Text(
          'Refreshed',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Circular',
            fontSize: 20,
            letterSpacing: 0.5,
            color: Color(0xfff2e7fe),
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff292929),
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: LiquidPullToRefresh(
        color: Color(0xff292929),
        backgroundColor: Color(0xffbb86fe),
        height: (MediaQuery.of(context).size.height) / 7,
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        showChildOpacityTransition: false,
        child: StreamBuilder<int>(
            stream: counterStream,
            builder: (context, snapshot) {
              return ListView.builder(
                padding: kMaterialListPadding,
                itemCount: _items.length,
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index) {
                  final String item = _items[index];
                  return ListTile(
                    autofocus: true,
                    tileColor: Color(0xff121212),
                    contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    isThreeLine: true,
                    leading: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color: Color(0xff292929),
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Color(0xffbb86fe), width: 4)),
                    ),
                    title: Text('Log Title: "He ded"',style: TextStyle(
                      fontFamily: 'Circular',
                      fontSize: 16,
                      color: Color(0xfff2e7fe),
                      fontWeight: FontWeight.w500,
                    ),),
                    subtitle: Text(
                        'Missed em Meds of his',style: TextStyle(
                  fontFamily: 'Circular',
                  fontSize: 14,
                  color: Color(0xfff2e7fe).withOpacity(0.8),
                  ),),
                  );
                },
              );
            }),
      ),
    );
  }

  Widget _buildAppBar() {
    Color appBarIconsColor = Color(0xFF292929);
    return AppBar(
      shadowColor: Color(0xff292929),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Color(0xffBB86Fe)),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Icon(Icons.more_horiz, color: Color(0xffBB86Fe), size: 28),
        )
      ],
      brightness: Brightness.light,
      backgroundColor: Color(0xFF292929),
      elevation: 10.0,
      title: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          'Log Files',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Circular',
            fontSize: 20,
            letterSpacing: 0.5,
            color: Color(0xffbb86fe),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
