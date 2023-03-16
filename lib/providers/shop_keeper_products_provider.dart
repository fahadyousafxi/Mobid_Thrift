import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobidthrift/models/Product_Model.dart';

class ShopKeeperProductsProvider with ChangeNotifier {
  ProductModel? productModel;

  List<ProductModel> searchProductsList = [];

  productModels(QueryDocumentSnapshot element) {
    productModel = ProductModel(
      productImage1: element.get("productImage1"),
      productShopkeeperUid: element.get("productShopkeeperUid"),
      productName: element.get("productName"),
      productDescription: element.get("productDescription"),
      productCurrentBid: element.get("productCurrentBid"),
      productUid: element.get("productUid"),
      productCollectionName: element.get("productCollectionName"),
      productPTAApproved: element.get("productPTAApproved"),
      productShipping: element.get("productShipping"),
      productSpecification: element.get("productSpecification"),
      productPrice: element.get("productPrice"),
      // imagesList: element.get("myList2"),
      // bidDateTimeLeft: element.get("bidDateTimeLeft"),
    );
    searchProductsList.add(productModel!);
  }

  ///********************** Cell Phones Products *********************///

  List<ProductModel> cellPhonesProductsList = [];
  fitchCellPhonesProducts(String? uId) async {
    List<ProductModel> newList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("CellPhonesProducts")
        .where('productShopkeeperUid', isEqualTo: uId)
        .get();

    for (var element in snapshot.docs) {
      productModels(element);
      // productModel = ProductModel(
      //   productImage1: element.get("productImage1"),
      //   productName: element.get("productName"),
      //   productDescription: element.get("productDescription"),
      //   productCurrentBid: element.get("productCurrentBid"),
      //   // bidDateTimeLeft: element.get("bidDateTimeLeft"),
      // );
      newList.add(productModel!);
    }
    cellPhonesProductsList = newList;
    notifyListeners();
  }

  List<ProductModel> get getCellPhonesProductsList {
    return cellPhonesProductsList;
  }

  ///********************** Pads Tablets Products *********************///

  List<ProductModel> padsTabletsProductsList = [];

  fitchPadsTabletsProducts(String? uId) async {
    List<ProductModel> newList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("PadsAndTabletsProducts")
        .where('productShopkeeperUid', isEqualTo: uId)
        .get();

    for (var element in snapshot.docs) {
      productModels(element);
      newList.add(productModel!);
    }
    padsTabletsProductsList = newList;
    notifyListeners();
  }

  List<ProductModel> get getPadsTabletsProductsList {
    return padsTabletsProductsList;
  }

  ///********************** Laptops Products *********************///

  List<ProductModel> laptopsProductsList = [];

  fitchLaptopsProducts(String? uId) async {
    List<ProductModel> newList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("LaptopsProducts")
        .where('productShopkeeperUid', isEqualTo: uId)
        .get();

    for (var element in snapshot.docs) {
      productModels(element);
      newList.add(productModel!);
    }

    laptopsProductsList = newList;
    notifyListeners();
  }

  List<ProductModel> get getLaptopsProductsList {
    return laptopsProductsList;
  }

  ///********************** Smart Watches Products *********************///

  List<ProductModel> smartWatchesProductsList = [];

  fitchSmartWatchesProducts(String? uId) async {
    List<ProductModel> newList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("SmartWatches")
        .where('productShopkeeperUid', isEqualTo: uId)
        .get();

    for (var element in snapshot.docs) {
      productModels(element);
      newList.add(productModel!);
    }
    smartWatchesProductsList = newList;
    notifyListeners();
  }

  List<ProductModel> get getSmartWatchesProductsList {
    return smartWatchesProductsList;
  }

  ///********************** Desktops Products *********************///

  List<ProductModel> desktopsProductsList = [];

  fitchDesktopsProducts(String? uId) async {
    List<ProductModel> newList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("Desktops")
        .where('productShopkeeperUid', isEqualTo: uId)
        .get();

    for (var element in snapshot.docs) {
      productModels(element);
      newList.add(productModel!);
    }
    desktopsProductsList = newList;
    notifyListeners();
  }

  List<ProductModel> get getDesktopsProductsList {
    return desktopsProductsList;
  }

  ///********************** Accessories Products *********************///

  List<ProductModel> accessoriesProductsList = [];

  fitchAccessoriesProducts(String? uId) async {
    List<ProductModel> newList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("Accessories")
        .where('productShopkeeperUid', isEqualTo: uId)
        .get();

    for (var element in snapshot.docs) {
      productModels(element);
      newList.add(productModel!);
    }
    accessoriesProductsList = newList;
    notifyListeners();
  }

  List<ProductModel> get getAccessoriesProductsList {
    return accessoriesProductsList;
  }

  ///********************** Parts Products *********************///

  List<ProductModel> partsProductsList = [];

  fitchPartsProducts(String? uId) async {
    List<ProductModel> newList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("Parts")
        .where('productShopkeeperUid', isEqualTo: uId)
        .get();

    for (var element in snapshot.docs) {
      productModels(element);
      newList.add(productModel!);
    }
    partsProductsList = newList;
    notifyListeners();
  }

  List<ProductModel> get getPartsProductsList {
    return partsProductsList;
  }

  ///********************** Search Products *********************///

  List<ProductModel> get getSearchProductsList {
    return searchProductsList;
  }
}
