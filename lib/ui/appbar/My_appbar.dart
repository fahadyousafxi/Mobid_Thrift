import 'package:flutter/material.dart';

class MyAppbar {

  /// My App Bar
  PreferredSizeWidget myAppBar() {
    return AppBar(
      title: const Text("MobidThrift"),
      centerTitle: true,
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
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
    return Drawer(
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
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )),
            ListTile(
              leading: Icon(Icons.home_filled),
              title: Text('Home Page'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 1,
              thickness: 2,
            ),
            ListTile(
              leading: Icon(Icons.stacked_line_chart),
              title: Text('Trade Your Product'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 1,
              thickness: 2,
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 1,
              thickness: 2,
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Cart'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 1,
              thickness: 2,
            ),
            ListTile(
              leading: Icon(Icons.playlist_add_check_outlined),
              title: Text('Sold Products'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 1,
              thickness: 2,
            ),
            ListTile(
              leading: Icon(Icons.sticky_note_2_outlined),
              title: Text('About Us'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 1,
              thickness: 2,
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 1,
              thickness: 2,
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 1,
              thickness: 2,
            ),
          ],
        ));
  }

}