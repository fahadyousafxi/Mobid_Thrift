import 'package:flutter/material.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: MyAppbar().mySimpleAppBar(context, title: "Wish List"),
      body: Center(child: Text('Empty Wish List'),),
    );
  }
}
