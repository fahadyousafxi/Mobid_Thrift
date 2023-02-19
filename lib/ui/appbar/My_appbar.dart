import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobidthrift/constants/App_colors.dart';
import 'package:mobidthrift/models/Product_Model.dart';
import 'package:mobidthrift/ui/About_Us.dart';
import 'package:mobidthrift/ui/Contact_Us.dart';
import 'package:mobidthrift/ui/My_Home_Page.dart';
import 'package:mobidthrift/ui/Search_Page.dart';
import 'package:mobidthrift/ui/Sold_Products.dart';
import 'package:mobidthrift/ui/Trade_Your_Product.dart';
import 'package:mobidthrift/ui/Wish_List.dart';
import 'package:mobidthrift/ui/Your_Cart.dart';
import 'package:mobidthrift/ui/login/Login_page.dart';
import 'package:mobidthrift/utils/utils.dart';

class MyAppbar {

  File? pickedImage;
  bool showLocalImage = false;
  pickImageFrom() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
    if(file == null) {
      return;
    }

    pickedImage = File(file.path);
    showLocalImage = true;
    // setState((){});
  }

  // List<ProductModel>
  /// My App Bar
  PreferredSizeWidget myAppBar(context, {List<ProductModel> search = const []}) {
    return AppBar(
      backgroundColor: Colors.black,
      title: const Text("MobidThrift"),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              // showSearch(context: context, delegate: SearchPage()),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage(searchProducts: search)));
            },
            icon: Hero(tag: 'forSearch', child: Icon(Icons.search))),
        IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => YourCart()));
            },
            icon: Icon(Icons.shopping_cart)),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
    );
  }

  /// My Simple App Bar
  PreferredSizeWidget mySimpleAppBar(context,
      {required String title, Widget myicon = const SizedBox()}) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Text(title),
      centerTitle: true,
      actions: [
        myicon ?? SizedBox(),
        IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => YourCart()));
            },
            icon: Icon(Icons.shopping_cart)),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
    );
  }

  /// My Drawer
  // Widget myDrawer(BuildContext context) {
  //   bool _yes = false;
  //   return Drawer(
  //       backgroundColor: AppColors.drawerColor,
  //       child: ListView(
  //         children: [
  //           DrawerHeader(
  //               decoration: BoxDecoration(),
  //               child: Column(
  //                 children: [
  //                   SizedBox(
  //                       height: 85,
  //                       child: InkWell(
  //                         borderRadius: BorderRadius.circular(22),
  //                         onTap: (){
  //
  //                           bottomSheet(context);
  //
  //                           },
  //                         child: CircleAvatar(
  //                           radius: 48, // Image radius
  //                           backgroundImage:
  //
  //                               showLocalImage == false ? NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixabay.com%2Fvectors%2Favatar-icon-placeholder-facebook-1577909%2F&psig=AOvVaw1rKUPDx0iwUWUR72lrl-Hm&ust=1675355641026000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCLDspKPg9PwCFQAAAAAdAAAAABAQ')
  //                                   : Image.file(pickedImage!) as ImageProvider
  //                               // AssetImage('assets/images/phone.png'),
  //                         ),
  //                       )),
  //                   TextButton(
  //                     onPressed: () {},
  //                     child: Text(
  //                       'Profile',
  //                       style: TextStyle(color: AppColors.drawerTextColor),
  //                     ),
  //                   ),
  //                 ],
  //               )),
  //           // Container(
  //           //   margin: EdgeInsets.symmetric(horizontal: 22, vertical: 5),
  //           //   decoration: BoxDecoration(
  //           //     borderRadius: BorderRadius.all(Radius.circular(20)),
  //           //     border: Border.all(
  //           //       color: Colors.white,
  //           //     ),
  //           //     color: Colors.black,
  //           //   ),
  //           //   child: Row(
  //           //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           //     children: [
  //           //       Text(
  //           //         'Switch to seller',
  //           //         style: TextStyle(
  //           //           color: AppColors.drawerTextColor,
  //           //         ),
  //           //       ),
  //           //       Switch(
  //           //         value: _yes,
  //           //         onChanged: (bool newValue) {},
  //           //       ),
  //           //     ],
  //           //   ),
  //           // ),
  //           ListTile(
  //             textColor: AppColors.drawerTextColor,
  //             iconColor: AppColors.drawerIconColor,
  //             leading: Icon(
  //               Icons.home_filled,
  //             ),
  //             title: Text('Home Page'),
  //             onTap: () {
  //               Navigator.pop(context);
  //               Navigator.push(context,
  //                   MaterialPageRoute(builder: (context) => MyHomePage()));
  //             },
  //           ),
  //           Divider(
  //             color: AppColors.drawerDividerColor,
  //             height: 1,
  //             thickness: 2,
  //           ),
  //           ListTile(
  //             textColor: AppColors.drawerTextColor,
  //             iconColor: AppColors.drawerIconColor,
  //             leading: Icon(Icons.stacked_line_chart),
  //             title: Text('Trade Your Product'),
  //             onTap: () {
  //               Navigator.pop(context);
  //               Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) => TradeYourProduct()));
  //             },
  //           ),
  //           Divider(
  //             color: AppColors.drawerDividerColor,
  //             height: 1,
  //             thickness: 2,
  //           ),
  //           ListTile(
  //             textColor: AppColors.drawerTextColor,
  //             iconColor: AppColors.drawerIconColor,
  //             leading: Icon(Icons.search),
  //             title: Text('Search'),
  //             onTap: () {
  //               Navigator.pop(context);
  //               Navigator.push(context,
  //                   MaterialPageRoute(builder: (context) => SearchPage()));
  //             },
  //           ),
  //           Divider(
  //             color: AppColors.drawerDividerColor,
  //             height: 1,
  //             thickness: 2,
  //           ),
  //           ListTile(
  //             textColor: AppColors.drawerTextColor,
  //             iconColor: AppColors.drawerIconColor,
  //             leading: Icon(Icons.shopping_cart),
  //             title: Text('Cart'),
  //             onTap: () {
  //               Navigator.pop(context);
  //               Navigator.push(context,
  //                   MaterialPageRoute(builder: (context) => YourCart()));
  //             },
  //           ),
  //           Divider(
  //             color: AppColors.drawerDividerColor,
  //             height: 1,
  //             thickness: 2,
  //           ),
  //           ListTile(
  //             textColor: AppColors.drawerTextColor,
  //             iconColor: AppColors.drawerIconColor,
  //             leading: Icon(Icons.favorite),
  //             title: Text('Wish List'),
  //             onTap: () {
  //               Navigator.pop(context);
  //               Navigator.push(context,
  //                   MaterialPageRoute(builder: (context) => WishList()));
  //             },
  //           ),
  //           Divider(
  //             color: AppColors.drawerDividerColor,
  //             height: 1,
  //             thickness: 2,
  //           ),
  //           ListTile(
  //             textColor: AppColors.drawerTextColor,
  //             iconColor: AppColors.drawerIconColor,
  //             leading: Icon(Icons.playlist_add_check_outlined),
  //             title: Text('Sold Products'),
  //             onTap: () {
  //               Navigator.pop(context);
  //               Navigator.push(context,
  //                   MaterialPageRoute(builder: (context) => SoldProducts()));
  //             },
  //           ),
  //           Divider(
  //             color: AppColors.drawerDividerColor,
  //             height: 1,
  //             thickness: 2,
  //           ),
  //           ListTile(
  //             textColor: AppColors.drawerTextColor,
  //             iconColor: AppColors.drawerIconColor,
  //             leading: Icon(Icons.sticky_note_2_outlined),
  //             title: Text('About Us'),
  //             onTap: () {
  //               Navigator.pop(context);
  //               Navigator.push(context,
  //                   MaterialPageRoute(builder: (context) => AboutUs()));
  //             },
  //           ),
  //           Divider(
  //             color: AppColors.drawerDividerColor,
  //             height: 1,
  //             thickness: 2,
  //           ),
  //           ListTile(
  //             textColor: AppColors.drawerTextColor,
  //             iconColor: AppColors.drawerIconColor,
  //             leading: Icon(Icons.phone),
  //             title: Text('Contact Us'),
  //             onTap: () {
  //               Navigator.pop(context);
  //               Navigator.push(context,
  //                   MaterialPageRoute(builder: (context) => ContactUs()));
  //             },
  //           ),
  //           Divider(
  //             color: AppColors.drawerDividerColor,
  //             height: 1,
  //             thickness: 2,
  //           ),
  //           ListTile(
  //             textColor: AppColors.drawerTextColor,
  //             iconColor: AppColors.drawerIconColor,
  //             leading: Icon(Icons.logout),
  //             title: Text('Log Out'),
  //             onTap: () {
  //
  //               Navigator.pop(context);
  //               myAlertDialog(context);
  //               // final _auth = FirebaseAuth.instance;
  //               //
  //               // _auth.signOut().then((value) {
  //               //   Navigator.pop(context);
  //               //   Navigator.pushReplacement(context,
  //               //       MaterialPageRoute(builder: (context) => LoginPage()));
  //               // }).onError((error, stackTrace) {
  //               //   Utils.flutterToast(error.toString());
  //               // });
  //             },
  //           ),
  //           Divider(
  //             color: AppColors.drawerDividerColor,
  //             height: 1,
  //             thickness: 2,
  //           ),
  //         ],
  //       ));
  // }
  //
  // /// my Alert Dialog
  // Future myAlertDialog(context){
  //   return showDialog(context: context, builder: (context) {
  //   return Center(
  //     child: AlertDialog(
  //       title: Text('Confirmation!!'),
  //       content: Text('Are You Sure to Log Out?'),
  //       actions: [
  //         TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: Text('No')),
  //         TextButton(
  //           onPressed: () {
  //             final _auth = FirebaseAuth.instance;
  //
  //             _auth.signOut().then((value) {
  //               Navigator.pop(context);
  //               Navigator.pushReplacement(context,
  //                   MaterialPageRoute(builder: (context) => LoginPage()));
  //             }).onError((error, stackTrace) {
  //               Utils.flutterToast(error.toString());
  //             });
  //           },
  //           child: Text('Yes'),
  //         )
  //       ],
  //     ),
  //   );});
  // }
  //
  // /// bottom Sheet
  // Future bottomSheet(context){
  //   return showModalBottomSheet(context: context, builder: (context){
  //     return SafeArea(
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           ListTile(
  //             leading: const Icon(Icons.camera_alt),
  //             title: const Text('With Camera'),
  //             onTap: (){},
  //           ),
  //           ListTile(
  //             leading: const Icon(Icons.storage),
  //             title: const Text('From Gallery'),
  //             onTap: (){
  //               pickImageFrom();
  //               Navigator.pop(context);
  //             },
  //           ),
  //
  //         ],
  //       ),
  //     );
  //   });
  // }


}





