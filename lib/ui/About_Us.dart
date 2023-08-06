import 'package:flutter/material.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar().mySimpleAppBar(context, title: 'About Us'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8),
        child: Center(
          child: Text(
            'On the Mobidthrift app, you can purchase used phones, smartwatches, tablets, laptops, desktops, accessories, and parts. Additionally, the app allows you to trade in your products from the aforementioned categories.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
