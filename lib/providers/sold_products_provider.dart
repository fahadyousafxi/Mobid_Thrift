import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/sold_products_model.dart';

class SoldProductsProvider with ChangeNotifier {
  List<SoldProductsModel> soldProductsDataList = [];

  void getSoldProductsData() async {
    List<SoldProductsModel> newList = [];
    QuerySnapshot soldProductsData =
        await FirebaseFirestore.instance.collection("SoldProducts").get();

    for (var element in soldProductsData.docs) {
      SoldProductsModel soldProductsModel = SoldProductsModel(
        productImage1: element.get("ProductImage"),
        productName: element.get("ProductName"),
        productDescription: element.get("ProductDescription"),
        productUid: element.get("ProductUid"),
        shopkeeperUid: element.get("ShopKeeperUid"),
        productPrice: element.get("ProductPrice"),
        productShipping: element.get("ProductShipping"),
        productSpecification: element.get("ProductSpecifications"),
        productPTAApproved: element.get("ProductPTAApproved"),
        buyerUid: element.get("BuyerUid"),
        sellerStatus: element.get("SellerStatus"),
      );
      newList.add(soldProductsModel);
    }
    soldProductsDataList = newList;
    notifyListeners();
  }

  List<SoldProductsModel> get getSoldProductsDataList {
    return soldProductsDataList;
  }
}
