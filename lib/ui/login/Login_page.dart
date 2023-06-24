import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/ui/login/Forgot_password_page.dart';
import 'package:mobidthrift/ui/login/Signup_page.dart';
import 'package:provider/provider.dart';

import '../../constants/App_texts.dart';
import '../../providers/all_users_provider.dart';
import '../../utils/utils.dart';
import '../bottom_navigation_bar.dart';
import 'Verify_Page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance.collection('users');

  late bool _loading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  var _myFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  AllUsersProvider usersProvider = AllUsersProvider();

  @override
  void initState() {
    AllUsersProvider userProvider = Provider.of(context, listen: false);
    userProvider.getUsersData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    usersProvider = Provider.of(context);
    usersProvider.getUsersData();
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                'Exit App',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
              content: Text(
                'Do you want to exit an App?',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      // () {
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => const LoginPage()),
      //     (Route route) => false);
      // return false as Future<bool>;
      // },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "${AppTexts.appName}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          automaticallyImplyLeading: false,
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
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Login to your Account',
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                        key: _myFormKey,
                        child: Column(
                          children: [
                            AppWidgets().myTextFormField(
                              hintText: 'Enter Email',
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
                              obscureText: true,
                              hintText: 'Enter Password',
                              labelText: 'Password',
                              controller: _passwordController,
                              validator: (String? txt) {
                                if (txt == null || txt.isEmpty) {
                                  return "Please provide password";
                                }

                                return null;
                              },
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgotPasswordPage()));
                                    },
                                    child: Text('Forgot Password'))
                              ],
                            ),
                            AppWidgets().myElevatedBTN(
                                loading: _loading,
                                onPressed: () async {
                                  if (_myFormKey.currentState!.validate()) {
                                    if (await checkEmailInDocuments(
                                        _emailController.text)) {
                                      myLogin();
                                    } else {
                                      Utils.flutterToast(
                                          'The Email ${_emailController.text} data is Not found as a user');
                                    }
                                  }
                                },
                                btnText: 'Login'),
                            // AppButton().myElevatedBTN(onPressed: (){}, btnText: 'login With Google'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Don’t have an Account?',
                                    style: TextStyle(color: Colors.white70)),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignupPage()));
                                    },
                                    child: Text('SignUp Now'))
                              ],
                            )
                          ],
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// checkEmailInDocuments

  Future<bool> checkEmailInDocuments(String email) async {
    bool emailFound = false;

    for (var document in usersProvider.getUsersDataList) {
      // Assuming the email field is called 'email' within each document
      String userEmail = email;

      if (userEmail == document.email) {
        print('Email found in document: ${userEmail}');
        emailFound = true;
        // Do additional actions if needed
        break;
      }
    }

    if (!emailFound) {
      print('Email not found in any document.');
      // Perform alternative actions or show appropriate message
    }
    return emailFound;
  }

  /// myLogin
  myLogin() {
    setState(() {
      _loading = true;
    });

    _firebaseAuth
        .signInWithEmailAndPassword(
            email: _emailController.text.toString().trim(),
            password: _passwordController.text.toString())
        .then((value) {
      setState(() {
        _loading = false;
      });
      if (_firebaseAuth.currentUser!.emailVerified) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => CustomNavigationBar()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => VerifyPage()));
      }
    }).onError((error, stackTrace) {
      Utils.flutterToast(error.toString());
      setState(() {
        _loading = false;
      });
    });
  }
}
