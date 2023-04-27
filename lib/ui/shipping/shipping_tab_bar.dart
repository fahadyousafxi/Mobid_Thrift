import 'package:flutter/material.dart';
import 'package:mobidthrift/ui/shipping/all_page.dart';
import 'package:mobidthrift/ui/shipping/to_pay.dart';
import 'package:mobidthrift/ui/shipping/to_receive.dart';
import 'package:mobidthrift/ui/shipping/to_ship.dart';

class ShippingTabBar extends StatefulWidget {
  int? iniIndex;
  ShippingTabBar({required this.iniIndex, Key? key}) : super(key: key);

  @override
  State<ShippingTabBar> createState() => _ShippingTabBarState();
}

class _ShippingTabBarState extends State<ShippingTabBar>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    _tabController =
        TabController(initialIndex: widget.iniIndex!, length: 4, vsync: this);
    super.initState();
  }

  List<Widget> tabs = [
    AllPage(),
    ToPay(),
    ToShip(),
    ToReceive(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.iniIndex!,
      length: 4,
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
                  child: Text('All'),
                ),
                Tab(
                  // icon: Icon(Icons.add),
                  child: Text('To pay'),
                ),
                Tab(
                  child: Text('To Ship'),
                ),
                Tab(
                  child: Text('To Receive'),
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
