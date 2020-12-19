import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:medicine_reminder/Enhancements/FadeAnimation/FadeAnimation.dart';
import 'package:medicine_reminder/PatientController/Cards/Cards.dart';
import 'package:medicine_reminder/PatientList/PhasePage.dart';
import 'package:medicine_reminder/Enhancements/ConfirmButton/SlideButton.dart';


class PatientAddPage extends StatefulWidget {
  PatientAddPage(this.token);

  final String token;

  @override
  _PatientAddPageState createState() => _PatientAddPageState();
}

class _PatientAddPageState extends State<PatientAddPage>  with TickerProviderStateMixin {
  AnimationController _submitAnimationController;
  final style = TextStyle(
      color: Color(0xfff2e7fe),
      fontWeight: FontWeight.bold,
      fontFamily: 'Circular',
      fontSize: 25.0);

  @override
  void initState() {
    super.initState();
    _submitAnimationController = AnimationController(
       vsync: this,
      duration: Duration(milliseconds: 1),
    );
    _submitAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _goToResultPage().then((_) => _submitAnimationController.reset());
      }
    });
  }
  void dispose() {
    _submitAnimationController.dispose();
    super.dispose();
  }
  void onPacmanSubmit() {
    _submitAnimationController.forward();
  }

  _goToResultPage() async {
    return Navigator.of(context).push(FadeRoute(
      builder: (context) => PhasePage()
    ));
  }
@override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          shadowColor: Color(0xff292929),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Color(0xffBB86Fe)),
            onPressed: () {
              Navigator.of(context).push(FadeRoute(
                  builder: (context) => PhasePage()
              ));
            },
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Icon(Icons.more_horiz, color: Color(0xff292929), size: 28),
            )
          ],
          brightness: Brightness.light,
          backgroundColor: Color(0xff292929),
          elevation: 10.0,
          title: Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              'New Convalescent ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Circular',
                fontSize: 20,
                letterSpacing: 0.5,
                color: Color(0xfff2e7fe),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
           // SizedBox(height: (MediaQuery.of(context).size.height)*.01,),
            Container(
               // height: (MediaQuery.of(context).size.height) * .8,
                child: Cards(widget.token)),
           SizedBox(height: (MediaQuery.of(context).size.height)*.01,),
            Container(
              margin: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height)*.01,),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width)*.02),
                height: (MediaQuery.of(context).size.height)*.1,
                decoration: BoxDecoration(
                  color: Color(0xff121212),
                  border: Border.all(
                      color: Color(0xffbb86fe),
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
                child: PacmanSlider(
                  submitAnimationController: _submitAnimationController,
                  onSubmit: onPacmanSubmit,
                ),
              ),
            )
          ],
        ),

      ),
    );
  }
}
