import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlightBarcode extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0), color: Color(0xffbb86fe)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 40,
            width: (MediaQuery.of(context).size.width) * .8,
            decoration: BoxDecoration(
              color: Color(0xffbb86fe),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffF292929).withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Icon(),
                  Image.asset('images/pill.png'),
                  Text('Mark As Taken'),
                ],
              ),
            ),
          ),
        ),

        // RawMaterialButton(
        //   shape: RoundedRectangleBorder(),
        //   fillColor: Color(0xffBB86Fe),
        //   splashColor: Colors.black,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(
        //       vertical: 8.0,
        //       horizontal: 10.0,
        //     ),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         //Icon(),
        //         Image.asset('images/pill.png'),
        //         Text('Mark As Taken'),
        //       ],
        //     ),
        //   ),
        //
        //   //child: Text('Mark As Taken'),
        //   onPressed: (){},
        // ),
      ));
}
