import 'package:flutter/material.dart';


class AddMeds extends StatefulWidget {
  _AddMeds createState() => _AddMeds();
}

class _AddMeds extends State<AddMeds> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          itemBuilder: (context, index) {
            return Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width) *
                        .9,
                    child: TextField(
                      onSubmitted: (value) {
                      },
                      // controller: emailController,
                      style:
                      TextStyle(color: Color(0xfff2e7fe)),
                      decoration: InputDecoration(
                          labelText: 'Medicine Name',
                          labelStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Circular',
                            color: Color(0xfff2e7fe)
                                .withOpacity(0.6),
                            height: 2,
                          ),
                          filled: true,
                          fillColor: Color(0xff121212),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 0),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xfff2e7fe)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xffBB86fc)),
                            //  when the TextFormField in focused
                          ),
                          border: UnderlineInputBorder()),
                    ),
                  )
                ]);
          },
          itemCount: 3
    );
  }
}