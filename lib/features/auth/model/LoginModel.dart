import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool status;
  String message;
  LoginData data;

  LoginModel({required this.status, required this.message, required this.data});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    message: json["message"],
    data: LoginData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class LoginData {
  int id;
  String name;
  String address;
  String emailId;
  String contactNo;
  String experience;
  String resume;
  String platform;
  String password;
  int isEmailSent;
  String token;
  String pancardNo;
  String pancardImage;
  dynamic aadhaarCardNo;
  dynamic aadhaarImage;
  String cancelCheckImage;
  String profileImage;
  int countryId;
  int stateId;
  int cityId;
  int isActive;

  LoginData({
    required this.id,
    required this.name,
    required this.address,
    required this.emailId,
    required this.contactNo,
    required this.experience,
    required this.resume,
    required this.platform,
    required this.password,
    required this.isEmailSent,
    required this.token,
    required this.pancardNo,
    required this.pancardImage,
    required this.aadhaarCardNo,
    required this.aadhaarImage,
    required this.cancelCheckImage,
    required this.profileImage,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.isActive,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    id: json["id"],
    name: json["name"] ?? '',
    address: json["address"] ?? '',
    emailId: json["email_id"] ?? '',
    contactNo: json["contact_no"] ?? '',
    experience: json["experience"] ?? '',
    resume: json["resume"] ?? '',
    platform: json["platform"] ?? '',
    password: json["password"] ?? '',
    isEmailSent: json["is_email_sent"],
    token: json["token"] ?? '',
    pancardNo: json["pancard_no"] ?? '',
    pancardImage: json["pancard_image"] ?? '',
    aadhaarCardNo: json["aadhaar_card_no"],
    aadhaarImage: json["aadhaar_image"],
    cancelCheckImage: json["cancel_check_image"],
    profileImage: json["profile_image"],
    countryId: json["country_id"],
    stateId: json["state_id"],
    cityId: json["city_id"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "email_id": emailId,
    "contact_no": contactNo,
    "experience": experience,
    "resume": resume,
    "platform": platform,
    "password": password,
    "is_email_sent": isEmailSent,
    "token": token,
    "pancard_no": pancardNo,
    "pancard_image": pancardImage,
    "aadhaar_card_no": aadhaarCardNo,
    "aadhaar_image": aadhaarImage,
    "cancel_check_image": cancelCheckImage,
    "profile_image": profileImage,
    "country_id": countryId,
    "state_id": stateId,
    "city_id": cityId,
    "is_active": isActive,
  };
}
