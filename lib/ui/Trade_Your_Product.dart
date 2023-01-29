import 'package:flutter/material.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';

import '../constants/App_colors.dart';
import '../constants/App_widgets.dart';

class TradeYourProduct extends StatefulWidget {
  const TradeYourProduct({Key? key}) : super(key: key);

  @override
  State<TradeYourProduct> createState() => _TradeYourProductState();
}

class _TradeYourProductState extends State<TradeYourProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar().mySimpleAppBar(context, title: 'Trade Your Product'),
      body: Center(child: Text('Empty')),
      bottomNavigationBar: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.myWhiteColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppWidgets().myElevatedBTN(
                onPressed: () {},
                btnText: 'Add Product',
                btnColor: AppColors.myRedColor)
          ],

        ),
      ),
    );
  }
}
