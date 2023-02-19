import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/ui/login/Login_page.dart';
import 'package:mobidthrift/utils/utils.dart';

import '../../constants/App_texts.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _myFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

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

          Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Enter your Email!', style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 20,),
                  Form(
                    key: _myFormKey,
                    child: AppWidgets().myTextFormField(hintText: 'Enter Email',
                        validator: (String? txt) {
                      bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(txt!);
                      if (txt == null || txt.isEmpty) {

                        return "Please provide your Email";

                      }
                      if(emailValid){
                        return null;

                      }
                      return "Your Email is Wrong";
                    }
                    , myType: TextInputType.emailAddress, labelText: 'Email', controller: _emailController),
                  ),
                  SizedBox(height: 20,),
                  AppWidgets().myElevatedBTN(loading: _loading, onPressed: (){

                    if(_myFormKey.currentState!.validate()) {
                      setState(() {
                        _loading = true;
                      });
                      _auth.sendPasswordResetEmail(email: _emailController.text
                          .toString().trim()).then((value) {
                        setState(() {
                          _loading = false;
                          _emailController.clear();
                        });
                        Utils.flutterToast('Email has been sent please change your password');

                      }).onError((error, stackTrace) {
                        setState(() {
                          _loading = false;
                        });
                        Utils.flutterToast(error.toString());
                      });
                    }
                  }, btnText: 'Send Varification'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an Account?', style: TextStyle(color: Colors.white70)),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          }, child: Text('LogIn Now'))
                    ],
                  )
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
