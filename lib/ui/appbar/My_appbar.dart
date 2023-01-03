import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_colors.dart';
import 'package:mobidthrift/ui/About_Us.dart';
import 'package:mobidthrift/ui/Contact_Us.dart';
import 'package:mobidthrift/ui/My_Home_Page.dart';
import 'package:mobidthrift/ui/Search_Page.dart';
import 'package:mobidthrift/ui/Sold_Products.dart';
import 'package:mobidthrift/ui/Trade_Your_Product.dart';
import 'package:mobidthrift/ui/Wish_List.dart';
import 'package:mobidthrift/ui/Your_Cart.dart';
import 'package:mobidthrift/ui/login/Login_page.dart';

class MyAppbar {

  /// My App Bar
  PreferredSizeWidget myAppBar(context) {
    return AppBar(
      backgroundColor: Colors.black,
      title: const Text("MobidThrift"),
      centerTitle: true,
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => YourCart()));}, icon: Icon(Icons.shopping_cart)),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
    );
  }

  /// My Simple App Bar
  PreferredSizeWidget mySimpleAppBar({required String title, Widget myicon = const SizedBox()}) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Text(title),
      centerTitle: true,
      actions: [
        myicon ?? SizedBox(),
        IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
    );
  }


  /// My Drawer
  Widget myDrawer(BuildContext context) {
    bool _yes = false;
    return Drawer(

      backgroundColor: AppColors.drawerColor,
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(),
                child: Column(
                  children: [
                    SizedBox(
                        height: 85,
                        child: CircleAvatar(
                          radius: 48, // Image radius
                          backgroundImage: AssetImage('assets/images/phone.png'),
                        )),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Profile',
                        style: TextStyle(color: AppColors.drawerTextColor),
                      ),
                    ),
                  ],
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 22, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  color: Colors.white,
                ),
                color: Colors.black,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Switch to seller', style: TextStyle(color: AppColors.drawerTextColor,),),
                  Switch(value: _yes, onChanged: (bool newValue) {},),
                ],
              ),
            ),
            ListTile(
              textColor: AppColors.drawerTextColor,
              iconColor: AppColors.drawerIconColor,
              leading: Icon(Icons.home_filled,),
              title: Text('Home Page'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
              },
            ),
            Divider(
              color: AppColors.drawerDividerColor,
              height: 1,
              thickness: 2,
            ),
            ListTile(
              textColor: AppColors.drawerTextColor,
              iconColor: AppColors.drawerIconColor,
              leading: Icon(Icons.stacked_line_chart),
              title: Text('Trade Your Product'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => TradeYourProduct()));
              },
            ),
            Divider(
              color: AppColors.drawerDividerColor,
              height: 1,
              thickness: 2,
            ),
            ListTile(
              textColor: AppColors.drawerTextColor,
              iconColor: AppColors.drawerIconColor,
              leading: Icon(Icons.search),
              title: Text('Search'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
              },
            ),
            Divider(
              color: AppColors.drawerDividerColor,
              height: 1,
              thickness: 2,
            ),
            ListTile(
              textColor: AppColors.drawerTextColor,
              iconColor: AppColors.drawerIconColor,
              leading: Icon(Icons.shopping_cart),
              title: Text('Cart'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => YourCart()));
              },
            ),
            Divider(
              color: AppColors.drawerDividerColor,
              height: 1,
              thickness: 2,
            ),
            ListTile(
              textColor: AppColors.drawerTextColor,
              iconColor: AppColors.drawerIconColor,
              leading: Icon(Icons.favorite),
              title: Text('Wish List'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => WishList()));

              },
            ),
            Divider(
              color: AppColors.drawerDividerColor,
              height: 1,
              thickness: 2,
            ),

            ListTile(
              textColor: AppColors.drawerTextColor,
              iconColor: AppColors.drawerIconColor,
              leading: Icon(Icons.playlist_add_check_outlined),
              title: Text('Sold Products'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => SoldProducts()));
              },
            ),
            Divider(
              color: AppColors.drawerDividerColor,
              height: 1,
              thickness: 2,
            ),
            ListTile(
              textColor: AppColors.drawerTextColor,
              iconColor: AppColors.drawerIconColor,
              leading: Icon(Icons.sticky_note_2_outlined),
              title: Text('About Us'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));
              },
            ),
            Divider(
              color: AppColors.drawerDividerColor,
              height: 1,
              thickness: 2,
            ),
            ListTile(
              textColor: AppColors.drawerTextColor,
              iconColor: AppColors.drawerIconColor,
              leading: Icon(Icons.phone),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs()));
              },
            ),
            Divider(
              color: AppColors.drawerDividerColor,
              height: 1,
              thickness: 2,
            ),
            ListTile(
              textColor: AppColors.drawerTextColor,
              iconColor: AppColors.drawerIconColor,
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            Divider(
              color: AppColors.drawerDividerColor,
              height: 1,
              thickness: 2,
            ),
          ],
        ));
  }

}
