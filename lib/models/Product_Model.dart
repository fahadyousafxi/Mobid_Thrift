class ProductModel {
  String? productImage1;
  String? productImage2;
  String? productImage3;
  String? productImage4;
  String? productImage5;
  String? productImage6;
  String? productCollectionName;
  String? productName;
  String? productDescription;
  String? productSpecification;
  String? productUid;
  String? productShopkeeperUid;
  int? productCurrentBid;
  int? bidEndTimeInSeconds;
  int? productShipping;
  int? productPrice;
  DateTime? productDateTime;
  DateTime? bidDateTimeLeft;
  bool? productPTAApproved;
  List<String>? imagesList;

  ProductModel({
    this.bidEndTimeInSeconds,
    this.imagesList,
    this.productCollectionName,
    this.productImage1,
    this.productImage2,
    this.productImage3,
    this.productImage4,
    this.productImage5,
    this.productImage6,
    this.productName,
    this.productDescription,
    this.productSpecification,
    this.productUid,
    this.productShopkeeperUid,
    this.productCurrentBid,
    this.productShipping,
    this.productPrice,
    this.productDateTime,
    this.bidDateTimeLeft,
    this.productPTAApproved,
  });
}
