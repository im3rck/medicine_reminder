import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart';

class ScheduleCell extends StatelessWidget {
  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Color(0xFF121212),
          alignment: Alignment.center,
          child: SimpleFoldingCell(key: _foldingCellKey,
            frontWidget: _buildFrontWidget(),
            innerTopWidget: _buildInnerTopWidget(),
            innerBottomWidget: _buildInnerBottomWidget(),
          cellSize: Size(MediaQuery.of(context).size.width, 125),
          padding: EdgeInsets.all(15),
          animationDuration: Duration(milliseconds: 300),
          borderRadius: 10,
          onOpen: () => print('cell opened'),
          onClose: () => print('cell closed')),
      ),);
  }

  Widget _buildFrontWidget() {
    return  InkWell(
      onTap: () {_foldingCellKey?.currentState?.toggleFold();},
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xFF292929),
            border: Border.all(
            color: Color(0xffBB86FC),
              width: 1
          ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Custom",
                  style: TextStyle(
                      color: Color(0xFFf2e7fe),
                      fontFamily: 'OpenSans',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800)),
            ],
          )),
    );
  }

  Widget _buildInnerTopWidget() {
    return Container(
        decoration: BoxDecoration(
          color: Color(0xFF292929),
          border: Border.all(
              color: Color(0xffBB86FC),
              width: 1
          ),
        ),
        alignment: Alignment.center,
        child: Text("TITLE",
            style: TextStyle(
                color: Color(0xFFf2e7fe),
                fontFamily: 'OpenSans',
                fontSize: 20.0,
                fontWeight: FontWeight.w800)));
  }

  Widget _buildInnerBottomWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF292929),
        border: Border.all(
            color: Color(0xffBB86FC),
            width: 1
        ),
      ),
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: FlatButton(
          onPressed: () => _foldingCellKey?.currentState?.toggleFold(),
          child: Text(
            "Close",
          ),
          textColor: Colors.white,
          color: Colors.indigoAccent,
          splashColor: Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }
}