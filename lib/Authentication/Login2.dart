import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/PatientList/PhasePage.dart';

class Login2 extends StatefulWidget {
  @override
  _Login2State createState() => _Login2State();
}
bool _passwordVisible;

class _Login2State extends State<Login2> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  void initState() {
    _passwordVisible = false;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 80,
        ),
        Text(
          "Welcome to",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xffBB86FC),
            height: 2,
          ),
        ),
        Text(
          "MedReminder",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xffBB86FC),
            letterSpacing: 2,
            height: 1,
          ),
        ),
        SizedBox(
          height: 46,
        ),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(
              Icons.email,
              color: Color(0xffF2E7FE),
            ),
            labelStyle: TextStyle(
              fontSize: 16,
              color: Color(0xffF2E7FE),
              fontWeight: FontWeight.bold,
            ),
            filled: true,
            fillColor: Color(0x292929),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xfff2e7fe)), ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffBB86fc)),
                //  when the TextFormField in focused
              ) ,
              border: UnderlineInputBorder(
              )
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          keyboardType: TextInputType.text,
          obscureText: !_passwordVisible,
          controller: passwordController,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(
              Icons.lock,
              color: Color(0xffF2E7FE),
            ),
            labelStyle: TextStyle(
              fontSize: 16,
              color: Color(0xffF2E7FE),
              fontWeight: FontWeight.bold,
            ),
            filled: true,
            fillColor: Color(0xff292929),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Color(0xFFf2e7fe),
              ),
              onPressed: (){
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xfff2e7fe)), ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffBB86fc)),
                //  when the TextFormField in focused
              ) ,
              border: UnderlineInputBorder(
              )
          ),
        ),
        SizedBox(
          height: 26,
        ),
        InkWell(
          onTap: () {
            try {
              FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => PhasePage()));
            } catch (e) {
              SnackBar snackBar =
                  SnackBar(content: Text("Invalid Credentials"));
              Scaffold.of(context).showSnackBar(snackBar);
            }
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xff292929),
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              border: Border.all(
                color: Color(0xffBB86FC),
                width: 1
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
              child: Text(
                "Log In",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffF2E7FE),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Forgot Password?",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF2E7FE),
            height: 1,
          ),
        ),
      ],
    );
  }
}
