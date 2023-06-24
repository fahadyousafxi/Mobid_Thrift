import 'dart:core';

class UsersModel {
  String? name;
  String? email;
  String? userUid;
  String? address;
  String? phoneNumber;
  String? profileImage;
  bool? verification;

  UsersModel(
      {required this.name,
      required this.email,
      this.verification,
      required this.userUid,
      required this.address,
      required this.phoneNumber,
      required this.profileImage});
}
