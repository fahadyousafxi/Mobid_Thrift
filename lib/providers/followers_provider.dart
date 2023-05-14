import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/followers_model.dart';

class FollowersProvider with ChangeNotifier {
  final currentUser = FirebaseAuth.instance.currentUser!.uid.toString();

  ///******************************  followings  ******************************///
  List<FollowersModel> followingsDataList = [];

  void getFollowingsData() async {
    List<FollowersModel> newList = [];
    QuerySnapshot followingsData = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser)
        .collection("Followings")
        .get();

    for (var element in followingsData.docs) {
      FollowersModel followersModel = FollowersModel(
        followingUid: element.get("Following"),
      );
      newList.add(followersModel);
    }
    followingsDataList = newList;
    notifyListeners();
  }

  List<FollowersModel> get getFollowingsDataList {
    return followingsDataList;
  }
}
