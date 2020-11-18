import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/Enhancements/PreviewAuth.dart';
import 'package:medicine_reminder/Widgets/variables.dart';

bool _passwordVisible;

class SignUp2 extends StatefulWidget {
  @override
  _SignUp2State createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController userNameController = TextEditingController();

    registerUser(){
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text)
          .then((signeduser) {
        userCollection.doc(signeduser.user.uid).set({
          'username': userNameController.text,
          'password': passwordController.text,
          'email': emailController.text,
          'uid': signeduser.user.uid,
        });
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AuthPage()));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        Text(
          "Sign up with",
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
          height: 16,
        ),
        TextFormField(

          validator: (val){
              return val.isEmpty || val.length < 4 ? "Invalid Username":null;
            },
            controller: userNameController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person, color: Color(0xFFf2e7fe),),
            labelText: 'Username',
            labelStyle: TextStyle(
              fontSize: 16,
              color: Color(0xfff2e7fe),
              fontWeight: FontWeight.bold,
            ),
            filled: true,
            fillColor: Color(0xff121212),
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
          height: 16,
        ),

        TextFormField(
          keyboardType: TextInputType.emailAddress,
          validator: (val){
            return RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(val) ? null : "Invalid Email";
          },
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'you@example.com',
            prefixIcon: Icon(Icons.email, color: Color(0xFFf2e7fe)),
            labelStyle: TextStyle(
              fontSize: 16,
              color: Color(0xFFf2e7fe),
              fontWeight: FontWeight.bold,
            ),
            filled: true,
            fillColor: Color(0xff121212),
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
          height: 16,
        ),

        TextFormField(
          validator: (val){
            if(val.length<6){
              return "Enter a stronger Password";
            }
            else {
              return null;
            }
          },
          keyboardType: TextInputType.text,
          controller: passwordController,
          obscureText: !_passwordVisible,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock, color: Color(0xFFf2e7fe),),
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
            labelStyle: TextStyle(
              fontSize: 16,
              color: Color(0xFFf2e7fe),
              fontWeight: FontWeight.bold,
            ),
            filled: true,
            fillColor: Color(0xff121212),
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
          height: 24,
        ),

          InkWell(
            onTap: ()=>registerUser(),
            child: Container(
            height: 40,
            decoration: BoxDecoration(

              color: Color(0xff121212),
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
              child:  Center(
                child: Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF2e7fe),
                ),
              ),
            ),
          ),
        ),

        SizedBox(
          height: 24,
        ),
      ],
    );
  }
}