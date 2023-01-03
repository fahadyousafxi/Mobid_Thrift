import 'package:flutter/material.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar().mySimpleAppBar(context, title: 'Contact Us'),
      body: Center(child: Text('Contact information of the Business'),),
    );
  }
}
