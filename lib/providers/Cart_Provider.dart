import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/models/Cart_Model.dart';

class CartProvider with ChangeNotifier {

  final currentUser = FirebaseAuth.instance.currentUser!.uid.toString();

  void addCartData(
      {String? cartImage1,
      String? cartImage2,
      String? cartImage3,
      String? cartImage4,
      String? cartImage5,
      String? cartImage6,
      String? cartCollectionName,
      String? cartName,
      String? cartDescription,
      String? cartSpecification,
      String? cartUid,
      String? cartShopkeeperUid,
      int? cartCurrentBid,
      int? cartShipping,
      int? cartPrice,
      DateTime? cartDateTime,
      DateTime? bidDateTimeLeft,
      bool? cartPTAApproved}) async {
    FirebaseFirestore.instance
        .collection("Cart")
        .doc(currentUser)
        .collection("YourCart")
        .doc(cartUid)
        .set(
        {
          "cartImage1" : cartImage1,
          "cartImage2" : cartImage2,
          "cartImage3" : cartImage3,
          "cartImage4" : cartImage4,
          "cartImage5" : cartImage5,
          "cartImage6" : cartImage6,
          "cartCollectionName" : cartCollectionName,
          "cartName" : cartName,
          "cartDescription" : cartDescription,
          "cartSpecification" : cartSpecification,
          "cartUid" : cartUid,
          "cartShopkeeperUid" : cartShopkeeperUid,
          "cartCurrentBid" : cartCurrentBid,
          "cartShipping" : cartShipping,
          "cartPrice" : cartPrice,
          "cartDateTime" : cartDateTime,
          "bidDateTimeLeft" : bidDateTimeLeft,
          "cartPTAApproved" : cartPTAApproved
        });
  }


  ///******************************  Cart  ******************************///
  List<CartModel> cartDataList = [];

  void getCartData() async {
    List<CartModel> newList = [];
    QuerySnapshot cartData = await FirebaseFirestore.instance.collection("Cart").doc("piSXciiY4fWltCxv75NfUtAEW5f2").collection("YourCart").get();

    for (var element in cartData.docs) {
      CartModel cartModel = CartModel(
          cartImage1: element.get("cartImage1"),
          cartName: element.get("cartName"),
          cartDescription: element.get("cartDescription"),
          cartCurrentBid: element.get("cartCurrentBid"),
          cartUid: element.get("cartUid"),
      );
      newList.add(cartModel);
    }
    cartDataList = newList;
    notifyListeners();
  }

  List<CartModel> get getCartDataList {
    return cartDataList;
  }

}
