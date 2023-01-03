import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/ui/login/Login_page.dart';

import '../../constants/App_texts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 100,),
                      Text('Create New Account'),
                      Text('Fill the form to continue'),

                      SizedBox(height: 20,),
                      AppWidgets().myTextFormField(hintText: 'Enter your Full Name', labelText: 'Full Name'),
                      SizedBox(height: 20,),

                      AppWidgets().myTextFormField(hintText: 'Enter your Email', labelText: 'Email'),
                      SizedBox(height: 20,),

                      AppWidgets().myTextFormField(hintText: 'Enter your Address', labelText: 'Address'),
                      SizedBox(height: 20,),

                      AppWidgets().myTextFormField(hintText: 'Enter your Phone Number', labelText: 'Phone Number'),
                      SizedBox(height: 20,),

                      AppWidgets().myTextFormField(hintText: 'Enter your Password', labelText: 'Password'),
                      SizedBox(height: 20,),

                      AppWidgets().myElevatedBTN(onPressed: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      }, btnText: "SignUp"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an Account?'),
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
              ),
            ),
          )

        ],
      ),
    );
  }
}
