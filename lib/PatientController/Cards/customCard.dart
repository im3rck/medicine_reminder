import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customCard(icon,String _title, String _subtitle){
  return Card(
    elevation: 10.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    margin: EdgeInsets.all(7.0),
    color: Color(0xffbb86fc),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xff121212),
          border: Border.all(
              color: Color(0xffBB86FC),
              width: 1
          ),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
          BoxShadow(
          color: Color(0xff121212).withOpacity(0.2),
      spreadRadius: 3,
      blurRadius: 4,
      offset: Offset(0, 3),
    ),
    ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(icon, color: Color(0xfff2e7fe), size: 30.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_title,style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Circular',
                  fontWeight: FontWeight.bold,
                  color: Color(0xfff2e7fe),
                  height: 2,
                ),),
                SizedBox(height: 1.0,),
                Text(_subtitle, style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Circular',
                  color: Color(0xfff2e7fe).withOpacity(0.6),
                  height: 2,
                ),)
              ],
            )
          ],
        ),
      ),
    ),
  );
}