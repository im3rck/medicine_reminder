import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customCard(){
  return Card(
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xfff4a261)
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(Icons.ac_unit),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Text 1"),
                SizedBox(height: 5.0,),
                Text("Text 2")
              ],
            )
          ],
        ),
      ),
    ),
  );
}