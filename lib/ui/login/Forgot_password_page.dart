import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_button.dart';

import '../../constants/App_texts.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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

          Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Enter your Email!'),
                  SizedBox(height: 20,),
                  AppButton().myTextFormField(hintText: 'Enter Email', labelText: 'Email'),
                  SizedBox(height: 20,),
                  AppButton().myElevatedBTN(onPressed: (){}, btnText: 'Send Varification')
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
