import 'package:flutter/material.dart';
import 'package:mobidthrift/ui/cart/Wish_List.dart';
import 'package:mobidthrift/ui/cart/Your_Cart.dart';
import 'package:mobidthrift/ui/cart/biddings.dart';

class CartWishBidding extends StatefulWidget {
  int? iniIndex;
  CartWishBidding({required this.iniIndex, Key? key}) : super(key: key);

  @override
  State<CartWishBidding> createState() => _CartWishBiddingState();
}

class _CartWishBiddingState extends State<CartWishBidding>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    _tabController = new TabController(
        initialIndex: widget.iniIndex!, length: 3, vsync: this);
    super.initState();
  }

  List<Widget> tabs = [
    YourCart(),
    YourBidding(),
    WishList(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.iniIndex!,
      length: 3,
      child: Scaffold(
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
        body: Column(
          children: [
            TabBar(
              unselectedLabelColor: Colors.black,
              labelColor: Colors.blue,
              tabs: const [
                Tab(
                  // icon: Icon(Icons.check_circle),
                  child: Text('Cart'),
                ),
                Tab(
                  // icon: Icon(Icons.add),
                  child: Text('Your Bidding'),
                ),
                Tab(
                  child: Text('Wish List'),
                )
              ],
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: tabs,
              ),
            ),
          ],
        ),
        // extendBody: true,
        // bottomNavigationBar: Container(
        //   height: 60,
        //   width: double.infinity,
        //   decoration: const BoxDecoration(color: Colors.transparent),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       AppWidgets().myElevatedBTN(
        //         onPressed: () {
        //           print('hi');
        //           // Navigator.push(
        //           //     context,
        //           //     MaterialPageRoute(
        //           //         builder: (context) => AddProductScreen()));
        //         },
        //         btnText: 'Chat Screen',
        //         btnColor: AppColors.myRedColor,
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
