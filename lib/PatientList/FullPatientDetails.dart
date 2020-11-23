import 'package:flutter/material.dart';
import 'package:medicine_reminder/Backend%20Services/Image%20Handling/ImgUploadFetch.dart';
import 'package:medicine_reminder/LaunchScreen/demo.dart';
import 'package:medicine_reminder/PatientList/configuration.dart';

/*
class FullPatientDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Hero(
                          tag: 1, child: Image.asset('assets/images/cat.png')),
                    ),
                  ),
                  color: Colors.blueGrey[300],
                ),
              ),
              Expanded(
                child: Container(
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(20, 70, 20, 150),
                    child: Text(
                      "Full Patient Details ...",
                      style: new TextStyle(
                          fontFamily: 'Circular',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                  color: Colors.white,
                ),
              )
            ],
          )),
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  IconButton(icon: Icon(Icons.upload_file), onPressed: () {
                    Future<String> Img = uploadImage();
                  })
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: double.infinity,
              height: 100,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadowList,
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                "Important notes go here ...",
                style: new TextStyle(
                    fontFamily: 'Circular',
                    fontWeight: FontWeight.bold,
                    fontSize: 23.0),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 120,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.push(context, SlideRightRoute(page: FullPatientDetails()));
                    },
                  ),
                  Expanded(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: primaryGreen,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        'Adoption',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      Navigator.push(context, SlideLeftRoute(page: FullPatientDetails()));
                    },
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
*/

class FullPatientDetails extends StatefulWidget {
  @override
  _FullPatientDetailsState createState() => _FullPatientDetailsState();
}

class _FullPatientDetailsState extends State<FullPatientDetails> {

  String imgUrl='https://picsum.photos/250?image=9';

  String imageHandling(){
    setState(() {
      imgUrl = uploadImage();
    });
  }


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Hero(
                              tag: 1, child: (Image.network(imgUrl))),//Image.asset('assets/images/cat.png')),
                        ),
                      ),
                      color: Colors.blueGrey[300],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(20, 70, 20, 150),
                        child: Text(
                          "Full Patient Details ...",
                          style: new TextStyle(
                              fontFamily: 'Circular',
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ),
                      color: Colors.white,
                    ),
                  )
                ],
              )),
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  IconButton(icon: Icon(Icons.upload_file), onPressed: () {
                   // Navigator.push(context, MaterialPageRoute(builder: (context) => GooeyEdgeDemo()));
                  imageHandling();
                  })
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: double.infinity,
              height: 100,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadowList,
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                "Important notes go here ...",
                style: new TextStyle(
                    fontFamily: 'Circular',
                    fontWeight: FontWeight.bold,
                    fontSize: 23.0),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 120,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.push(context, SlideRightRoute(page: FullPatientDetails()));
                    },
                  ),
                  Expanded(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: primaryGreen,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                            'Adoption',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      Navigator.push(context, SlideLeftRoute(page: FullPatientDetails()));
                    },
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )),
            ),
          )
        ],
      ),
    );
  }
}


class SlideLeftRoute extends PageRouteBuilder {
  final Widget page;
  SlideLeftRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}