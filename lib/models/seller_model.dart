class SellerModel {
  String? name;
  String? email;
  String? address;
  String? cNICImage1;
  String? cNICImage2;
  String? cNICNumber;
  String? phoneNumber;
  String? plazaName;
  String? profileImage;
  String? shopImage;
  String? shopNumber;
  int? totalNumberOfReviews;
  int? totalReviewRating;
  String? uId;
  bool? verification;

  SellerModel({
    this.uId,
    this.name,
    this.verification,
    this.shopImage,
    this.address,
    this.email,
    this.cNICImage1,
    this.cNICImage2,
    this.cNICNumber,
    this.phoneNumber,
    this.plazaName,
    this.profileImage,
    this.shopNumber,
    this.totalNumberOfReviews,
    this.totalReviewRating,
  });
}
