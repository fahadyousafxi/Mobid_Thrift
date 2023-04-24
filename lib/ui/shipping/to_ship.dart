import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/providers/Cart_Provider.dart';
import 'package:mobidthrift/ui/Product_Page_of_Cart.dart';
import 'package:provider/provider.dart';

class ToShip extends StatefulWidget {
  const ToShip({Key? key}) : super(key: key);

  @override
  State<ToShip> createState() => _ToShipState();
}

class _ToShipState extends State<ToShip> {
  final _firebaseFireStore = FirebaseFirestore.instance;
  final _currentUser = FirebaseAuth.instance.currentUser!.uid;

  final _auth = FirebaseAuth.instance.currentUser!.uid;
  CartProvider cartProvider = CartProvider();
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
              child: ListView.builder(
                  itemCount: cartProvider.getCartDataList.length,
                  itemBuilder: (context, index) {
                    var data = cartProvider.getCartDataList[index];
                    // for (var i = 0; i <= cartProvider.getCartDataList.length;) {
                    //   price = price + data.cartCurrentBid!.toInt();
                    // }
                    return data.pleaseWait! != 'To Ship'
                        ? SizedBox()
                        : Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11.0),
                            ),
                            child: GestureDetector(
                                onDoubleTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductPageOfCart(
                                                cartName:
                                                    data.cartName.toString(),
                                                cartCurrentBid:
                                                    data.cartCurrentBid,
                                                cartDescription: data
                                                    .cartDescription
                                                    .toString(),
                                                cartUid:
                                                    data.cartUid.toString(),
                                                cartImage1:
                                                    data.cartImage1.toString(),
                                                cartShipping: data.cartShipping,
                                                cartPrice: data.cartPrice,
                                                cartPTAApproved:
                                                    data.cartPTAApproved,
                                                cartShopkeeperUid:
                                                    data.cartShopkeeperUid,
                                                cartSpecification:
                                                    data.cartSpecification,
                                              )));
                                },
                                onTap: () {},
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
                                                SizedBox(
                                                  height: 11,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: const [
                                                    Text(
                                                      'Processing...',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
