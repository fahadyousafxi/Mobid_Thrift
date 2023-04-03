import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/chats_model.dart';

class ChatsProvider with ChangeNotifier {
  final currentUser = FirebaseAuth.instance.currentUser!.uid.toString();

  ///******************************  Chats  ******************************///
  List<ChatsModel> chatsDataList = [];

  void getChatsData() async {
    List<ChatsModel> newList = [];
    QuerySnapshot cartData = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser)
        .collection("ChatUsers")
        .get();

    for (var element in cartData.docs) {
      ChatsModel chatsModel = ChatsModel(
        buyerName: element.get("buyerName"),
        buyerPhoto: element.get("buyerPhoto"),
        buyerUid: element.get("buyerUid"),
        roomUid: element.get("roomUId"),
        sellerName: element.get("sellerName"),
        sellerPhoto: element.get("sellerPhoto"),
        sellerUid: element.get("sellerUid"),
        sellerEmail: element.get("sellerEmail"),
        userEmail: element.get("userEmail"),
      );
      newList.add(chatsModel);
    }
    chatsDataList = newList;
    notifyListeners();
  }

  List<ChatsModel> get getChatsDataList {
    return chatsDataList;
  }
}
