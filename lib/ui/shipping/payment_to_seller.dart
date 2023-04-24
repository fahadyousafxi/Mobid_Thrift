import 'package:flutter/material.dart';

class PaymentToSeller extends StatefulWidget {
  const PaymentToSeller({Key? key}) : super(key: key);

  @override
  State<PaymentToSeller> createState() => _PaymentToSellerState();
}

class _PaymentToSellerState extends State<PaymentToSeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('MobidThrift'),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Container(
        height: 222,
        width: 33,
        color: Colors.red,
      ),
    );
  }
}
