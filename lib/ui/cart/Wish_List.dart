import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/Cart_Provider.dart';
import '../../utils/utils.dart';
import '../appbar/My_appbar.dart';
import '../deep_linking/dynamic_link_Product_page.dart';

class WishList extends StatefulWidget {
  final bool? appBar;
  const WishList({Key? key, this.appBar = false}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  final _auth = FirebaseAuth.instance.currentUser!.uid;
  CartProvider cartProvider = CartProvider();

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of(context);
    cartProvider.getWishListData();
    return Scaffold(
      appBar: widget.appBar == true
          ? MyAppbar()
              .mySimpleAppBar(context, title: 'My Wishlist', showCart: false)
          : null,
      body: cartProvider.getWishListDataList.length == 0
          ? Center(
              child: Text('No Products'),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: cartProvider.getWishListDataList.length,
                        itemBuilder: (context, index) {
                          var data = cartProvider.getWishListDataList[index];
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11.0),
                            ),
                            child: GestureDetector(
                                onTap: () {
                                  if (data.cartCollectionName != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DynamicLinkProductPage(
                                                  productDocumentId:
                                                      data.cartUid.toString(),
                                                  productCollectionName:
                                                      data.cartCollectionName,
                                                  backToSplash: false,
                                                )));
                                  }
                                },
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            // width: 162,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 130,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            11),
                                                    child: Image(
                                                      // The Data will be loaded from firebse
                                                      image: NetworkImage(data
                                                          .cartImage1
                                                          .toString()),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                    child: Text(
                                                  data.cartName.toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                // Text(
                                                //   data.cartDescription.toString(),
                                                //   maxLines: 1,
                                                //   overflow: TextOverflow.ellipsis,
                                                // ),
                                                Row(
                                                  children: [
                                                    Text('Price: '),
                                                    Text(
                                                      'Rs.${data.cartPrice.toString()} ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(data.cartDescription
                                                    .toString()),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        right: 0,
                                        top: 0,
                                        child: IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Center(
                                                    child: AlertDialog(
                                                      title: const Text(
                                                          'Confirmation!!'),
                                                      content: const Text(
                                                          'Are You Sure to Delete?'),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text('No')),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "Cart")
                                                                .doc(_auth
                                                                    .toString())
                                                                .collection(
                                                                    "WishList")
                                                                .doc(data
                                                                    .cartUid)
                                                                .delete()
                                                                .then((value) {
                                                              Utils.flutterToast(
                                                                  'Deleted');
                                                            }).onError((error,
                                                                    stackTrace) {
                                                              Utils.flutterToast(
                                                                  error
                                                                      .toString());
                                                            });
                                                          },
                                                          child: Text('Delete'),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                          icon: Icon(
                                            Icons.delete_forever,
                                            color: Colors.red,
                                          ),
                                        ))
                                  ],
                                )),
                          );
                        }),
                  ),
                ],
              ),
            ),
      // bottomNavigationBar: Container(
      //   height: 100,
      //   width: double.infinity,
      //   decoration: BoxDecoration(color: AppColors.myBlackColor),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       SizedBox(
      //         height: 1,
      //       ),
      //       AppWidgets()
      //           .myHeading2Text('Total: \$0', color: AppColors.myWhiteColor),
      //       AppWidgets().myElevatedBTN(
      //           onPressed: () {},
      //           btnText: 'Checkout',
      //           btnColor: AppColors.myRedColor)
      //     ],
      //   ),
      // ),
    );
  }
}
