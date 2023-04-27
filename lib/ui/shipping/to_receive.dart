import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/providers/Cart_Provider.dart';
import 'package:mobidthrift/ui/shipping/my_reviews_tab_bar.dart';
import 'package:mobidthrift/utils/utils.dart';
import 'package:provider/provider.dart';

class ToReceive extends StatefulWidget {
  const ToReceive({Key? key}) : super(key: key);

  @override
  State<ToReceive> createState() => _ToReceiveState();
}

class _ToReceiveState extends State<ToReceive> {
  final _firebaseFireStore = FirebaseFirestore.instance;
  final _currentUser = FirebaseAuth.instance.currentUser!.uid;

  final _auth = FirebaseAuth.instance.currentUser!.uid;
  CartProvider cartProvider = CartProvider();

  bool loading1 = false;
  @override
  void initState() {
    CartProvider cartProvider = Provider.of(context, listen: false);

    cartProvider.getCartData();
    // TODO: implement initState
    super.initState();
  }

  @override
  void deactivate() {
    cartProvider.getCartDataList.clear();
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of(context);
    cartProvider.getCartData();

    return Scaffold(
      // appBar: MyAppbar().mySimpleAppBar(context, title: 'Your Cart'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: cartProvider.getCartDataList.isEmpty
                  ? Center(
                      child: Text('There is no products'),
                    )
                  : ListView.builder(
                      itemCount: cartProvider.getCartDataList.length,
                      itemBuilder: (context, index) {
                        var data = cartProvider.getCartDataList[index];
                        // for (var i = 0; i <= cartProvider.getCartDataList.length;) {
                        //   price = price + data.cartCurrentBid!.toInt();
                        // }
                        return data.pleaseWait! != 'To Receive'
                            ? SizedBox()
                            // const Center(
                            //         child: Text('There is no products To Receive'),
                            //       )
                            : Card(
                                clipBehavior: Clip.antiAlias,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11.0),
                                ),
                                child: GestureDetector(
                                    onDoubleTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             ProductPageOfCart(
                                      //               cartName:
                                      //                   data.cartName.toString(),
                                      //               cartCurrentBid:
                                      //                   data.cartCurrentBid,
                                      //               cartDescription: data
                                      //                   .cartDescription
                                      //                   .toString(),
                                      //               cartUid:
                                      //                   data.cartUid.toString(),
                                      //               cartImage1:
                                      //                   data.cartImage1.toString(),
                                      //               cartShipping: data.cartShipping,
                                      //               cartPrice: data.cartPrice,
                                      //               cartPTAApproved:
                                      //                   data.cartPTAApproved,
                                      //               cartShopkeeperUid:
                                      //                   data.cartShopkeeperUid,
                                      //               cartSpecification:
                                      //                   data.cartSpecification,
                                      //             )));
                                    },
                                    onTap: () {},
                                    child: Padding(
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
                                            width: 7,
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
                                                  height: 2,
                                                ),
                                                Text(
                                                  data.cartDescription
                                                      .toString(),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Price: Rs.${data.cartPrice.toString()} ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    // Text('is current bid '),
                                                  ],
                                                ),
                                                Row(
                                                  children: const [
                                                    Text(
                                                      'wait upto 4 days',
                                                      style: TextStyle(),
                                                    ),
                                                    // Text('is current bid '),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 11,
                                                ),
                                                Container(
                                                  height: 25,
                                                  width: 100,
                                                  child:
                                                      AppWidgets()
                                                          .myElevatedBTN(
                                                              loading: loading1,
                                                              onPressed: () {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return Center(
                                                                        child:
                                                                            AlertDialog(
                                                                          title:
                                                                              const Text('Confirmation!!'),
                                                                          content:
                                                                              const Text('Do you received your product?'),
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                                Utils.flutterToast('Please wait approximately 4 days');
                                                                              },
                                                                              child: Text('Not Now'),
                                                                            ),
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                                receivedFunc(productUid: data.cartUid.toString());
                                                                              },
                                                                              child: const Text('Yes Received'),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    });
                                                              },
                                                              btnText:
                                                                  'Received',
                                                              btnColor:
                                                                  Colors.blue),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              );
                      }),
            ),
          ],
        ),
      ),
    );
  }

  void receivedFunc({required String productUid}) async {
    if (loading1 == false) {
      setState(() {
        loading1 = true;
      });
      await _firebaseFireStore
          .collection("Cart")
          .doc(_currentUser.toString())
          .collection("YourCart")
          .doc(productUid)
          .update({
        'pleaseWait': 'To Review',
        // 'SellerStatus': 'false',
      }).then((value) {
        setState(() {
          loading1 = false;
        });
        showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: AlertDialog(
                  title: const Text('Congratulations!!'),
                  content: const Text('Do you want to give review'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Not Now'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MyReviewsTabBar(iniIndex: 0)));
                      },
                      child: const Text('Review'),
                    ),
                  ],
                ),
              );
            });
      }).onError((error, stackTrace) {
        Utils.flutterToast(error.toString());
        setState(() {
          loading1 = false;
        });
      });
    } else {
      Utils.flutterToast('please wait');
    }
  }
}
