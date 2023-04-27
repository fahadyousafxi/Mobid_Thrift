import 'package:flutter/material.dart';
import 'package:mobidthrift/ui/shipping/reviews_history.dart';
import 'package:mobidthrift/ui/shipping/to_be_revieved.dart';

class MyReviewsTabBar extends StatefulWidget {
  int? iniIndex;
  MyReviewsTabBar({required this.iniIndex, Key? key}) : super(key: key);

  @override
  State<MyReviewsTabBar> createState() => _MyReviewsTabBarState();
}

class _MyReviewsTabBarState extends State<MyReviewsTabBar>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    _tabController =
        TabController(initialIndex: widget.iniIndex!, length: 2, vsync: this);
    super.initState();
  }

  List<Widget> tabs = [
    ToBeReviewed(),
    ReviewsHistory(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.iniIndex!,
      length: 2,
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
                  child: Text('To be Reviewed'),
                ),
                Tab(
                  // icon: Icon(Icons.add),
                  child: Text('History'),
                ),
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
      ),
    );
  }
}
