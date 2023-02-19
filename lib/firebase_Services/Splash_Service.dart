import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/ui/My_Home_Page.dart';
import 'package:mobidthrift/ui/login/First_Page.dart';

import '../ui/login/Verify_Page.dart';

class SplashService {
  void isLogin(context) {
    final _auth = FirebaseAuth.instance;
    final _user = _auth.currentUser;

    if(_user != null){
      Timer(
        Duration(seconds: 3),
            () {
              if(_auth.currentUser!.emailVerified){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage()));
              } else {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VerifyPage()));
              }
            }
      );
    } else{
      Timer(
        Duration(seconds: 3),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => FirstPage())),
      );
    }

  }
}
