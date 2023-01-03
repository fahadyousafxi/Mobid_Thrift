import 'package:flutter/material.dart';
import 'package:mobidthrift/ui/My_Home_Page.dart';
import 'package:mobidthrift/ui/login/First_Page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobid Thrift',
      // theme: ThemeData.dark(
      //
      //   // primarySwatch: Colors.blue,
      //
      // ).copyWith(scaffoldBackgroundColor: Colors.white, primaryColor: Colors.white),
      theme: ThemeData(
          primaryColor: Colors.black
      ),
      home: const FirstPage(),
    );
  }
}

