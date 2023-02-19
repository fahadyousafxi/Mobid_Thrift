import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/models/Wish_List_Model.dart';

class WishListProvider with ChangeNotifier {

  final currentUser = FirebaseAuth.instance.currentUser!.uid.toString();

  void addToWishList({required String collectionName, required String productUid, required String wishlistUid}) {

    FirebaseFirestore.instance
        .collection("Cart")
        .doc(currentUser)
        .collection("WishList")
        .doc(wishlistUid).set({

      "collectionName": collectionName,
      "productUid": productUid,
      "wishlistUid": wishlistUid

    });

  }

  ///******************************  Wish List  ******************************///
  List<WishListModel> wishListDataList = [];

  void getWishListData() async {
    List<WishListModel> newList = [];
    QuerySnapshot wishListData = await FirebaseFirestore.instance.collection("Cart").doc("piSXciiY4fWltCxv75NfUtAEW5f2").collection("WishList").get();

    for (var element in wishListData.docs) {
      WishListModel wishListModel = WishListModel(
        productUid: element.get("productUid"),
        wishlistUid: element.get("wishlistUid"),
        collectionName: element.get("collectionName"),
      );
      newList.add(wishListModel);
    }
    wishListDataList = newList;
    notifyListeners();
  }


  List<WishListModel> get getWishListDataList {
    return wishListDataList;
  }

}