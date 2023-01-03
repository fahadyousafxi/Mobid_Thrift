import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_colors.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';

class YourCart extends StatefulWidget {
  const YourCart({Key? key}) : super(key: key);

  @override
  State<YourCart> createState() => _YourCartState();
}

class _YourCartState extends State<YourCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar().mySimpleAppBar(context, title: 'Your Cart'),
      body: Center(
        child: Text('Your Cart is Empty'),
      ),
      bottomNavigationBar: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.myBlackColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 1,),
            AppWidgets()
                .myHeading2Text('Total: \$0', color: AppColors.myWhiteColor),
            AppWidgets().myElevatedBTN(
                onPressed: () {},
                btnText: 'Checkout',
                btnColor: AppColors.myRedColor)
          ],
        ),
      ),
    );
  }
}
