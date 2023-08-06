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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8),
        child: Center(
          child: Text(
              '''For any inquiries or assistance, please feel free to reach out to us:

Contact Number: 0308-4444666
Email: samikhan@gmail.com

We are available to help you with any questions or concerns you may have regarding our services and products. Feel free to contact us at your convenience.
        '''),
        ),
      ),
    );
  }
}
