import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_colors.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppbar().myAppBar(),
      drawer: MyAppbar().myDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.filter_list),
                color: AppColors.myIconColor,
              ),

              AppWidgets().myAddBannerContainer(height: size.height / 4.2),

              SizedBox(height: 15,),
              AppWidgets().categoryRow(categoryText: 'Cell Phones', textButtonText: 'More Cell Phones'),
              SizedBox(height: size.height / 4.8, width: double.infinity, child: AppWidgets().myList(context)),

              SizedBox(height: 15,),
              AppWidgets().categoryRow(categoryText: 'Pads/Tablets', textButtonText: 'More Pads/Tablets'),
              SizedBox(height: size.height / 4.8, width: double.infinity, child: AppWidgets().myList(context)),

              SizedBox(height: 15,),
              AppWidgets().categoryRow(categoryText: 'Smart Watches', textButtonText: 'More Smart Watches'),
              SizedBox(height: size.height / 4.8, width: double.infinity, child: AppWidgets().myList(context)),

              SizedBox(height: 15,),
              AppWidgets().categoryRow(categoryText: 'Laptops', textButtonText: 'More Laptops'),
              SizedBox(height: size.height / 4.8, width: double.infinity, child: AppWidgets().myList(context)),

              SizedBox(height: 15,),
              AppWidgets().categoryRow(categoryText: 'Desktops', textButtonText: 'More Desktops'),
              SizedBox(height: size.height / 4.8, width: double.infinity, child: AppWidgets().myList(context)),

              SizedBox(height: 15,),
              AppWidgets().categoryRow(categoryText: 'Accessories', textButtonText: 'More Accessories'),
              SizedBox(height: size.height / 4.8, width: double.infinity, child: AppWidgets().myList(context)),

              SizedBox(height: 15,),
              AppWidgets().categoryRow(categoryText: 'Parts', textButtonText: 'More Parts'),
              SizedBox(height: size.height / 4.8, width: double.infinity, child: AppWidgets().myList(context)),

              SizedBox(height: 15,),


            ],
          ),
        ),
      ),
    );
  }
}
