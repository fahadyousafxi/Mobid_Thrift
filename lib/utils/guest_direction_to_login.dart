import 'package:flutter/material.dart';
import 'package:mobidthrift/ui/login/Login_page.dart';

class GuestDirectionToLogin {
  Future guestDirectionToLogin(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Please Login',
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        content: Text(
          'Do you want to login?',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage())),
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
