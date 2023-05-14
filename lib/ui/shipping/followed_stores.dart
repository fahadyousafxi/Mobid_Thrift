import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/providers/Cart_Provider.dart';
import 'package:provider/provider.dart';

import '../Seller_Profile.dart';

class FollowedStores extends StatefulWidget {

  const FollowedStores({Key? key}) : super(key: key);

  @override
  State<FollowedStores> createState() => _FollowedStoresState();
}

class _FollowedStoresState extends State<FollowedStores> {
  final _firebaseFireStore = FirebaseFirestore.instance;
  final _currentUser = FirebaseAuth.instance.currentUser!.uid;

  final _auth = FirebaseAuth.instance.currentUser!.uid;
  // CartProvider cartProvider = CartProvider();
  // @override
  // void initState() {
  //   CartProvider cartProvider = Provider.of(context, listen: false);
  //
  //   cartProvider.getCartData();
  //   // TODO: implement initState
  //   super.initState();
  // }
  //
  // @override
  // void deactivate() {
  //   cartProvider.getCartDataList.clear();
  //   // TODO: implement deactivate
  //   super.deactivate();
  // }

  @override
  Widget build(BuildContext context) {
    // cartProvider = Provider.of(context);
    // cartProvider.getCartData();

    return Scaffold(
      // appBar: MyAppbar().mySimpleAppBar(context, title: 'Your Cart'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: cartProvider.getCartDataList.isEmpty
                  ? Center(
                child: Text('There is no history',),
              )
                  : ListView.builder(
                  itemCount: cartProvider.getCartDataList.length,
                  itemBuilder: (context, index) {
                    var data = cartProvider.getCartDataList[index];
                    // for (var i = 0; i <= cartProvider.getCartDataList.length;) {
                    //   price = price + data.cartCurrentBid!.toInt();
                    // }
                    return data.pleaseWait! == 'To Report'
                        ? Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      child: GestureDetector(
                          onDoubleTap: () {},
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                StreamBuilder<DocumentSnapshot>(
                                    stream: _firebaseFireStore
                                        .collection(
                                        'SellerCenterUsers')
                                        .doc(data.cartShopkeeperUid)
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<
                                            DocumentSnapshot>
                                        snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting)
                                        return Center(
                                            child:
                                            CircularProgressIndicator(
                                              color: Colors.blue,
                                            ));

                                      if (snapshot.hasError)
                                        return Center(
                                            child:
                                            Text('Some Error'));

                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => SellerProfile(
                                                      locationLatitude:
                                                      snapshot.data!['location_address'][
                                                      'latitude'],
                                                      locationLongitude:
                                                      snapshot.data!['location_address'][
                                                      'longitude'],
                                                      name: snapshot
                                                          .data![
                                                      'Name'],
                                                      profileImage: snapshot
                                                          .data![
                                                      'Profile_Image'],
                                                      email: snapshot
                                                          .data!['Email'],
                                                      contactNo: snapshot.data!['Phone_Number'],
                                                      reviews: double.parse(snapshot.data!['Total_Review_Rating'].toString()),
                                                      totalNoOfReviews: snapshot.data!['Total_Number_of_Reviews'],
                                                      uId: snapshot.data!['Uid'])));
                                        },
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                            children: [
                                              snapshot.data!['Profile_Image']
                                                  .toString() ==
                                                  ''
                                                  ? CircleAvatar(
                                                radius: 33,
                                                backgroundImage:
                                                AssetImage(
                                                    'assets/images/img.png'),
                                              )
                                                  : CircleAvatar(
                                                radius: 33,
                                                backgroundImage:
                                                NetworkImage(snapshot
                                                    .data![
                                                'Profile_Image']
                                                    .toString()),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  SizedBox(
                                                    height: 21,
                                                  ),
                                                  Container(
                                                      height: 85,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          AppWidgets()
                                                              .myHeading1Text(
                                                              "${snapshot.data!['Name']}"),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  'Review '),
                                                              Row(
                                                                children: List.generate(
                                                                    5,
                                                                        (index) => Icon(
                                                                      Icons.star,
                                                                      color: Colors.orange,
                                                                      size: 20,
                                                                    )),
                                                              ),
                                                              Text(' (${snapshot.data!['Total_Review_Rating']}.00'.toString().substring(0, 5) +
                                                                  ')' ??
                                                                  '')
                                                            ],
                                                          ),
                                                        ],
                                                      ))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          )),
                    )
                        : data.pleaseWait! == 'Finished'
                        ? Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      child: GestureDetector(
                          onDoubleTap: () {},
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                StreamBuilder<DocumentSnapshot>(
                                    stream: _firebaseFireStore
                                        .collection(
                                        'SellerCenterUsers')
                                        .doc(data
                                        .cartShopkeeperUid)
                                        .snapshots(),
                                    builder: (BuildContext
                                    context,
                                        AsyncSnapshot<
                                            DocumentSnapshot>
                                        snapshot) {
                                      if (snapshot
                                          .connectionState ==
                                          ConnectionState.waiting)
                                        return Center(
                                            child:
                                            CircularProgressIndicator(
                                              color: Colors.blue,
                                            ));

                                      if (snapshot.hasError)
                                        return Center(
                                            child: Text(
                                                'Some Error'));

                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => SellerProfile(
                                                      locationLatitude:
                                                      snapshot.data!['location_address'][
                                                      'latitude'],
                                                      locationLongitude:
                                                      snapshot.data!['location_address']
                                                      [
                                                      'longitude'],
                                                      name: snapshot
                                                          .data![
                                                      'Name'],
                                                      profileImage:
                                                      snapshot.data![
                                                      'Profile_Image'],
                                                      email: snapshot
                                                          .data!['Email'],
                                                      contactNo: snapshot.data!['Phone_Number'],
                                                      reviews: double.parse(snapshot.data!['Total_Review_Rating'].toString()),
                                                      totalNoOfReviews: snapshot.data!['Total_Number_of_Reviews'],
                                                      uId: snapshot.data!['Uid'])));
                                        },
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                            children: [
                                              snapshot.data!['Profile_Image']
                                                  .toString() ==
                                                  ''
                                                  ? CircleAvatar(
                                                radius: 33,
                                                backgroundImage:
                                                AssetImage(
                                                    'assets/images/img.png'),
                                              )
                                                  : CircleAvatar(
                                                radius: 33,
                                                backgroundImage: NetworkImage(snapshot
                                                    .data![
                                                'Profile_Image']
                                                    .toString()),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  SizedBox(
                                                    height: 21,
                                                  ),
                                                  Container(
                                                      height: 85,
                                                      child:
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          AppWidgets()
                                                              .myHeading1Text("${snapshot.data!['Name']}"),
                                                          Row(
                                                            children: [
                                                              Text('Review '),
                                                              Row(
                                                                children: List.generate(
                                                                    5,
                                                                        (index) => Icon(
                                                                      Icons.star,
                                                                      color: Colors.orange,
                                                                      size: 20,
                                                                    )),
                                                              ),
                                                              Text(' (${snapshot.data!['Total_Review_Rating']}.00'.toString().substring(0, 5) + ')' ??
                                                                  '')
                                                            ],
                                                          ),
                                                        ],
                                                      ))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          )),
                    )
                        : SizedBox();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
