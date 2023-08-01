import 'package:flutter/material.dart';
import 'package:mobidthrift/ui/cart/Wish_List.dart';
import 'package:mobidthrift/ui/shipping/my_reports_tab_bar.dart';
import 'package:mobidthrift/ui/shipping/my_reviews_tab_bar.dart';
import 'package:mobidthrift/ui/shipping/shipping_tab_bar.dart';
import 'package:provider/provider.dart';

import '../../providers/Cart_Provider.dart';
import '../../providers/followers_provider.dart';
import 'followed_stores.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CartProvider cartProvider = CartProvider();

  FollowersProvider followersProvider = FollowersProvider();

  @override
  void initState() {
    CartProvider cart = Provider.of(context, listen: false);
    FollowersProvider followerProvider = Provider.of(context, listen: false);
    followerProvider.getFollowingsData();
    cart.getWishListData();
    super.initState();
  }

  @override
  void deactivate() {
    followersProvider.getFollowingsDataList.clear();
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    followersProvider = Provider.of(context);
    cartProvider = Provider.of(context);
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
                        icon: Icon(Icons.report_gmailerrorred),
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
                        icon: Icon(Icons.reviews_outlined),
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WishList(
                                    appBar: true,
                                  )));
                    },
                    child: myContainer(
                        number: cartProvider.getWishListDataList.length,
                        title: 'My Wishlist'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FollowedStores(
                                    followingsUid:
                                        followersProvider.getFollowingsDataList,
                                  )));
                    },
                    child: myContainer(
                        number: followersProvider.getFollowingsDataList.length,
                        title: 'Followed Stores'),
                  ),
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
