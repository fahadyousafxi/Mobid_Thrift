import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/all_users_model.dart';

class AllUsersProvider with ChangeNotifier {
  ///********************** All Users *********************

  List<UsersModel> usersDataList = [];

  void getUsersData() async {
    List<UsersModel> newList = [];
    QuerySnapshot usersData =
        await FirebaseFirestore.instance.collection("users").get();

    for (var element in usersData.docs) {
      UsersModel soldProductsModel = UsersModel(
        name: element.get("Name"),
        email: element.get("Email"),
        userUid: element.get("Uid"),
        address: element.get("Address"),
        phoneNumber: element.get("Phone_Number"),
        profileImage: element.get("Profile_Image"),
      );
      newList.add(soldProductsModel);
    }
    usersDataList = newList;
    notifyListeners();
  }

  List<UsersModel> get getUsersDataList {
    return usersDataList;
  }
}
