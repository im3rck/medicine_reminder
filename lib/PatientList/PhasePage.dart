import 'package:flutter/material.dart';

import 'package:medicine_reminder/PatientList/HomeScreen.dart';
import 'package:medicine_reminder/PatientList/DrawerScreen.dart';

class PhasePage extends StatefulWidget {
  @override
  _PhasePageState createState() => _PhasePageState();
}

class _PhasePageState extends State<PhasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [DrawerScreen(), HomeScreen()],
      ),
    );
  }
}
