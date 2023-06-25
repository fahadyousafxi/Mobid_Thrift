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
        .orderBy('lastMessageTime', descending: true)
        .get();

    for (var element in cartData.docs) {
      ChatsModel chatsModel = ChatsModel(
        // userName: element.get("userName"),
        lastMessage: element.get("lastMessage"),
        lastMessageTime: element.get("lastMessageTime"),
        seenMessage: element.get("seenMessage"),
        sellerPhoto: element.get("sellerPhoto"),
        userUid: element.get("userUid"),
        roomUid: element.get("roomUId"),
        adminName: element.get("adminName"),
        // adminPhoto: element.get("adminPhoto"),
        adminUid: element.get("adminUid"),
        adminEmail: element.get("adminEmail"),
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

  ///******************************  Create New Chats  ******************************///
  List<ChatsModel> createNewChatsDataList = [];

  void getCreateNewChatsData() async {
    List<ChatsModel> newList = [];
    QuerySnapshot chatData =
        await FirebaseFirestore.instance.collection("users").get();

    for (var element in chatData.docs) {
      ChatsModel chatsModel = ChatsModel(
        userName: element.get("username"),
        // userPhoto: element.get("userPhoto"),
        userUid: element.get("userId"),
        // roomUid: element.get("roomUId"),
        // adminName: element.get("adminName"),
        // adminPhoto: element.get("adminPhoto"),
        // adminUid: element.get("adminUid"),
        // adminEmail: element.get("adminEmail"),
        userEmail: element.get("email"),
      );
      newList.add(chatsModel);
    }
    createNewChatsDataList = newList;
    notifyListeners();
  }

  List<ChatsModel> get getCreateNewChatsDataList {
    return createNewChatsDataList;
  }

// final currentUser = FirebaseAuth.instance.currentUser!.uid.toString();
  //
  // ///******************************  Chats  ******************************///
  // List<ChatsModel> chatsDataList = [];
  //
  // void getChatsData() async {
  //   List<ChatsModel> newList = [];
  //   QuerySnapshot cartData = await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(currentUser)
  //       .collection("ChatUsers")
  //       .get();
  //
  //   for (var element in cartData.docs) {
  //     ChatsModel chatsModel = ChatsModel(
  //       buyerName: element.get("buyerName"),
  //       buyerPhoto: element.get("buyerPhoto"),
  //       buyerUid: element.get("buyerUid"),
  //       roomUid: element.get("roomUId"),
  //       sellerName: element.get("sellerName"),
  //       sellerPhoto: element.get("sellerPhoto"),
  //       sellerUid: element.get("sellerUid"),
  //       sellerEmail: element.get("sellerEmail"),
  //       userEmail: element.get("userEmail"),
  //     );
  //     newList.add(chatsModel);
  //   }
  //   chatsDataList = newList;
  //   notifyListeners();
  // }
  //
  // List<ChatsModel> get getChatsDataList {
  //   return chatsDataList;
  // }
}
