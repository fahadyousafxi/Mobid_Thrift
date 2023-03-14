import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobidthrift/models/Product_Model.dart';

class TradeInProvider with ChangeNotifier {
  ProductModel? productModel;

  final String _auth = FirebaseAuth.instance.currentUser!.uid.toString();
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
  fitchCellPhonesProducts() async {
    List<ProductModel> newList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('TradeInProducts')
        .doc('FrY6ftMAx233dpQTwZac')
        .collection("CellPhonesProducts")
        .where('productShopkeeperUid', isEqualTo: _auth)
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

  fitchPadsTabletsProducts() async {
    List<ProductModel> newList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('TradeInProducts')
        .doc('FrY6ftMAx233dpQTwZac')
        .collection("PadsAndTabletsProducts")
        .where('productShopkeeperUid', isEqualTo: _auth)
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

  fitchLaptopsProducts() async {
    List<ProductModel> newList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('TradeInProducts')
        .doc('FrY6ftMAx233dpQTwZac')
        .collection("LaptopsProducts")
        .where('productShopkeeperUid', isEqualTo: _auth)
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

  fitchSmartWatchesProducts() async {
    List<ProductModel> newList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('TradeInProducts')
        .doc('FrY6ftMAx233dpQTwZac')
        .collection("SmartWatches")
        .where('productShopkeeperUid', isEqualTo: _auth)
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

  fitchDesktopsProducts() async {
    List<ProductModel> newList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('TradeInProducts')
        .doc('FrY6ftMAx233dpQTwZac')
        .collection("Desktops")
        .where('productShopkeeperUid', isEqualTo: _auth)
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

  fitchAccessoriesProducts() async {
    List<ProductModel> newList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('TradeInProducts')
        .doc('FrY6ftMAx233dpQTwZac')
        .collection("Accessories")
        .where('productShopkeeperUid', isEqualTo: _auth)
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

  fitchPartsProducts() async {
    List<ProductModel> newList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('TradeInProducts')
        .doc('FrY6ftMAx233dpQTwZac')
        .collection("Parts")
        .where('productShopkeeperUid', isEqualTo: _auth)
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
