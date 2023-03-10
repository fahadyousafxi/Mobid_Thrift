import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobidthrift/models/seller_model.dart';

class SellerProvider with ChangeNotifier {
  List<SellerModel> sellerDataList = [];

  void getSellerData(String productShopkeeperUid) async {
    List<SellerModel> newList = [];
    QuerySnapshot sellerData = await FirebaseFirestore.instance
        .collection("Cart")
        .doc(productShopkeeperUid.toString())
        .collection("YourCart")
        .get();

    for (var element in sellerData.docs) {
      SellerModel cartModel = SellerModel(
        name: element.get("Name"),
        // cartName: element.get("cartName"),
        // cartDescription: element.get("cartDescription"),
        // cartCurrentBid: element.get("cartCurrentBid"),
        // cartUid: element.get("cartUid"),
      );
      newList.add(cartModel);
    }
    sellerDataList = newList;
    notifyListeners();
  }

  List<SellerModel> get getSellerDataList {
    return sellerDataList;
  }
}
