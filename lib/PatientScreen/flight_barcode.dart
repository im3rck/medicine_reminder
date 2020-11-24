import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'patientMain.dart';

class FlightBarcode extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: RawMaterialButton(
          shape: RoundedRectangleBorder(),
          fillColor: Color(0xffBB86FC),
          splashColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Icon(),
                Image.asset('images/pill.png'),
                Text('Mark As Taken'),
              ],
            ),
          ),

          //child: Text('Mark As Taken'),
          onPressed: (){},
        ),
      ));
}
