import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:medicine_reminder/Enhancements/PreviewAuth.dart';
import 'package:medicine_reminder/LaunchScreen/GooeyEdge.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Circular'),
      home: onboarding(),
    );
  }
}

class onboarding extends StatefulWidget {
  @override
  _onboardingState createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  int currentPage = 0; // number for pointer
  PageController _pageController = new PageController(
      initialPage: 0, //number for page
      keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff292929),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5.0),
                color: Color(0xff292929),
                
                height: MediaQuery.of(context).size.height * 0.6,
                child: PageView(
                  controller: _pageController,
                  
                  //scrollDirection: Axis.vertical,
                  children: [
                    onBoardPage("obm", "Welcome", 1),
                    onBoardPage("obc", "Custodian", 2),
                    onBoardPage("obp", "Convalescent", 3),
                  ],
                  onPageChanged: (value) => {setCurrentPage(value)},
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) => getIndicator(index)),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              //bottom half
              margin: EdgeInsets.only(top: 20),
              height: 290, // from bottom of page
              // color: Color(0xff292929),
              //width: MediaQuery.of(context).size.width,
              /*decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('asset/image/path1.png'),
                      fit: BoxFit.fill
                  )
              ),*/
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      margin: EdgeInsets.all(5.0),
                      padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height)*.03, bottom: (MediaQuery.of(context).size.height)*.03,left: (MediaQuery.of(context).size.width)*.1,right: (MediaQuery.of(context).size.width)*.1),
                      pressed: true,

                      onPressed: (){
                          openLoginPage();
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
                                 " Get Started",
                                 style: TextStyle(
                                     color: Color(0xffBB86FC), fontSize: 16),
                               ),
                        ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  AnimatedContainer getIndicator(int pageNo) {
    //return Scaffold(
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      //the number controls speed
      height: 10,
      width: (currentPage == pageNo) ? 20 : 10,
      //color: _color,

      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color:
              (currentPage == pageNo) ? Color(0xffBB86FC) : Color(0xffF2E7FE)),
    );
    //);
  }

  Column onBoardPage(String img, String title, int num) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          height: (MediaQuery.of(context).size.height) * .2,
          width: MediaQuery.of(context).size.width / 2,
          padding: EdgeInsets.all(50),
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('assets/images/$img.png'))),
        ),
        SizedBox(
          height: 50,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            title,
            style: TextStyle(
                color: Color(0xffBB86FC),
                fontSize: 30,
                fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: Text(
            (num == 1)
                ? "MedReminder"
                : (num == 2)
                    ? "Custodian "
                    : "Convalescent ",
            style: TextStyle(fontSize: 16, color: Color(0xffF2E7FE)),
            textAlign: TextAlign.center,
          ),
          //Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text
        )
      ],
    );
  }

  setCurrentPage(int value) {
    currentPage = value;
    setState(() {});
  }

  openLoginPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => GooeyEdge()));
  }
}
