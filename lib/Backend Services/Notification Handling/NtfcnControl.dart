import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/LaunchScreen/demo.dart';

class Message_Handler extends StatefulWidget {
  @override
  _Message_HandlerState createState() => _Message_HandlerState();
}

class _Message_HandlerState extends State<Message_Handler> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState(){
    super.initState();

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        
        final GooeySB = SnackBar(
            content: Text('Hello'),
          action: SnackBarAction(
            label: ('goto gooey edge'),
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GooeyEdgeDemo()));
            },
          ),
        );
        Scaffold.of(context).showSnackBar(GooeySB);
      },

      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Notify'),
        ),
      )
    );
  }
}

