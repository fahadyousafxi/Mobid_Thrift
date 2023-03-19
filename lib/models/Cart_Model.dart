class CartModel {
  String? cartImage1;
  String? cartImage2;
  String? cartImage3;
  String? cartImage4;
  String? cartImage5;
  String? cartImage6;
  String? cartCollectionName;
  String? cartName;
  String? cartDescription;
  String? cartSpecification;
  String? cartUid;
  String? cartShopkeeperUid;
  String? pleaseWait;
  String? sellerStatus;
  int? cartCurrentBid;
  int? cartShipping;
  int? cartPrice;
  DateTime? cartDateTime;
  DateTime? bidDateTimeLeft;
  bool? cartPTAApproved;

  // String? productImage1;
  // String? productImage2;
  // String? productImage3;
  // String? productImage4;
  // String? productImage5;
  // String? productImage6;
  // String? productCollectionName;
  // String? productName;
  // String? productDescription;
  // String? productSpecification;
  // String? productUid;
  // String? productShopkeeperUid;
  // int? productCurrentBid;
  // int? bidEndTimeInSeconds;
  // int? productShipping;
  // int? productPrice;
  // DateTime? productDateTime;
  // DateTime? bidDateTimeLeft;
  // bool? productPTAApproved;
  // bool? isStartingBid;
  // List<String>? imagesList;

  CartModel({
    this.cartImage1,
    this.cartImage2,
    this.cartImage3,
    this.cartImage4,
    this.cartImage5,
    this.cartImage6,
    this.pleaseWait,
    required this.cartCollectionName,
    this.sellerStatus,
    this.cartName,
    this.cartDescription,
    this.cartSpecification,
    this.cartUid,
    this.cartShopkeeperUid,
    this.cartCurrentBid,
    this.cartShipping,
    this.cartPrice,
    this.cartDateTime,
    this.bidDateTimeLeft,
    this.cartPTAApproved,
    // this.isStartingBid,
    // this.bidEndTimeInSeconds,
    // this.imagesList,
    // this.productCollectionName,
    // this.productImage1,
    // this.productImage2,
    // this.productImage3,
    // this.productImage4,
    // this.productImage5,
    // this.productImage6,
    // this.productName,
    // this.productDescription,
    // this.productSpecification,
    // this.productUid,
    // this.productShopkeeperUid,
    // this.productCurrentBid,
    // this.productShipping,
    // this.productPrice,
    // this.productDateTime,
    // this.bidDateTimeLeft,
    // this.productPTAApproved,
  });
}
