import 'package:flutter/material.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';

class SoldProducts extends StatefulWidget {
  const SoldProducts({Key? key}) : super(key: key);

  @override
  State<SoldProducts> createState() => _SoldProductsState();
}

class _SoldProductsState extends State<SoldProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar().mySimpleAppBar(context, title: 'Sold Products'),
    );
  }
}
