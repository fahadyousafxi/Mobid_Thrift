class CartModel{
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
  int? cartCurrentBid;
  int? cartShipping;
  int? cartPrice;
  DateTime? cartDateTime;
  DateTime? bidDateTimeLeft;
  bool? cartPTAApproved;

  CartModel({
    this.cartImage1,
    this.cartImage2,
    this.cartImage3,
    this.cartImage4,
    this.cartImage5,
    this.cartImage6,
    this.cartCollectionName,
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

  });
}