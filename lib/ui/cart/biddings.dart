import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/providers/Cart_Provider.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';
import '../Product_Page_of_Cart.dart';

class YourBidding extends StatefulWidget {
  const YourBidding({Key? key}) : super(key: key);

  @override
  State<YourBidding> createState() => _YourBiddingState();
}

class _YourBiddingState extends State<YourBidding> {
  final _auth = FirebaseAuth.instance.currentUser!.uid;

  CartProvider cartProvider = CartProvider();
  @override
  void initState() {
    // CartProvider initCartProvider = CartProvider();
    // initCartProvider.getCartData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of(context);
    cartProvider.getBiddingData();
    return Scaffold(
      // appBar: MyAppbar().mySimpleAppBar(context, title: 'Your Cart'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: cartProvider.getBiddingDataList.length,
                  itemBuilder: (context, index) {
                    var data = cartProvider.getBiddingDataList[index];
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPageOfCart(
                                          cartName: data.cartName.toString(),
                                          cartCurrentBid: data.cartCurrentBid,
                                          cartDescription:
                                              data.cartDescription.toString(),
                                          cartUid: data.cartUid.toString(),
                                          cartImage1:
                                              data.cartImage1.toString(),
                                          cartShipping: data.cartShipping,
                                          cartPrice: data.cartPrice,
                                          cartPTAApproved: data.cartPTAApproved,
                                          cartShopkeeperUid:
                                              data.cartShopkeeperUid,
                                          cartSpecification:
                                              data.cartSpecification,
                                        )));
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
                                                  BorderRadius.circular(11),
                                              child: Image(
                                                // The Data will be loaded from firebse
                                                image: NetworkImage(
                                                    data.cartImage1.toString()),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
                                                fontWeight: FontWeight.bold),
                                          )),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            data.cartDescription.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Rs.${data.cartCurrentBid.toString()} ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text('is current bid '),
                                            ],
                                          ),
                                          Text('1 Day time left '),
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
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('No')),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      FirebaseFirestore.instance
                                                          .collection("Cart")
                                                          .doc(_auth.toString())
                                                          .collection(
                                                              "YourBidding")
                                                          .doc(data.cartUid)
                                                          .delete()
                                                          .then((value) {
                                                        Utils.flutterToast(
                                                            'Deleted');
                                                      }).onError((error,
                                                              stackTrace) {
                                                        Utils.flutterToast(
                                                            error.toString());
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
