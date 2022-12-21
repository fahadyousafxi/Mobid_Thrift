import 'package:flutter/material.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Stack(
         children: [
           Container(
             width: double.infinity,
             height: double.infinity,
             child: Image(
               image: AssetImage("assets/images/backgroundimage.png"),
               fit: BoxFit.cover,
             ),
           ),

           Center(
             child: Text('Home Page'),
           )

         ],
       ),
    );
  }
}
