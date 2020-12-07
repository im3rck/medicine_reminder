import 'package:flutter/material.dart';
import 'package:medicine_reminder/PatientList/Settings/Settings_UI.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<ProfilePage> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff292929),
      appBar: AppBar(
        backgroundColor: Color(0xff121212),
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xffbb86fe),
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Color(0xffbb86fe),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => SettingsPage()));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Circular',
                  fontWeight: FontWeight.w600,
                  color: Color(0xffbb86fe),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width) * .3,
                      height: (MediaQuery.of(context).size.height) * .15,
                      // decoration: BoxDecoration(
                      //     border: Border.all(
                      //         width: 4,
                      //         color: Theme.of(context).scaffoldBackgroundColor),
                      //     boxShadow: [
                      //       BoxShadow(
                      //           spreadRadius: 2,
                      //           blurRadius: 10,
                      //           color: Colors.black.withOpacity(0.1),
                      //           offset: Offset(0, 10))
                      //     ],
                      //     shape: BoxShape.circle,
                      //     ),
                      child: Image.asset(
                        'assets/images/usertrans.png',
                        height: (MediaQuery.of(context).size.height) * .15,
                        width: (MediaQuery.of(context).size.height) * .15,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Color(0xff292929),
                            ),
                            color: Color(0xff323232),
                          ),
                          child: Icon(
                            Icons.add_a_photo,
                            color: Color(0xffbb86fe),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTextField("Full Name", "Jain Alex", false),
              buildTextField("E-mail", "alexd@gmail.com", false),
              buildTextField("Password", "********", true),
              buildTextField("Location", "TVM, Kerala", false),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff292929),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: NeumorphicButton(
                      provideHapticFeedback: true,
                      drawSurfaceAboveChild: true,
                      margin: EdgeInsets.all(2.0),
                      padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height)*.03, bottom: (MediaQuery.of(context).size.height)*.03,left: (MediaQuery.of(context).size.width)*.1,right: (MediaQuery.of(context).size.width)*.1),
                      pressed: true,

                      onPressed: (){
                        //openLoginPage();
                      },
                      style: NeumorphicStyle(
                        border: NeumorphicBorder(
                            isEnabled: true,
                            color: Color(0xff292929)
                        ),
                        depth: 8,
                        boxShape: NeumorphicBoxShape.stadium(),
                        color: Color(0xff292929),
                        shadowDarkColor: Color(0xff121212),
                        shadowLightColor: Colors.grey[800],
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            fontFamily: 'Circular',
                            color: Color(0xfff2e7fe),
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0)
                      ),
                    ),
                  ),Container(
                    decoration: BoxDecoration(
                      color: Color(0xff292929),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: NeumorphicButton(
                      provideHapticFeedback: true,
                      drawSurfaceAboveChild: true,
                      margin: EdgeInsets.all(2.0),
                      padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height)*.03, bottom: (MediaQuery.of(context).size.height)*.03,left: (MediaQuery.of(context).size.width)*.1,right: (MediaQuery.of(context).size.width)*.1),
                      pressed: true,

                      onPressed: (){
                       // openLoginPage();
                      },
                      style: NeumorphicStyle(
                        border: NeumorphicBorder(
                            isEnabled: true,
                            color: Color(0xff292929)
                        ),
                        depth: 8,
                        boxShape: NeumorphicBoxShape.stadium(),
                        color: Color(0xff292929),
                        shadowDarkColor: Color(0xff121212),
                        shadowLightColor: Colors.grey[800],
                      ),
                      child: Text(
                        "  Save  ",
                        style: TextStyle(
                            fontFamily: 'Circular',
                            color: Color(0xfff2e7fe),
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0)
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Color(0xfff2e7fe),
                  ),
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 15,
            fontFamily: 'Circular',
            fontWeight: FontWeight.w600,
            color: Color(0xffbb86fe),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontFamily: 'Circular',
            fontWeight: FontWeight.w500,
            color: Color(0xfff2e7fe),
          ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xfff2e7fe)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffBB86fc)),
              //  when the TextFormField in focused
            ),
            border: UnderlineInputBorder()
        ),
      ),
    );
  }
}
