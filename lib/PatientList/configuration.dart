import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey[300], blurRadius: 30, offset: Offset(0, 10))
];

List<Map> drawerItems=[
  {
    'icon': FontAwesomeIcons.plus,
    'title' : 'Add Patient',
    'index': 0,
  },
  {
    'icon': Icons.favorite,
    'title' : 'Self Reminder',
    'index': 1,
  },
  {
    'icon': FontAwesomeIcons.clinicMedical,
    'title' : 'Stores Nearby',
    'index': 2,
  },
  {
    'icon': FontAwesomeIcons.userAlt,
    'title' : 'Profile',
    'index': 3,
  },
  {
    'icon': Icons.settings,
    'title' : 'Settings',
    'index': 4,
  },
];