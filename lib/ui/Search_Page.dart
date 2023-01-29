import 'package:flutter/material.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar().mySimpleAppBar(context, title: 'Search Item'),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 1),
        child: TextField(
          decoration: InputDecoration(
              isDense: true,
              prefixIcon: Hero(tag: 'forSearch',
              child: Icon(Icons.search, color: Colors.black,)),
              // prefixIconConstraints: BoxConstraints(minWidth: 10, minHeight: 10),
              border: OutlineInputBorder( borderRadius: BorderRadius.circular(20), ),
              contentPadding: EdgeInsets.only(top: 1, left: 1, bottom: 1),
              hintText: 'Search'
          ),
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
