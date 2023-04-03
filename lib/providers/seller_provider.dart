import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobidthrift/models/seller_model.dart';
import 'package:mobidthrift/models/seller_review_model.dart';

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

  ///*************************  Reviews  *****************************

  List<SellerReviewsModel> sellerReviewsDataList = [];

  void getSellerReviewsData(String productShopkeeperUid) async {
    List<SellerReviewsModel> newList = [];
    QuerySnapshot sellerReviewsData = await FirebaseFirestore.instance
        .collection("SellerCenterUsers")
        .doc(productShopkeeperUid)
        .collection('Reviews')
        .get();

    for (var element in sellerReviewsData.docs) {
      SellerReviewsModel sellerReviewModel = SellerReviewsModel(
        name: element.get("User_Name"),

        reviewRating: element.get("My_Review_Rating"),
        review: element.get("User_Review"),
        timeInMilliseconds: element.get("Review_Timing_In_Milliseconds"),
        // cartUid: element.get("cartUid"),
      );
      newList.add(sellerReviewModel);
    }
    sellerReviewsDataList = newList;
    notifyListeners();
  }

  List<SellerReviewsModel> get getSellerReviewsDataList {
    return sellerReviewsDataList;
  }
}
