class UserModel {
  final String email;
  final String? password;
  final String address;
  final String mobileNo;
  String? id;

  UserModel(
      {required this.email,
        this.password,
      required this.address,
      required this.mobileNo,
      required this.id});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"],
      address: json["address"],
      mobileNo: json["mobileNo"],
      id: json["id"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": this.email,
      "address": this.address,
      "mobileNo": this.mobileNo,
      "id":this.id
    };
  }

}
