import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/ui/Profile_Screen.dart';
import 'package:mobidthrift/ui/login/Login_page.dart';
import 'package:mobidthrift/ui/login/Verify_Page.dart';
import 'package:mobidthrift/utils/utils.dart';

import '../../constants/App_texts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance.collection('users');
  late bool _loading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  var myFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
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
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Form(
                key: myFormKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Text('Create New Account',
                          style: TextStyle(color: Colors.white70)),
                      Text('Fill the form to continue',
                          style: TextStyle(color: Colors.white70)),
                      SizedBox(
                        height: 20,
                      ),
                      AppWidgets().myTextFormField(
                        hintText: 'Enter your Full Name',
                        labelText: 'Full Name',
                        controller: _nameController,
                        validator: (String? txt) {
                          if (txt == null || txt.isEmpty) {
                            return "Please provide your name";
                          }
                          // islamiat = int.parse(txt);
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AppWidgets().myTextFormField(
                        hintText: 'Enter your Email',
                        myType: TextInputType.emailAddress,
                        labelText: 'Email',
                        controller: _emailController,
                        validator: (String? txt) {
                          bool emailValid = RegExp(
                                  r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                              .hasMatch(txt!);
                          if (txt == null || txt.isEmpty) {
                            return "Please provide your Email";
                          }
                          if (emailValid) {
                            return null;
                          }
                          return "Your Email is Wrong";
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AppWidgets().myTextFormField(
                        hintText: 'Enter your Address',
                        labelText: 'Address',
                        controller: _addressController,
                        validator: (String? txt) {
                          if (txt == null || txt.isEmpty) {
                            return "Please provide your Address";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AppWidgets().myTextFormField(
                        hintText: 'Enter your Phone Number',
                        myType: TextInputType.phone,
                        labelText: 'Phone Number',
                        controller: _phoneNumberController,
                        validator: (String? txt) {
                          if (txt == null || txt.isEmpty) {
                            return "Please provide Phone Number";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AppWidgets().myTextFormField(
                        obscureText: true,
                        hintText: 'Enter your Password',
                        labelText: 'Password',
                        controller: _passwordController,
                        validator: (String? txt) {
                          if (txt == null || txt.isEmpty) {
                            return "Please provide Password";
                          } else if (txt.length >= 6) {
                            return null;
                          } else {
                            return "Password must be 6 letters";
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AppWidgets().myElevatedBTN(
                          loading: _loading,
                          onPressed: () {
                            if (myFormKey.currentState!.validate()) {
//Sign up fucntionI
                              mySignUp();
                            } // try
                          },
                          btnText: "SignUp"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an Account?',
                              style: TextStyle(color: Colors.white70)),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                              child: Text('LogIn Now'))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  mySignUp() async {
    setState(() {
      _loading = true;
    });
    await _firebaseAuth
        .createUserWithEmailAndPassword(
            email: _emailController.text.toString().trim(),
            password: _passwordController.text.toString())
        .then((value) {
      setState(() {
        _loading = false;
      });

      _firebaseAuth.currentUser
          ?.updateDisplayName(_nameController.text.toString().toTitleCase());

      _fireStore.doc(_firebaseAuth.currentUser?.uid.toString()).set({
        'Uid': _firebaseAuth.currentUser?.uid.toString(),
        'Name': _nameController.text,
        'Email': _emailController.text.trim(),
        'Address': _addressController.text,
        'Phone_Number': _phoneNumberController.text,
        'Profile_Image': "",
      });
      // _firebaseAuth.currentUser?.sendEmailVerification();

      // _firebaseAuth.currentUser?.emailVerified;

      // _firebaseAuth.sendSignInLinkToEmail(email: _emailController.text.toString().trim(), actionCodeSettings: ActionCodeSettings(
      //     url: "https://example.page.link/cYk9",
      //     androidPackageName: "com.example.app",
      //     iOSBundleId: "com.example.app",
      //     handleCodeInApp: true,
      //     androidMinimumVersion: "16",
      //     androidInstallApp: true),);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => VerifyPage()));
    }).onError((error, stackTrace) {
      Utils.flutterToast(error.toString());
      setState(() {
        _loading = false;
      });
    });
  }
}

class myTextFormField extends StatelessWidget {
  var hintText = '';
  var labelText = '';
  Color textColor;
  Color enBorderSideColor;
  Color borderSideColor;
  var enBorderRadius;
  var borderRadius;
  Color fillColor;
  Color hintColor;
  Color labelColor;

  myTextFormField(
      {required this.hintText,
      required this.labelText,
      this.textColor = Colors.white,
      this.enBorderSideColor = Colors.white12,
      this.borderSideColor = Colors.red,
      this.enBorderRadius = 20.0,
      this.borderRadius = 20.0,
      this.fillColor = Colors.white12,
      this.hintColor = Colors.white38,
      this.labelColor = Colors.white70,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: enBorderSideColor, width: 2.0),
          borderRadius: BorderRadius.circular(enBorderRadius),
        ),
        fillColor: fillColor,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: hintColor),
        label: Text(labelText!),
        labelStyle: new TextStyle(color: labelColor),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderSideColor, width: 2.0),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
