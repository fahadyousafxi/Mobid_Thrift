class ChatsModel {
  String? userName;
  String? adminName;
  String? userUid;
  String? adminUid;
  String? roomUid;
  String? adminPhoto;
  String? sellerPhoto;
  String? userEmail;
  String? adminEmail;
  String? lastMessage;
  int? lastMessageTime;
  bool? seenMessage;

  ChatsModel({
    this.lastMessageTime,
    this.lastMessage,
    this.seenMessage,
    this.userEmail,
    this.adminEmail,
    this.adminPhoto,
    this.adminUid,
    this.adminName,
    this.userUid,
    this.userName,
    this.sellerPhoto,
    this.roomUid,
  });

  // String? buyerName;
  // String? sellerName;
  // String? buyerUid;
  // String? sellerUid;
  // String? roomUid;
  // String? sellerPhoto;
  // String? buyerPhoto;
  // String? userEmail;
  // String? sellerEmail;
  //
  // ChatsModel({
  //   this.userEmail,
  //   this.sellerEmail,
  //   this.sellerPhoto,
  //   this.sellerUid,
  //   this.sellerName,
  //   this.buyerUid,
  //   this.buyerName,
  //   this.buyerPhoto,
  //   this.roomUid,
  // });
}
