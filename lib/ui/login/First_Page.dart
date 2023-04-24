import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_colors.dart';
import 'package:mobidthrift/ui/login/Login_page.dart';
import 'package:mobidthrift/ui/login/Signup_page.dart';

import '../../constants/App_texts.dart';
import '../../constants/App_widgets.dart';
import '../bottom_navigation_bar.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "${AppTexts.appName}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      extendBodyBehindAppBar: true,
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
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 33,
                  ),

                  SizedBox(
                    height: 33,
                  ),
                  AppWidgets().myElevatedBTN(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomNavigationBar()));
                      },
                      btnText: 'Continue without Login'),

                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.pushReplacement(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => MyHomePage()));
                  //   },
                  //   child: Text('Continue without Login'),
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: AppColors.elevatedButtonColor,
                  //     minimumSize: Size(200, 40),
                  //   ),
                  // ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.elevatedButtonColor,
                      minimumSize: Size(200, 40),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()));
                    },
                    child: Text('SignUp'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.elevatedButtonColor,
                      minimumSize: Size(200, 40),
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
}
