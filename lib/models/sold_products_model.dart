class SoldProductsModel {
  String? productImage1;
  String? productCollectionName;
  String? productName;
  String? productDescription;
  String? productSpecification;
  String? productUid;
  String? buyerUid;
  String? shopkeeperUid;
  String? sellerStatus;
  int? productCurrentBid;
  int? bidEndTimeInSeconds;
  int? productShipping;
  int? productPrice;
  DateTime? productDateTime;
  DateTime? bidDateTimeLeft;
  bool? productPTAApproved;
  bool? isStartingBid;
  List<String>? imagesList;

  SoldProductsModel({
    this.isStartingBid,
    this.bidEndTimeInSeconds,
    this.imagesList,
    this.productCollectionName,
    this.productImage1,
    required this.productName,
    this.sellerStatus,
    this.productDescription,
    this.productSpecification,
    this.productUid,
    this.shopkeeperUid,
    this.buyerUid,
    this.productCurrentBid,
    this.productShipping,
    this.productPrice,
    this.productDateTime,
    this.bidDateTimeLeft,
    this.productPTAApproved,
  });
}
