import 'package:flutter/material.dart';
import 'package:mobidthrift/ui/shipping/all_page.dart';

class MyReportsTabBar extends StatefulWidget {
  int? iniIndex;
  MyReportsTabBar({required this.iniIndex, Key? key}) : super(key: key);

  @override
  State<MyReportsTabBar> createState() => _MyReportsTabBarState();
}

class _MyReportsTabBarState extends State<MyReportsTabBar>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    _tabController =
        TabController(initialIndex: widget.iniIndex!, length: 2, vsync: this);
    super.initState();
  }

  List<Widget> tabs = [
    AllPage(),
    AllPage(),
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
                  child: Text('To be Reported'),
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
