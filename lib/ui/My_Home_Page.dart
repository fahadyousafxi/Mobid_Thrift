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
      appBar: AppWidgets().myAppBar(),
      drawer: AppWidgets().myDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.filter_list),
              color: AppColors.myIconColor,
            ),
            // Center(
            //   child: Text(
            //     'Home Page',
            //     style: TextStyle(color: Colors.black),
            //   ),
            // ),
            AppWidgets().myAddBannerContainer(height: size.height / 4.2),
            AppWidgets().categoryRow(categoryText: 'Cell Phones', textButtonText: 'More Cell Phones'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cell Phones',
                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(onPressed: (){}, child: Text('More Cell Phones', style: TextStyle(fontSize: 16),)),

              ],
            )
          ],
        ),
      ),
    );
  }
}
