import 'package:flutter/material.dart';
import 'package:mobidthrift/ui/shipping/my_reports_page.dart';
import 'package:mobidthrift/ui/shipping/my_reviews_tab_bar.dart';
import 'package:mobidthrift/ui/shipping/shipping_tab_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
      body: Padding(
        padding: const EdgeInsets.all(38.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('My Orders'),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ShippingTabBar(iniIndex: 0)));
                      },
                      child: Text('View All')),
                ],
              ),
              SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ShippingTabBar(iniIndex: 1)));
                        },
                        icon: Icon(Icons.credit_card),
                      ),
                      Text(
                        'To pay',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ShippingTabBar(iniIndex: 2)));
                          },
                          icon: Icon(Icons.event_note_sharp)),
                      Text(
                        'To Ship',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ShippingTabBar(iniIndex: 3)));
                          },
                          icon: Icon(Icons.local_shipping_outlined)),
                      const Text(
                        'To Receive',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MyReviewsTabBar(iniIndex: 0)));
                          },
                          icon: Icon(Icons.reviews_outlined)),
                      Text(
                        'To Review',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                ],
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 33,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyReportsTabBar(iniIndex: 1)));
                        },
                        icon: Icon(Icons.credit_card),
                      ),
                      const Text(
                        'My Reports',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyReviewsTabBar(iniIndex: 1)));
                        },
                        icon: Icon(Icons.credit_card),
                      ),
                      const Text(
                        'My Reviews',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 33,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  myContainer(number: 6, title: 'My Wishlist'),
                  myContainer(number: 0, title: 'Followed Stores'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget myContainer({required int? number, required String? title}) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width / 2.7,
      decoration: BoxDecoration(
          // color: Colors.blue,
          gradient: LinearGradient(colors: [Colors.blue, Colors.red]),
          borderRadius: BorderRadius.circular(22)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              number.toString(),
              style: TextStyle(color: Colors.white),
            ),
            Text(
              title!,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
