import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';

class SellerShopProducts extends StatefulWidget {
  const SellerShopProducts({Key? key}) : super(key: key);

  @override
  State<SellerShopProducts> createState() => _SellerShopProductsState();
}

class _SellerShopProductsState extends State<SellerShopProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar().myAppBar(context),
      body: Column(
        children: [
          SizedBox(height: 15,),
          AppWidgets().myHeading2Text('Shopkeeper Name'),
          SizedBox(height: 44,),

          Center(child: Text('Empty List of Products')),
        ],
      ),
    );
  }
}
